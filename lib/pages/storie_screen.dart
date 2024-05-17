// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';
import 'package:proj_app/widget/data.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

const double cardAspectRatio = 12.0 / 16.0;
const double widgetAspectRatio = cardAspectRatio * 1.2;

class _StoriesScreenState extends State<StoriesScreen> {
  double currentPage = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page ?? currentPage; // Handle nullable double
      });
    });
    return Container(
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [Color(0xFF1b1e44), Color(0xFF2d3447)],
        //   begin: Alignment.bottomCenter,
        //   end: Alignment.topCenter,
        // ),
        color: Colors.grey[200],
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
          backgroundColor: Colors.grey[200],
          elevation: 0.0,
          title: Text(
            'Stories',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Trending',
                      style: TextStyle(
                          // color: Colors.white,
                          fontSize: 46,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          size: 25,
                          // color: Colors.white,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFff6e6e),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 22.0,
                            vertical: 6.0,
                          ),
                          child: Text(
                            'Animated',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    const Text(
                      '25+ Stories',
                      style: TextStyle(color: Colors.blueAccent),
                    )
                  ],
                ),
              ),
              Stack(
                children: [
                  CardScrollWidget(currentPage),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: images.length,
                      controller: controller,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Favourite',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 46.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          size: 25,
                          // color: Colors.white,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 22.0,
                            vertical: 6.0,
                          ),
                          child: Text("Latest",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    const Text("9+ Stories",
                        style: TextStyle(color: Colors.blueAccent)),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              // ListView
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  children: <Widget>[
                    Link(
                      uri: Uri.parse(
                          'https://www.bing.com/videos/riverview/relatedvideo?q=magic+pot+story&mid=F2B6C3F8CD82D3E6DE35F2B6C3F8CD82D3E6DE35&FORM=VIRE'),
                      builder: (context, followLink) => GestureDetector(
                        onTap: followLink,
                        child: VideosCard(
                          imagePath: 'asset/images/Magic Pot.jpeg',
                          title: 'Magic Pot Bedtime',
                          subtitle: '5:32 Min',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Link(
                      uri: Uri.parse(
                          'https://www.youtube.com/watch?v=ADi7F695d90'),
                      builder: (context, followLink) => GestureDetector(
                        onTap: followLink,
                        child: VideosCard(
                          imagePath: 'asset/images/Rabbit.jpg',
                          title: 'Rabbit',
                          subtitle: '5:32 Min',
                        ),
                      ),
                    ),
                    // const SizedBox(height: 10),
                    Link(
                      uri: Uri.parse(
                          'https://www.youtube.com/watch?v=pf_xz7GFCHw'),
                      builder: (context, followLink) => GestureDetector(
                        onTap: followLink,
                        child: VideosCard(
                          imagePath: 'asset/images/Little.jpg',
                          title: 'The Little Maremaid',
                          subtitle: '5:30 Min',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  final double currentPage;
  final double padding = 20.0;
  final double verticalInset = 20.0;

  const CardScrollWidget(this.currentPage, {super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        final safeWidth = width - 2 * padding;
        final safeHeight = height - 2 * padding;

        final heightOfPrimaryCard = safeHeight;
        final widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        final primaryCardLeft = safeWidth - widthOfPrimaryCard;
        final horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = [];
        for (int i = 0; i < images.length; i++) {
          final delta = i - currentPage;
          final bool isOnRight = delta > 0;

          final start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0);

          final cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.ltr, // or rtl, depending on layout,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.grey.shade200, boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(3.0, 6.0),
                    blurRadius: 10.0,
                  )
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        images[i],
                        fit: BoxFit.cover,
                      ),
                      // Align(
                      //   alignment: Alignment.bottomLeft,
                      //   child: Column(
                      //     mainAxisSize: MainAxisSize.min,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 16.0, vertical: 8.0),
                      //         child: Text(
                      //           title[i],
                      //           style: const TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 30.0,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         height: 10.0,
                      //       ),
                      //       // Padding(
                      //       //   padding: const EdgeInsets.only(
                      //       //       left: 12.0, bottom: 12.0),
                      //       //   child: Container(
                      //       //     padding: const EdgeInsets.symmetric(
                      //       //         horizontal: 22.0, vertical: 6.0),
                      //       //     decoration: BoxDecoration(
                      //       //       color: Colors.blueAccent,
                      //       //       borderRadius: BorderRadius.circular(20),
                      //       //     ),
                      //       //     child: const Text(
                      //       //       'Read Later',
                      //       //       style: TextStyle(color: Colors.white),
                      //       //     ),
                      //       //   ),
                      //       // ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}

class StoryCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String info;

  const StoryCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          Image(
            image: AssetImage(imagePath),
            height: 85.0,
            width: 80.0,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Text(
                info,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w300,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VideosCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const VideosCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
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
            child: Image.asset(
              imagePath,
              // height: screenWidth * 0.3,
              // width: screenWidth * 0.3,
              scale: 6,
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
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w300,
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
