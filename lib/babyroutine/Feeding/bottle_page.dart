import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FeedingBottle extends StatefulWidget {
  const FeedingBottle({Key? key}) : super(key: key);

  @override
  State<FeedingBottle> createState() => _FeedingBottleState();
}

class _FeedingBottleState extends State<FeedingBottle> {
  final TextEditingController _feedController = TextEditingController();
  final CollectionReference _feedCollection =
  FirebaseFirestore.instance.collection('feeds');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Feed> feeds = []; // List to store the loaded feeds

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: StreamBuilder(
            stream: _feedCollection
                .doc(_auth.currentUser!.uid)
                .collection('user_feeds')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                feeds = snapshot.data!.docs.map((doc) {
                  return Feed(
                    id: doc.id,
                    type: doc['type'],
                    timestamp: doc['timestamp'].toDate(),
                  );
                }).toList();

                return feeds.isEmpty
                    ? Center(
                  child: Column(
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
                        style:
                        TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ],
                  ),
                )
                    : ListView.builder(
                  itemCount: feeds.length,
                  itemBuilder: (context, index) {
                    final formattedDate = DateFormat.yMd()
                        .add_jm()
                        .format(feeds[index].timestamp);

                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(
                          feeds[index].type,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Date: ${formattedDate}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteFeed(index);
                          },
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        Container(
          height: 100,
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _showAddFeedDialog(context),
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(const Color(0xff49CCD3)),
            ),
            child: const Text(
              "Add Feed",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _addFeed(String feed) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      await _feedCollection
          .doc(user.uid)
          .collection('user_feeds')
          .add({'type': feed, 'timestamp': DateTime.now()});
    }
  }

  Future<void> _deleteFeed(int index) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final feedId = feeds[index].id; // Assuming you have an id field in your Feed class
      await _feedCollection
          .doc(user.uid)
          .collection('user_feeds')
          .doc(feedId)
          .delete();

      setState(() {
        feeds.removeAt(index); // Remove the feed from the local list
      });
    }
  }

  Future<void> _showAddFeedDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Feed'),
          content: TextField(
            controller: _feedController,
            decoration: InputDecoration(labelText: 'Type of Feed'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              onPressed: () async {
                String feed = _feedController.text.trim();
                if (feed.isNotEmpty) {
                  await _addFeed(feed);
                  Navigator.of(context).pop();
                  _feedController.clear();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _feedController.dispose();
    super.dispose();
  }
}

class Feed {
  final String id; // Add id field to store document ID
  final String type;
  final DateTime timestamp;

  Feed({required this.id, required this.type, required this.timestamp});
}
