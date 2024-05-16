import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'comment_screen.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final String? uid = user?.uid;

class _PostsState extends State<Posts> {
  Future<List<DocumentSnapshot>> fetchPosts() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('posts').get();
    return querySnapshot.docs;
  }

  Future<void> deletePost(String postId) async {
    DocumentSnapshot postDoc =
    await FirebaseFirestore.instance.collection('posts').doc(postId).get();

    if (postDoc.exists) {
      Map<String, dynamic>? postData = postDoc.data() as Map<String, dynamic>?;
      if (postData != null && postData['ownerUid'] == uid) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .delete();

        print('Post deleted successfully');
        final snackBar = SnackBar(
          content: Text("Post deleted successfully"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text("Error: You do not have permission to delete this post"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('Error: You do not have permission to delete this post.');
      }
    } else {
      print('Error: Post not found.');
    }
  }

  bool isLiked = false;

  Future<void> addLike(String postId) async {
    DocumentSnapshot postSnapshot =
    await FirebaseFirestore.instance.collection('posts').doc(postId).get();

    if (postSnapshot.exists && postSnapshot.data() is Map<String, dynamic>) {
      Map<String, dynamic> data = postSnapshot.data() as Map<String, dynamic>;
      List<dynamic> likes = data['likes'] ?? [];
      isLiked = likes.contains(uid);
      if (isLiked) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .update({
          'likes': FieldValue.arrayRemove([uid]),
          'likesicon': false,
          'likesCount': FieldValue.increment(-1),
        });
      } else {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .update({
          'likes': FieldValue.arrayUnion([uid]),
          'likesicon': true,
          'likesCount': FieldValue.increment(1),
        });
      }
    } else {
      final snackBar = SnackBar(
        content: Text("Error"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot post = snapshot.data!.docs[index];
              return _buildItem(post, context);
            },
          );
        }
        return Center(
          child: Icon(
            Icons.compost_sharp,
            size: 50,
          ),
        );
      },
    );
  }

  Widget _buildItem(DocumentSnapshot post, BuildContext context) {
    String postId = post.id;
    String postContent = post['post'];
    String userName = post['name'];
    String formattedTime = post['Time'];
    bool likeicon = post['likesicon'];
    int likesCount = post['likesCount'];
    int commentsCount = post['commentsCount'];

    String profileImageUrl;
    try {
      profileImageUrl = post['profileImageUrl']?? 'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg';
    } catch (e) {
      profileImageUrl = 'https://i.pinimg.com/564x/15/12/11/1512110aa5ba75d49f9df7911b119bf2.jpg';
    }

    TextEditingController commentController = TextEditingController();

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        '$userName',
                        style: TextStyle(
                            height: 1.4,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      Text(
                        '$formattedTime',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: [
                              'Delete',
                            ]
                                .map(
                                  (e) => InkWell(
                                onTap: () {
                                  deletePost(postId);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  child: Text(e),
                                ),
                              ),
                            )
                                .toList(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.more_vert_sharp,
                      size: 16.0,
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
              ),
            ),
            Text(
              '$postContent',
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Icon(
                              likeicon
                                  ? Icons.favorite
                                  : Icons.favorite_border_rounded,
                              size: 16,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${likesCount.toString()}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        addLike(postId);
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentsScreen(postId: postId),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.mode_comment_rounded,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${commentsCount.toString()}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(profileImageUrl),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              hintText: 'Write a comment...',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (commentController.text.isNotEmpty) {
                              addComment(postId, commentController.text);
                              commentController.clear();
                            } else {
                              final snackBar = SnackBar(
                                content: Text("Comment is empty!"),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.blue,
                            size: 20,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
