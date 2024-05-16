import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InstructionScreen extends StatefulWidget {
  const InstructionScreen({Key? key}) : super(key: key);

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  late String username = 'loading...';
  late String profilePicUrl = 'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg';

  Future<void> getUserData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String? uid = user?.uid;

    if (uid != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      setState(() {
        username = userData['username'].split(' ')[0]; // Extract first name
        profilePicUrl = userData['image_url'] ?? 'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg';
      });
      print('Email: ${userData['email']}');
      print('Username: ${userData['username']}');
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
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        elevation: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(profilePicUrl),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Hi, $username',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.indigo[500],
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('articles').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: InfoCard(
                  title: data['title'],
                  description: data['description'],
                  imageUrl: data['image_url'],
                  articleUrl: data['url'],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String articleUrl;

  const InfoCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.articleUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[50],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            height: 160,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 178, 58, 197),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Expanded(
                  child: Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    if (articleUrl.isNotEmpty) {
                      try {
                        final Uri _url = Uri.parse(articleUrl);
                        if (!await launchUrl(_url)) {
                          print('Could not launch $articleUrl');
                        }
                      } catch (e) {
                        print('Error launching URL: $e');
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple[200]),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: const Text('Read article'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
