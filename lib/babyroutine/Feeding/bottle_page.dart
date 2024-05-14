import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FeedingBottle extends StatefulWidget {
  const FeedingBottle({Key? key}) : super(key: key);

  @override
  State<FeedingBottle> createState() => _FeedingBottleState();
}

class _FeedingBottleState extends State<FeedingBottle> {
  final TextEditingController _feedController = TextEditingController();
  final CollectionReference _feedCollection = FirebaseFirestore.instance.collection('feeds');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  List<Feed> feeds = [];
  int _totalQuantity = 0;

  @override
  void initState() {
    super.initState();
    initNotifications();
    _feedCollection.doc(_auth.currentUser!.uid).collection('user_feeds').snapshots().listen(_updateFeedList);
  }

  Future<void> initNotifications() async {
    var androidSettings = AndroidInitializationSettings('@drawable/ic_launcher');
    var initSettings = InitializationSettings(android: androidSettings);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  void _updateFeedList(QuerySnapshot<Map<String, dynamic>> snapshot) {
    feeds = snapshot.docs.map((doc) => Feed.fromSnapshot(doc)).toList();
    _calculateTotalQuantity();
  }

  void _calculateTotalQuantity() {
    int newTotal = feeds.fold(0, (sum, feed) => sum + int.parse(feed.type));
    if (_totalQuantity != newTotal) {
      setState(() {
        _totalQuantity = newTotal;
      });
      _checkTotalQuantityAndNotify();
    }
  }

  void _checkTotalQuantityAndNotify() {
    if (_totalQuantity == 150) {
      // Trigger notification and pop-up when the total reaches or exceeds 150ml, but only if the total is not zero.
      _showNotification('Good job!', 'You have reached 150ml of milk. Great work!');
      _showGoodJobPop();
    }
    else   if (_totalQuantity > 150) {
      // Trigger a "Good job!" notification when the total exceeds 150ml.
      _showNotification('Good job!', 'You have exceeded 150ml of milk. Great work!');
    }
    else if (_totalQuantity > 0 && _totalQuantity < 150) {
      // Trigger notification only if there is some milk but less than 150ml.
      _showNotification('Feed the Baby!', 'There is only ${150 - _totalQuantity} ml of milk remaining to reach 150ml. Please feed the baby after 3 hour!');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Remember: Babies should drink 150ml of milk per day',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total Milk: $_totalQuantity ml of 150ml', style: TextStyle(fontSize: 20,color: Colors.black87, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: _feedsListWidget(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: _showAddFeedDialog,
                    style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                    child: Text("Add Feed", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ),
              Expanded(
                flex: 2,

                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _clearAllFeeds,
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Text("Clear All", style: TextStyle(color: Colors.white, fontSize: 13)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3), // Added space between buttons and note

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Note: Remember to clear the feed if it's a new day to calculate the milk intake for the day.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          SizedBox(height: 10), // Added space between buttons and note

        ],
      ),
    );
  }

  Widget _feedsListWidget() {
    return StreamBuilder(
      stream: _feedCollection.doc(_auth.currentUser!.uid).collection('user_feeds').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          feeds = snapshot.data!.docs.map((doc) => Feed(id: doc.id, type: doc['type'], timestamp: doc['timestamp'].toDate())).toList();
          _totalQuantity = feeds.fold(0, (sum, feed) => sum + int.parse(feed.type));
          return feeds.isEmpty ? _noFeedsWidget() : ListView.builder(
            itemCount: feeds.length,
            itemBuilder: (context, index) {
              final formattedDate = DateFormat.yMd().add_jm().format(feeds[index].timestamp);
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text('${feeds[index].type} ml', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Date: $formattedDate', style: TextStyle(color: Colors.grey)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteFeed(index),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _noFeedsWidget() {
    return Center(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: 30.7,
            child: Image.asset(
              'asset/images/baby-bottle.png',
              color: Colors.grey,
              scale: 0.5,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "No Feed to Show",
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ],
      ),
    );
  }

  void _showAddFeedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Feed'),
          content: TextField(
            controller: _feedController,
            decoration: InputDecoration(hintText: 'Enter feed amount in ml'),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _addFeed();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addFeed() {
    if (_feedController.text.isNotEmpty) {
      int feedAmount = int.tryParse(_feedController.text) ?? 0;
      if (feedAmount > 0) {
        _feedCollection.doc(_auth.currentUser!.uid).collection('user_feeds').add({
          'type': _feedController.text,
          'timestamp': Timestamp.now(),
        }).then((_) {
          setState(() {
            _feedController.clear();
          });
        });
      }
    }
  }

  void _deleteFeed(int index) {
    _feedCollection.doc(_auth.currentUser!.uid).collection('user_feeds').doc(feeds[index].id).delete().then((_) {
      setState(() {
        feeds.removeAt(index);
        _totalQuantity = feeds.fold(0, (sum, feed) => sum + int.parse(feed.type));
      });
    });
  }
  Future<void> _clearAllFeeds() async {
    try {
      QuerySnapshot querySnapshot = await _feedCollection.doc(_auth.currentUser!.uid).collection('user_feeds').get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      // Optionally, you can reset the local state as well
      setState(() {
        feeds.clear();
        _totalQuantity = 0;
      });
    } catch (e) {
      print("Failed to clear feeds: $e");
    }
  }

  void _showNotification(String title, String body) async {
    var androidDetails = AndroidNotificationDetails(
      'feeding_id',
      'Feeding Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    var generalNotificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,  // Notification ID
      title,
      body,
      generalNotificationDetails,
    );
  }

  void _showGoodJobPop() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Good Job!'),
          content: Text('Congratulations! You have reached 150ml of milk. Keep up the good work!'),
          actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('OK'))],
        );
      },
    );
  }
}

class Feed {
  final String id;
  final String type;
  final DateTime timestamp;

  Feed({required this.id, required this.type, required this.timestamp});

  factory Feed.fromSnapshot(QueryDocumentSnapshot doc) {
    return Feed(
      id: doc.id,
      type: doc['type'],
      timestamp: (doc['timestamp'] as Timestamp).toDate(),
    );
  }
}
