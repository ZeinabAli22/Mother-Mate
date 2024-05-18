import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/babyroutine/Feeding/feeding_screen.dart';
import 'package:proj_app/babyroutine/Growth/growth_screen.dart';
import 'package:proj_app/babyroutine/Nappy/nappy_screen.dart';
import 'package:proj_app/babyroutine/Soothing/soothing_screen.dart';

class BabyRoutineScreen extends StatefulWidget {
  const BabyRoutineScreen({super.key});

  @override
  State<BabyRoutineScreen> createState() => _BabyRoutineScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final String? uid = user?.uid;

class _BabyRoutineScreenState extends State<BabyRoutineScreen> {
  String gender = 'unknown';

  @override
  void initState() {
    super.initState();
    getUserGender();
  }

  Future<void> getUserGender() async {
    if (uid != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      setState(() {
        if (userData.containsKey('gender') && userData['gender'].isNotEmpty) {
          gender = userData['gender'];
        }
      });

      print('Gender: $gender');
    } else {
      print('No user is currently signed in.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = gender == 'Boy' ? Colors.blue[300]! : Colors.pink[300]!;
    final Color textColor = gender == 'Boy' ? Colors.indigo[500]! : Colors.pink[500]!;
    final Color buttonColor = gender == 'Boy' ? Colors.indigo[800]! : Colors.pink[800]!;

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: Text(
          'Baby Routine',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * .25,
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mother Mate",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      Text(
                        'Categories',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      shrinkWrap: true,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FeedingMain(),
                            ),
                          ),
                          child: cat(
                            widget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/images/bot.png',
                                  scale: 0.8,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Feeding",
                                  style: TextStyle(color: Colors.grey, fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SoothingMain(),
                            ),
                          ),
                          child: cat(
                            widget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/images/soothing.png',
                                  scale: 1,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Soothing",
                                  style: TextStyle(color: Colors.grey, fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Nappy(),
                            ),
                          ),
                          child: cat(
                            widget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/images/Nappe.png',
                                  scale: 0.5,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Nappy",
                                  style: TextStyle(color: Colors.grey, fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Growth(),
                            ),
                          ),
                          child: cat(
                            widget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/images/Growth.png',
                                  scale: 1,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Growth",
                                  style: TextStyle(color: Colors.grey, fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cat({required Widget widget}) {
    final Color borderColor = gender == 'Boy' ? Colors.blue : Colors.pink;

    return Container(
      height: 170,
      width: 175,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(1, 1),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: widget,
    );
  }
}
