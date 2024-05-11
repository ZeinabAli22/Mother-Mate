import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TodoItem {
  String todo;
  DateTime dateTime;
  bool isCompleted;
  int itemNumber; // New field for the sequential number

  TodoItem({
    required this.todo,
    required this.dateTime,
    this.isCompleted = false,
    required this.itemNumber, // Ensure the sequential number is required
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      todo: json['todo'],
      dateTime: DateTime.parse(json['dateTime']),
      isCompleted: json['isCompleted'],
      itemNumber: json['itemNumber'], // Add itemNumber field from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todo': todo,
      'dateTime': dateTime.toIso8601String(),
      'isCompleted': isCompleted,
      'itemNumber': itemNumber, // Include itemNumber field in JSON
    };
  }
}

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final CollectionReference todoCollection =
  FirebaseFirestore.instance.collection('todos');
  final TextEditingController todoController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadData();
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
      // Get the current count of todo items
      int itemCount = await _getTodoCount(user.uid);

      // Increment the count to generate the next sequential number
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
        itemNumber: nextItemNumber, // Add the sequential number to the todo item
      );

      // Save the todo item with an auto-generated document ID
      await todoCollection
          .doc(user.uid)
          .collection('user_todos')
          .add(newItem.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Schedule and ToDo Saved'),
        ),
      );
    }
  }

  Future<int> _getTodoCount(String userId) async {
    // Query the collection to get the count of existing todo items
    QuerySnapshot querySnapshot = await todoCollection
        .doc(userId)
        .collection('user_todos')
        .get();

    // Return the count of documents
    return querySnapshot.size;
  }

  Future<void> _loadData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      todoCollection
          .doc(user.uid)
          .collection('user_todos')
          .snapshots()
          .listen((snapshot) {
        setState(() {
          todoList = snapshot.docs
              .map((doc) => TodoItem.fromJson(doc.data() as Map<String, dynamic>))
              .toList();
        });
      });
    }
  }

  List<TodoItem> todoList = [];

  Future<void> _updateTodoCompletion(TodoItem todoItem) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      // Check if the document exists before updating
      final docSnapshot = await todoCollection
          .doc(user.uid)
          .collection('user_todos')
          .where('itemNumber', isEqualTo: todoItem.itemNumber)
          .get();

      if (docSnapshot.docs.isNotEmpty) {
        // Update the todo item's completion status in Firestore
        final docId = docSnapshot.docs.first.id;
        await todoCollection
            .doc(user.uid)
            .collection('user_todos')
            .doc(docId)
            .update({'isCompleted': todoItem.isCompleted});

        print('the todo complete $todoItem   ${todoItem.isCompleted}');
      } else {
        print('Document not found');
      }
    }
  }
  Future<void> _deleteTodoItem(TodoItem todoItem) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final docSnapshot = await todoCollection
          .doc(user.uid)
          .collection('user_todos')
          .where('itemNumber', isEqualTo: todoItem.itemNumber)
          .get();

      if (docSnapshot.docs.isNotEmpty) {
        final docId = docSnapshot.docs.first.id;
        await todoCollection
            .doc(user.uid)
            .collection('user_todos')
            .doc(docId)
            .delete();

        // Remove the deleted item from the local list
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
                    decoration: todoItem.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
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
