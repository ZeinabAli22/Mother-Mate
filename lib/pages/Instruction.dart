import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class InstructionScreen extends StatefulWidget {
  const InstructionScreen({Key? key}) : super(key: key);

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  late String username = 'loading...';
  late String profilePicUrl =
      'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg';
  String gender = 'unknown';  // Default gender

  Future<void> getUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid;

    if (uid != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      if (userData != null) {
        setState(() {
          profilePicUrl = userData['image_url'] ?? 'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg';
          username = userData['username'] ?? 'loading...';
          gender = userData['gender'] ?? 'unknown';
        });
      } else {
        print('No data found for the user.');
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
    Color backgroundColor = Colors.purple[100]!;
    if (gender == 'Boy') {
      backgroundColor = Colors.blue[100]!;
    } else if (gender == 'Girl') {
      backgroundColor = Colors.pink[100]!;
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(profilePicUrl),
            ),
            const SizedBox(width: 10),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Instructions For You",
                style: GoogleFonts.inter(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
              const SizedBox(
                height: 20,
              ),
              InfoCard(
                gender: gender,
                title: 'How to make your\nbaby sleep',
                text: 'Our tips on how to organize\nyour baby sleep time ...',
                imag: 'asset/images/image 898.png',
                articleUrl: 'https://www.healthline.com/health/baby/how-to-get-baby-to-sleep',
              ),
              const SizedBox(
                height: 20,
              ),
              InfoCard(
                gender: gender,
                title: 'Breast Feeding or\nFormula',
                text: 'Our tips on Breast feeding\nbaby or using formula...',
                imag: 'asset/images/image 897.png',
                articleUrl: 'https://www.webmd.com/baby/breastfeeding-vs-formula-feeding',
              ),
              const SizedBox(
                height: 20,
              ),
              InfoCard(
                gender: gender,
                title: 'How To Manage\nTwo under Two',
                text: 'Our tips on This\nSpecific subject..',
                imag: 'asset/images/image 895.png',
                articleUrl: 'https://www.nct.org.uk/life-parent/parenting-more-one-child/top-tips-for-parents-two-children-under-two#:~:text=Top%20tips%20for%20parents%20with%20two%20children%20under,two%208%208.%20Dealing%20with%20exhaustion%20More%20items',
              ),
              const SizedBox(
                height: 20,
              ),
              InfoCard(
                gender: gender,
                title: 'How To make your baby\nfeel safe ?',
                text: 'Many step to make your \nbaby feel cared ...',
                imag: 'asset/images/image 896.png',
                articleUrl: 'https://choicespsychotherapy.net/5-ways-make-a-child-feel-safe-and-secure/',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String gender;
  final String imag;
  final String title;
  final String text;
  final String articleUrl;

  const InfoCard({
    super.key,
    required this.gender,
    required this.imag,
    required this.title,
    required this.text,
    required this.articleUrl,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = gender == 'Boy' ? Colors.blue[800]! : Colors.pink[800]!;
    Color buttonColor = gender == 'Boy' ? Colors.blue[300]! : Colors.pink[300]!;

    return Container(
      height: 180,
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[50],
            ),
          ),
          Container(
            height: 160,
            width: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
            child: Image.asset(imag),
          ),
          Positioned(
            height: 215,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              height: 300,
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      text,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
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
                        backgroundColor: MaterialStateProperty.all(buttonColor),
                        foregroundColor: const MaterialStatePropertyAll(Colors.white),
                      ),
                      child: const Text('Read article'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
