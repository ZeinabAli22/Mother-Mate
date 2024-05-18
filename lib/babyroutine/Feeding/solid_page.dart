import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FeedingSolid extends StatefulWidget {
  const FeedingSolid({Key? key}) : super(key: key);

  @override
  State<FeedingSolid> createState() => _FeedingSolidState();
}

class _FeedingSolidState extends State<FeedingSolid> {
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final CollectionReference _feedCollection = FirebaseFirestore.instance.collection('solid_feeds');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<SolidFeed> feeds = [];
  int _totalCalories = 0;

  @override
  void initState() {
    super.initState();
    _feedCollection
        .doc(_auth.currentUser!.uid)
        .collection('user_solid_feeds')
        .snapshots()
        .listen(_updateFeedList);
  }

  void _updateFeedList(QuerySnapshot<Map<String, dynamic>> snapshot) {
    setState(() {
      feeds = snapshot.docs.map((doc) => SolidFeed.fromSnapshot(doc)).toList();
      _calculateTotalCalories();
    });
  }

  void _calculateTotalCalories() {
    int newTotal = feeds.fold(0, (sum, feed) => sum + int.parse(feed.calories));
    setState(() {
      _totalCalories = newTotal;
    });
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
                  'The total energy requirement for healthy, breastfed infants is approximately 615 kcal/day at the age of 6-8 months and 686 kcal/day at the age of 9-11 months.',
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
            child: Text('Total Calories: $_totalCalories kcal',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 4,
            child: StreamBuilder(
              stream: _feedCollection
                  .doc(_auth.currentUser!.uid)
                  .collection('user_solid_feeds')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  feeds = snapshot.data!.docs.map((doc) {
                    return SolidFeed(
                      id: doc.id,
                      food: doc['food'],
                      calories: doc['calories'],
                      timestamp: doc['timestamp'].toDate(),
                    );
                  }).toList();

                  return feeds.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('asset/images/meal.png'),
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
                            feeds[index].food,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Calories: ${feeds[index].calories} kcal\nDate: $formattedDate',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () => _showAddFeedDialog(context),
                    style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                    child: Text("Add Feed",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
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
                    child: Text("Reset",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Note: Remember to reset the feeds if it's a new day to calculate the calorie intake for the day.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          SizedBox(height: 10), // Added space between buttons and note
        ],
      ),
    );
  }

  Future<void> _addFeed(String food, String calories) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      await _feedCollection
          .doc(user.uid)
          .collection('user_solid_feeds')
          .add({'food': food, 'calories': calories, 'timestamp': DateTime.now()});
    }
  }

  Future<void> _deleteFeed(int index) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final feedId = feeds[index].id;
      await _feedCollection
          .doc(user.uid)
          .collection('user_solid_feeds')
          .doc(feedId)
          .delete();

      setState(() {
        feeds.removeAt(index);
        _calculateTotalCalories();
      });
    }
  }

  Future<void> _clearAllFeeds() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final userFeeds = _feedCollection.doc(user.uid).collection('user_solid_feeds');
      final batch = FirebaseFirestore.instance.batch();
      final feedDocs = await userFeeds.get();
      for (var doc in feedDocs.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      setState(() {
        feeds.clear();
        _totalCalories = 0;
      });
    }
  }

  Future<void> _showAddFeedDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Feed'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _foodController,
                decoration: InputDecoration(labelText: 'Type of Food'),
              ),
              TextField(
                controller: _caloriesController,
                decoration: InputDecoration(labelText: 'Calories (kcal)'),
                keyboardType: TextInputType.number,
              ),
            ],
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
                String food = _foodController.text.trim();
                String calories = _caloriesController.text.trim();
                if (food.isNotEmpty && calories.isNotEmpty) {
                  await _addFeed(food, calories);
                  Navigator.of(context).pop();
                  _foodController.clear();
                  _caloriesController.clear();
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
    _foodController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }
}

class SolidFeed {
  final String id;
  final String food;
  final String calories;
  final DateTime timestamp;

  SolidFeed(
      {required this.id, required this.food, required this.calories, required this.timestamp});

  factory SolidFeed.fromSnapshot(DocumentSnapshot doc) {
    return SolidFeed(
      id: doc.id,
      food: doc['food'],
      calories: doc['calories'],
      timestamp: (doc['timestamp'] as Timestamp).toDate(),
    );
  }
}
