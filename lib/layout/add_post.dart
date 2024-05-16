import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}
final postController = TextEditingController();
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
late String username = 'user';
late String profileImageUrl = 'https://i.pinimg.com/564x/15/12/11/1512110aa5ba75d49f9df7911b119bf2.jpg';

class _AddPostScreenState extends State<AddPostScreen> {

  Future<void> createPost(BuildContext context) async {
    if (user != null) {
      DateTime now = DateTime.now();
      String formattedTime = DateFormat('MMMM dd, yyyy  hh:mm a').format(now);
      String postContent = postController.text.trim();
      String postId = FirebaseFirestore.instance.collection('posts').doc().id;

      await FirebaseFirestore.instance.collection('posts').doc(postId).set({
        'post': postContent,
        'name': username,
        'ownerUid': user!.uid,
        'Time': formattedTime,
        'likesicon': false,
        'likes': [],
        'likesCount': 0,
        'comments': [],
        'commentsCount': 0,
        'profileImageUrl': profileImageUrl, // Save the profile image URL with the post
      });

      final snackBar = SnackBar(
        content: Text("Post Created"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.of(context).pushNamed('home_layout');
    } else {
      final snackBar = SnackBar(
        content: Text("Error: User not found"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> getUserData() async {
    if (user != null) {
      final DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

      if (userDoc.exists) {
        final Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          username = userData['username'];
          profileImageUrl = userData['image_url'] ?? profileImageUrl;
        });
      } else {
        print('User document does not exist.');
      }
    } else {
      print('No user is currently signed in.');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(profileImageUrl),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$username',
                        style: TextStyle(
                            height: 1.4,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      Text(
                        'Public',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TextFormField(
                controller: postController,
                decoration: const InputDecoration(
                  hintText: 'What is on your mind...',
                  border: InputBorder.none,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (postController.text.trim().isEmpty) {
                      final snackBar = SnackBar(
                        content: Text("Post is empty"),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      createPost(context);
                    }
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.blue[300],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
