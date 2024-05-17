// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:proj_app/pages/Ai-Engine/ai_screen.dart';
// import 'package:proj_app/pages/Games/game.dart';
// import 'package:proj_app/pages/homescreenboy.dart';
// import 'package:proj_app/pages/storie_screen.dart';
// import 'package:proj_app/pages/Videos/videos.dart';
// import 'package:url_launcher/link.dart';

class EntertainScreen extends StatefulWidget {
  const EntertainScreen({super.key});

  @override
  State<EntertainScreen> createState() => _EntertainScreenState();
}

class _EntertainScreenState extends State<EntertainScreen> {
  final _controller = PageController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  String firstName = 'Loading...';
  String profileImageUrl =
      'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg'; // Default image URL

  Future<void> getUserData() async {
    if (uid != null) {
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic> userData =
          userDoc.data() as Map<String, dynamic>;

      setState(() {
        if (userData.containsKey('username') &&
            userData['username'].isNotEmpty) {
          firstName = userData['username'].split(' ')[0];
        }
        profileImageUrl = userData['image_url'] ??
            'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg';
      });
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
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[200],
          elevation: 0.0,
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //name of the profile.
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello,',
                          style: GoogleFonts.poppins(
                              color: Colors.blue[900],
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          firstName,
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[900]),
                        )
                      ],
                    ),
                    //profile picture
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(profileImageUrl),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: size.height * .45,
              decoration: BoxDecoration(
                color: Colors.blue[200],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Container(
                    //   margin: const EdgeInsets.symmetric(vertical: 20),
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 30, vertical: 5),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: TextFormField(
                    //     decoration: InputDecoration(
                    //       hintText: "Search",
                    //       icon: SvgPicture.asset('asset/images/search.svg'),
                    //       border: InputBorder.none,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Categories',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'storie_screen');
                            },
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'asset/images/Group 1171275143.png'),
                                      fit: BoxFit.fill)),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  'Stories',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 55,
                      crossAxisSpacing: 5,
                      shrinkWrap: true,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'game');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'asset/images/Group 1171275146.png'),
                                  fit: BoxFit.fill),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 69, horizontal: 10),
                              child: Text(
                                'Games',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'videos');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'asset/images/Group 1171275148.png'),
                                  fit: BoxFit.fill),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 69, horizontal: 10),
                              child: Text(
                                'Videos',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'ai_screen');
                        },
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('asset/images/image 907.png'),
                                fit: BoxFit.fill),
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Text(
                                      "AI-Engine",
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Recomended for you',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    Container(
                      height: screenHeight * 0.25,
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: _controller,
                        children: [
                          Link(
                            uri: Uri.parse(
                                'https://www.youtube.com/watch?v=CWct06Wi-Hs'),
                            builder: (context, followLink) => InkWell(
                              onTap: followLink,
                              child: MyCards(
                                  imagepath:
                                      'https://i.pinimg.com/564x/ab/c7/85/abc785495ffa17ae49c9b3e0ee0adf7f.jpg',
                                  title: 'Videos'),
                            ),
                          ),
                          Link(
                            uri: Uri.parse(
                                'https://www.youtube.com/watch?v=71xB0i9f6Gs'),
                            builder: (context, followLink) => InkWell(
                              onTap: followLink,
                              child: MyCards(
                                  imagepath:
                                      'https://i.pinimg.com/564x/70/d2/16/70d216dd59e122f291dcf59a4b9d975f.jpg',
                                  title: 'Videos'),
                            ),
                          ),
                          Link(
                            uri: Uri.parse(
                                'https://5minutebedtime.com/the-ugly-duckling-story/'),
                            builder: (context, followLink) => InkWell(
                              onTap: followLink,
                              child: MyCards(
                                  imagepath:
                                      'https://5minutebedtime.com/wp-content/uploads/2020/08/The-ugly-duckling.jpg',
                                  title: 'Bedtime Story'),
                            ),
                          ),
                          Link(
                            uri: Uri.parse(
                                'https://www.belarabyapps.com/%d9%82%d8%b5%d8%b5-%d8%aa%d8%b1%d8%a8%d9%88%d9%8a%d8%a9-%d9%85%d8%b5%d9%88%d8%b1%d8%a9-%d9%84%d9%84%d8%a3%d8%b7%d9%81%d8%a7%d9%84/'),
                            builder: (context, followLink) => InkWell(
                              onTap: followLink,
                              child: MyCards(
                                  imagepath:
                                      'https://i.pinimg.com/564x/93/25/14/93251471c988d024fcf5ee83b293c060.jpg',
                                  title: 'BedTime Story'),
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
      ),
    );
  }
}

class GridIteam extends StatelessWidget {
  final String title;
  final String img;
  const GridIteam({super.key, required this.title, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10)),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0.8, 0.8),
              color: Colors.white,
              blurRadius: 17,
              spreadRadius: -23),
        ],
        border: Border.all(color: Colors.indigo, width: 1.5),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: AssetImage(img),
              width: 90,
              height: 90,
              fit: BoxFit.contain,
            ),
            Text(
              title,
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
          ],
        ),
      ),
    );
  }
}

//Widget Cat

Widget cat({required Widget widget}) {
  return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          border: Border.all(color: Colors.indigo),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 4,
              offset: Offset(1, 1),
            )
          ]),
      alignment: Alignment.center,
      child: widget);
}

class Card extends StatelessWidget {
  final String imagePath;
  final String title;

  const Card({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Image.network(
              imagePath,
              height: screenWidth * 0.3,
              width: screenWidth * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: screenWidth * 0.05),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                  color: Colors.black,
                ),
              ),
              // Text(
              //   subtitle,
              //   style: GoogleFonts.inter(
              //     fontWeight: FontWeight.w300,
              //     fontSize: screenWidth * 0.04,
              //     color: Colors.grey,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyCards extends StatelessWidget {
  final String imagepath;
  final String title;

  const MyCards({super.key, required this.imagepath, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        width: screenWidth * 1.6,
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Stack(fit: StackFit.expand, children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            child: Image.network(
              imagepath,
              fit: BoxFit.fill,
            ),
          ),
          // SizedBox(width: screenWidth * 0.05),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title,
                          style: GoogleFonts.bebasNeue(
                            color: Colors.black,
                            fontSize: screenWidth * 0.07,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
