import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<Map<String, dynamic>> items = [
    {
      'name': 'Mamy Malak',
      'imageUrl':
          'https://i.pinimg.com/564x/15/12/11/1512110aa5ba75d49f9df7911b119bf2.jpg',
    },
    // Add more items here
  ];

  Future<void> fetchGroups() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection('groups').get();
    setState(() {
      items = querySnapshot.docs.map((doc) {
        return {
          'name': doc['groupName'],
          'imageUrl': doc['groupImageUrl'],
          // Assuming you store an image URL for each group
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
    StreamBuilder(
    stream: FirebaseFirestore.instance.collection('Groups').snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) {
    return CircularProgressIndicator();
    }
    return
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final groupDocument = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.only(right: 17.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GroupChatScreen(
                            groupId: groupDocument.id,
                            groupTitle: groupDocument['title'],
                          ),
                        ),
                      );
                    },

                    child: Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(groupDocument['imageURL']),

                          ),
                          SizedBox(height: 7),
                          Text(
                            groupDocument['title'], // Replace with dynamic data
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ));
            },

    ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Groups').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final groupDocument = snapshot.data!.docs[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupChatScreen(
                                groupId: groupDocument.id,
                                groupTitle: groupDocument['title'],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(groupDocument['imageURL']),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    groupDocument['title'],
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  SizedBox(height: 3),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Groups')
                                        .doc(groupDocument.id)
                                        .collection('messages')
                                        .orderBy('timestamp', descending: true)
                                        .limit(1)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text('Loading...'); // Placeholder while loading
                                      }
                                      final lastMessageDoc = snapshot.data!.docs.first;
                                      final lastMessageContent = lastMessageDoc['content'];
                                      final lastMessageTimestamp = lastMessageDoc['timestamp'];

                                      return Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              lastMessageContent,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            lastMessageTimestamp,
                                            textAlign: TextAlign.end,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
