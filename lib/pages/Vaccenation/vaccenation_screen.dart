import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proj_app/pages/Vaccenation/add_vaccen_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class VaccenationScreen extends StatefulWidget {
  const VaccenationScreen({Key? key}) : super(key: key);

  @override
  State<VaccenationScreen> createState() => _VaccenationScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final String? uid = user?.uid;

class _VaccenationScreenState extends State<VaccenationScreen> {
  CollectionReference vaccenCollection =
  FirebaseFirestore.instance.collection('vaccenations');
  CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> deleteVaccen(String docId) async {
    await vaccenCollection.doc(docId).delete();
  }

  late String username = 'loading...';
  late String gender = 'unknown';

  Future<void> getUserData() async {
    if (uid != null) {
      final DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic> userData =
      userDoc.data() as Map<String, dynamic>;
      setState(() {
        username = userData['username'];
        gender = userData['gender'] ?? 'unknown';
      });
      print('Email: ${userData['email']}');
      print('Username: ${userData['username']}');
      print('Gender: $gender');
    } else {
      print('No user is currently signed in.');
    }
  }

  Future<void> _scheduleNotification(
      String vaccineName, DateTime scheduleDate) async {
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(scheduleDate, tz.local);

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'vaccenation_channel_id',
      'Vaccenation Reminders',
      channelDescription: 'Reminders for scheduled vaccinations',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails generalNotificationDetails =
    NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Vaccenation Reminder',
      'It\'s time for your $vaccineName vaccine.',
      scheduledDate,
      generalNotificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  void initState() {
    super.initState();
    getUserData();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? uid = user?.uid;

    Color backgroundColor = gender == 'Boy'
        ? Colors.blue[300]!
        : gender == 'Girl'
        ? Colors.pink[300]!
        : Colors.grey[300]!;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddVaccenScreen((newVaccenData) {
                  if (newVaccenData['name'].trim().isNotEmpty &&
                      newVaccenData['date'] != null) {
                    vaccenCollection.add({
                      'uid': uid,
                      'name': newVaccenData['name'],
                      'doses': newVaccenData['doses'],
                      'date': newVaccenData['date'],
                    });
                    _scheduleNotification(
                      newVaccenData['name'],
                      newVaccenData['date'],
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill all fields'),
                      ),
                    );
                  }
                }),
              ),
            ),
          );
        },
        backgroundColor: gender == 'Boy'
            ? Colors.indigo[800]!
            : gender == 'Girl'
            ? Colors.grey[800]!
            : Colors.grey[300]!,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add Vaccenation',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: Text(
          'Vaccenation',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 3, left: 20, right: 20, bottom: 80),
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: userCollection.doc(uid).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data?.data() == null) {
                  return Text('No baby data found.');
                }

                List babies = (snapshot.data!.data() as Map)['babies'] ?? [];

                return Center(
                  child: Container(height: 100,
                    child: PageView.builder(
                      itemCount: babies.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> baby = babies[index];

                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'asset/images/baby.jpg'), // Replace with your image URL
                                radius: 35,
                              ),
                              SizedBox(
                                  width:
                                  10), // Add some spacing between the image and the text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    baby['name'] ?? '',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Weight: ${baby['weight']} kg',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      50), // 50% of the width/height for a perfect circle
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.only(top: 13.0, left: 10, right: 10, bottom: 20),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: vaccenCollection.where('uid', isEqualTo: uid).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot document = snapshot.data!.docs[index];
                          final String vaccenTitle = document['name'];
                          final int doses = document['doses'];
                          final DateTime date = document['date'].toDate();
                          final String docId = document.id;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Dismissible(
                              key: Key(docId),
                              direction: DismissDirection.startToEnd,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(right: 30.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                return true;
                              },
                              onDismissed: (direction) {
                                deleteVaccen(docId);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      40), // Adjust this value as needed
                                ),
                                color: Colors.grey[100],
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          vaccenTitle,
                                          style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => deleteVaccen(docId),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          'Doses: $doses',
                                        ),
                                      ),
                                      Text(
                                        'Date: ${DateFormat('yyyy-MM-dd').format(date)}',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          'Your Doses: ',
                                        ),
                                      ),
                                      Center(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: List.generate(
                                              doses,
                                                  (index) => _buildDoseCircle(
                                                docId,
                                                doses,
                                                index + 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoseCircle(String docId, int doses, int doseNumber) {
    return GestureDetector(
      onTap: () {
        if (doses >= doseNumber) {
          _decreaseDose(docId, doses);
        } else {
          _increaseDose(docId, doses);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: CircleAvatar(
          radius: 15,
          backgroundColor: doses >= doseNumber ? Colors.grey : Colors.green,
          child: Text(
            doseNumber.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
  Future<void> _increaseDose(String docId, int doses) async {
    await vaccenCollection.doc(docId).update({'doses': doses + 1});
  }

  Future<void> _decreaseDose(String docId, int doses) async {
    if (doses > 0) {
      await vaccenCollection.doc(docId).update({'doses': doses - 1});
    }
  }
}
