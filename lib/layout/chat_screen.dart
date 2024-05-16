import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class GroupChatScreen extends StatefulWidget {
  final String groupId;
  final String groupTitle;

  GroupChatScreen({required this.groupId, required this.groupTitle});

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final String? uid = user?.uid;

class _GroupChatScreenState extends State<GroupChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Groups')
                  .doc(widget.groupId)
                  .collection('messages')
                  .orderBy('timestampofmessage', ) // Order by ascending to show the newest messages at the bottom
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  }
                });
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final message = snapshot.data!.docs[index];
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('users').doc(message['senderUid']).snapshots(),
                      builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> userSnapshot) {
                        if (!userSnapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        final userData = userSnapshot.data!.data();
                        final username = userData != null ? userData['username'] : 'Unknown User';
                        final userProfilePic = userData != null && userData.containsKey('image_url') ? userData['image_url'] : 'https://i.pinimg.com/564x/15/12/11/1512110aa5ba75d49f9df7911b119bf2.jpg';
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(userProfilePic),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$username',
                                  style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                Text(
                                  '${message['timestamp']}',
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              message['content'],
                              style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    String messageContent = _messageController.text.trim();
    DateTime dateTime = Timestamp.now().toDate();
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    if (messageContent.isNotEmpty) {
      // Get the user's profile picture URL
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      String userProfilePic = userDoc['image_url'] ?? 'https://i.pinimg.com/564x/15/12/11/1512110aa5ba75d49f9df7911b119bf2.jpg';

      FirebaseFirestore.instance.collection('Groups').doc(widget.groupId).collection('messages').add({
        'senderUid': uid,
        'timestamp': formattedTime,
        'timestampofmessage': dateTime,
        'content': messageContent,
        'profilePic': userProfilePic,
      });

      _messageController.clear();

      // Scroll to the bottom after sending a message
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    } else {
      final snackBar = SnackBar(
        content: Text('The message is empty.'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.white,
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
