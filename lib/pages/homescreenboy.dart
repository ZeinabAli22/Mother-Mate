import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenB extends StatefulWidget {
  const HomeScreenB({Key? key}) : super(key: key);

  @override
  State<HomeScreenB> createState() => _HomeScreenBState();
}

class _HomeScreenBState extends State<HomeScreenB> {
  void openMedicalScreen() {
    Navigator.pushNamed(context, 'medical_history');
  }

  void openEntertainScreen() {
    Navigator.pushNamed(context, 'entertainment');
  }

  void openInstructionScreen() {
    Navigator.pushNamed(context, 'Instruction');
  }

  late String firstName = 'loading...';
  String profileImageUrl = '';
  Color backgroundColor = Color(0XFFA3D5FF); // Default color for boy

  Future<void> getUserData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String? uid = user?.uid;

    if (uid != null) {
      final DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic> userData =
      userDoc.data() as Map<String, dynamic>;
      setState(() {
        firstName = userData['username'].split(' ')[0]; // Get the first name only
        profileImageUrl = userData['image_url'] ??
            'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg';
        if (userData['gender'] == 'Girl') {
          backgroundColor = Colors.pink[200]!;
        } else {
          backgroundColor = Color(0XFFA3D5FF);
        }
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
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
      statusBarIconBrightness: Brightness.dark,
    ));

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: <Widget>[
            Container(
              height: size.height * .45,
              decoration: BoxDecoration(color: backgroundColor),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.15),
                          child: Text(
                            "Mother Mate",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: size.width * 0.09,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Text(
                          "Hello,  ",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "$firstName ! ",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'profile_screen');
                          },
                          child: CircleAvatar(
                            radius: size.width * 0.06,
                            backgroundImage: NetworkImage(profileImageUrl),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upcoming Appointments:',
                          style: GoogleFonts.poppins(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold),
                        ),
                        Cards(
                          title: 'Dr.Laila',
                          subtitle: '09:30 AM',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Services:",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.008,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: size.height * 0.02),
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: size.width * 0.05,
                          mainAxisSpacing: size.height * 0.03,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0XFFC97777),
                                borderRadius: BorderRadius.circular(size.width * 0.04),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 13),
                                    blurRadius: 17,
                                    spreadRadius: -23,
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, 'home_layout');
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'asset/images/Medical.png',
                                        height: size.height * 0.1,
                                        width: size.width * 0.3,
                                      ),
                                      Text(
                                        "MotherHood \n Community",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize: size.width * 0.04,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0XFF3D6196),
                                borderRadius: BorderRadius.circular(size.width * 0.04),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 13),
                                    blurRadius: 17,
                                    spreadRadius: -23,
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: openMedicalScreen,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "asset/images/Pill.png",
                                        height: size.height * 0.12,
                                        width: size.width * 0.3,
                                      ),
                                      Text(
                                        "Medical History",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize: size.width * 0.04,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0XFF2F6C4F),
                                borderRadius: BorderRadius.circular(size.width * 0.04),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 13),
                                    blurRadius: 17,
                                    spreadRadius: -23,
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: openEntertainScreen,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'asset/images/Rectangle.png',
                                        height: size.height * 0.12,
                                        width: size.width * 0.3,
                                      ),
                                      Text(
                                        "Entertainment",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize: size.width * 0.04,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[900],
                                borderRadius: BorderRadius.circular(size.width * 0.04),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 13),
                                    blurRadius: 17,
                                    spreadRadius: -23,
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: openInstructionScreen,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "asset/images/Instruct.png",
                                        height: size.height * 0.1,
                                        width: size.width * 0.3,
                                      ),
                                      Text(
                                        "Mother\nInstructions",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize: size.width * 0.04,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Nearby Doctors:",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),

                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        height: size.height * 0.12,
                        enlargeCenterPage: false,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                      ),
                      items: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(size.width * 0.03),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/images/Image.png',
                                  height: size.height * 0.15,
                                  width: size.width * 0.3,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Dr.Mazen",
                                        style: GoogleFonts.poppins(
                                          fontSize: size.width * 0.05,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "About 800m Away from your Location",
                                        style: GoogleFonts.poppins(
                                          fontSize: size.width * 0.04,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;

  const CategoryCard({
    super.key,
    required this.svgSrc,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFC97777),
        borderRadius: BorderRadius.circular(size.width * 0.04),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 13),
            blurRadius: 17,
            spreadRadius: -23,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'home_layout');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                svgSrc,
                height: size.height * 0.15,
                width: size.width * 0.3,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final String title;
  final String subtitle;

  const Cards({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.width * 0.04),
      decoration: BoxDecoration(
        color: Color(0XFF213052),
        borderRadius: BorderRadius.circular(size.width * 0.05),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.width * 0.05),
              bottomLeft: Radius.circular(size.width * 0.05),
            ),
            child: Container(
              height: size.width * 0.2,
              width: size.width * 0.2,
              decoration: BoxDecoration(
                color: Color(0xFF2EBFDF),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  '9 MAY',
                  style: GoogleFonts.poppins(
                      fontSize: size.width * 0.04, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(width: size.width * 0.1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: size.width * 0.05,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w300,
                  fontSize: size.width * 0.05,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
