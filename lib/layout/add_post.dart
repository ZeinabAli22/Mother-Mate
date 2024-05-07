import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final String? uid = user?.uid;
class _AddPostScreenState extends State<AddPostScreen> {

  final postController = TextEditingController();
  Future<void> createPost(BuildContext context) async {
    print('start');


    if (uid!= null) {
      DateTime now = DateTime.now();
      String formattedTime = DateFormat('MMMM dd, yyyy  hh:mm a').format(now);

      String postContent = postController.text.trim();
      String userName = Username;

      String postId = FirebaseFirestore.instance.collection('posts').doc().id;

      await FirebaseFirestore.instance.collection('posts').doc(postId).set({
        'post': postContent,
        'name': userName,
        'ownerUid': uid,
        'Time': formattedTime,
        'likesicon':false,
        'likes': [], // Array to store user IDs
        'likesCount': 0, // Integer to store the count of likes
        'comments': [], // Array to store user IDs
        'commentsCount': 0,
      });

      print('done');
      final snackBar = SnackBar(
        content: Text("Post Created"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,

      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.of(context).pushNamed('home_layout');
    } else {
      print('Error: User not found');
    }
  }

  late String Username = 'user';
  Future<void> getUserData() async {


    if (uid!= null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
setState(() {
  Username =userData['username'];

});
      print(' Email: ${userData['email']}');
      print(' username: ${userData['username']}');
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

      // appBar: AppBar(
      //   actions: [
      //     TextButton(onPressed: () {}, child: Text('Post')),
      //   ],
      // ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                //UserName and Circle Avatar
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/564x/15/12/11/1512110aa5ba75d49f9df7911b119bf2.jpg'),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        '${Username}',
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

                  hintText: 'what is on your mind ...',
                  border: InputBorder.none,
                ),
              ),
            ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end, // Aligns the Row to the end of the screen
        children: <Widget>[
          Spacer(),
          FloatingActionButton(
            onPressed: () {
              if (postController.text.trim().isEmpty) {
                print('post empty');
                final snackBar = SnackBar(
                  content: Text("Post is empty"),
                  duration: Duration(seconds: 2), // Duration for which the Snackbar will be shown
                  backgroundColor: Colors.red, // Background color of the Snackbar
                );

// Find the ScaffoldMessenger in the widget tree and use it to show a SnackBar.
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
