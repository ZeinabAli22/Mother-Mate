import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;

  CommentsScreen({required this.postId});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final String? uid = user?.uid;

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('posts').doc(widget.postId).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var postDocument = snapshot.data!;
                var comments = postDocument['comments'] ?? [];
                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    var comment = comments[index];
                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance.collection('users').doc(comment['uid']).get(),
                      builder: (context, userSnapshot) {
                        if (!userSnapshot.hasData) {
                          return SizedBox();
                        }
                        var username = userSnapshot.data!['username'];
                        return ListTile( leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/564x/15/12/11/1512110aa5ba75d49f9df7911b119bf2.jpg'),
                        ),
                          title:Text(username, style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),) ,
                          subtitle:  Text(comment['comment'], style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
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
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Write a comment...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    addComment(widget.postId, _commentController.text);
                    _commentController.clear();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addComment(String postId, String commentText) async {
    await FirebaseFirestore.instance.collection('posts').doc(postId).update({
      'comments': FieldValue.arrayUnion([
        {
          'uid': uid,
          'comment': commentText,
        },
      ]),
    });
    final snackBar = SnackBar(
      content: Text("Your comment has been successfully added"),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    await FirebaseFirestore.instance.collection('posts').doc(postId).update({
      'commentsCount': FieldValue.increment(1),
    });
  }
}
