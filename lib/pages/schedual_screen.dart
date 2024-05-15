import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import '../main.dart';

class TodoItem {
  String todo;
  DateTime dateTime;
  bool isCompleted;
  int itemNumber;

  TodoItem({
    required this.todo,
    required this.dateTime,
    this.isCompleted = false,
    required this.itemNumber,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      todo: json['todo'],
      dateTime: DateTime.parse(json['dateTime']),
      isCompleted: json['isCompleted'],
      itemNumber: json['itemNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todo': todo,
      'dateTime': dateTime.toIso8601String(),
      'isCompleted': isCompleted,
      'itemNumber': itemNumber,
    };
  }
}

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final CollectionReference todoCollection = FirebaseFirestore.instance.collection('todos');
  final TextEditingController todoController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadData();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    if (await Permission.scheduleExactAlarm.request().isGranted) {
      // Permission granted.
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (pickedTime != null && pickedTime != selectedTime) {
        setState(() {
          selectedTime = pickedTime;
        });
        _showTodoInputDialog(context);
      }
    }
  }

  Future<void> _showTodoInputDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add ToDo'),
          content: TextField(
            controller: todoController,
            decoration: InputDecoration(labelText: 'ToDo'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Save'),
              onPressed: () {
                _saveData();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      int itemCount = await _getTodoCount(user.uid);
      int nextItemNumber = itemCount + 1;

      TodoItem newItem = TodoItem(
        todo: todoController.text,
        dateTime: DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        ),
        itemNumber: nextItemNumber,
      );

      await todoCollection.doc(user.uid).collection('user_todos').add(newItem.toJson());

      _scheduleNotification(newItem);

      String formattedDate = DateFormat('yMMMMd').format(newItem.dateTime);
      String formattedTime = DateFormat('jm').format(newItem.dateTime);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Schedule and ToDo Saved. You will be reminded on $formattedDate at $formattedTime.'),
          duration: Duration(seconds: 5),
        ),
      );

      /*
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Reminder Set'),
            content: Text('You will be reminded about "${newItem.todo}" on $formattedDate at $formattedTime.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      */
    }
  }

  Future<void> _scheduleNotification(TodoItem todoItem) async {
    var scheduledNotificationDateTime = tz.TZDateTime.from(
      todoItem.dateTime,
      tz.local,
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      todoItem.itemNumber,
      'Reminder for your ToDo',
      todoItem.todo,
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<int> _getTodoCount(String userId) async {
    QuerySnapshot querySnapshot = await todoCollection.doc(userId).collection('user_todos').get();
    return querySnapshot.size;
  }

  Future<void> _loadData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      todoCollection.doc(user.uid).collection('user_todos').snapshots().listen((snapshot) {
        setState(() {
          todoList = snapshot.docs.map((doc) => TodoItem.fromJson(doc.data() as Map<String, dynamic>)).toList();
        });
      });
    }
  }

  List<TodoItem> todoList = [];

  Future<void> _updateTodoCompletion(TodoItem todoItem) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final docSnapshot = await todoCollection.doc(user.uid).collection('user_todos').where('itemNumber', isEqualTo: todoItem.itemNumber).get();

      if (docSnapshot.docs.isNotEmpty) {
        final docId = docSnapshot.docs.first.id;
        await todoCollection.doc(user.uid).collection('user_todos').doc(docId).update({'isCompleted': todoItem.isCompleted});

        print('the todo complete $todoItem   ${todoItem.isCompleted}');
      } else {
        print('Document not found');
      }
    }
  }

  Future<void> _deleteTodoItem(TodoItem todoItem) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final docSnapshot = await todoCollection.doc(user.uid).collection('user_todos').where('itemNumber', isEqualTo: todoItem.itemNumber).get();

      if (docSnapshot.docs.isNotEmpty) {
        final docId = docSnapshot.docs.first.id;
        await todoCollection.doc(user.uid).collection('user_todos').doc(docId).delete();

        setState(() {
          todoList.remove(todoItem);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Todo item deleted'),
          ),
        );
      } else {
        print('Document not found');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            TodoItem todoItem = todoList[index];
            return Card(
              elevation: 3,
              child: ListTile(
                leading: Checkbox(
                  value: todoItem.isCompleted,
                  onChanged: (bool? value) async {
                    setState(() {
                      todoItem.isCompleted = value ?? false;
                    });
                    await _updateTodoCompletion(todoItem);
                  },
                ),
                title: Text(
                  todoItem.todo,
                  style: TextStyle(
                    decoration: todoItem.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
                subtitle: Text(
                  'Date & Time: ${todoItem.dateTime.year}-${todoItem.dateTime.month}-${todoItem.dateTime.day} ${todoItem.dateTime.hour}:${todoItem.dateTime.minute}',
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await _deleteTodoItem(todoItem);
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _selectDateTime(context),
        tooltip: 'Add Schedule',
        child: Icon(Icons.add),
      ),
    );
  }
}
