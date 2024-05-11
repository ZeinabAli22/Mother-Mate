import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Nappy extends StatefulWidget {
  const Nappy({Key? key}) : super(key: key);

  @override
  State<Nappy> createState() => _NappyState();
}

class _NappyState extends State<Nappy> {
  final TextEditingController _commentController = TextEditingController();
  final CollectionReference _nappyCollection =
  FirebaseFirestore.instance.collection('nappies');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _addDiaperEntry() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      await _nappyCollection.add({
        'userId': user.uid,
        'timestamp': DateTime.now(),
        'comment': _commentController.text.trim(),
      });
      _commentController.clear();
    }
  }
  Future<void> _deleteDiaperEntry(String documentId) async {
    await _nappyCollection.doc(documentId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Nappy',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _nappyCollection.orderBy('timestamp').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Image.asset(
                        'asset/images/diaperr.png',
                        color: Colors.grey,
                        scale: 0.5,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "No data to show",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  );
                }

                return  ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: ListTile(
                        title: Text(data['comment']),
                        subtitle: Text(DateFormat('MM/dd/yyyy HH:mm').format(data['timestamp'].toDate())),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteDiaperEntry(document.id),
                        ),
                      ),
                    );
                  }).toList(),
                );

              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              children: [
                TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    labelText: 'Comment',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addDiaperEntry,
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(const Color(0xff49CCD3)),
                  ),
                  child: const Text(
                    "Add Diaper",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}