import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

final _controller = PageController();
var bannerItems = [
  "Encanto",
  "البندورة الحمرا",
  "Baby Shark",
  "الارنب و الثعلب"
];
var bannerImage = [
  "asset/images/Encanto.jpg",
  'asset/images/Tom.jpg',
  'asset/images/BabyShark.jpg',
];

class _VideosScreenState extends State<VideosScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          'Videos',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: screenHeight * 0.25,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  children: [
                    Link(
                      uri: Uri.parse('https://www.youtube.com/watch?v=YRpvIiz9G8A'),
                      builder: (context, followlink) => InkWell(
                        onTap: followlink,
                        child: MyCards(
                          imagepath: 'https://i.pinimg.com/564x/26/ed/bd/26edbd566a6fa21365bd4b2d57b26873.jpg',
                          title: 'Enacanto',
                        ),
                      ),
                    ),
                    Link(
                      uri: Uri.parse('https://www.youtube.com/watch?v=u5INFsIYeZw'),
                      builder: (context, followlink) => InkWell(
                        onTap: followlink,
                        child: MyCards(
                          imagepath: 'https://i.pinimg.com/564x/cf/c2/12/cfc212c43fa6e36c8819c619b8711a83.jpg',
                          title: '',
                        ),
                      ),
                    ),
                    Link(
                      uri: Uri.parse('https://www.youtube.com/watch?v=XqZsoesa55w'),
                      builder: (context, followLink) => InkWell(
                        onTap: followLink,
                        child: MyCards(
                          imagepath: 'https://i.pinimg.com/736x/dc/34/a5/dc34a5be843232d2983bd5cd4f7e8835.jpg',
                          title: 'Baby Shark',
                        ),
                      ),
                    ),
                    Link(
                      uri: Uri.parse('https://www.youtube.com/watch?v=n3ZWcbGdyJw'),
                      builder: (context, followLink) => InkWell(
                        onTap: followLink,
                        child: MyCards(
                          imagepath: 'https://i.pinimg.com/564x/e3/36/73/e336736d958a445105bd0376ef9f71bd.jpg',
                          title: 'الارنب و الثعلب',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              SmoothPageIndicator(
                controller: _controller,
                count: 4,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.grey.shade800,
                  dotHeight: screenHeight * 0.01,
                  dotWidth: screenHeight * 0.01,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  children: [
                    Link(
                      uri: Uri.parse('https://www.youtube.com/watch?v=yCjJyiqpAuU'),
                      builder: (context, followLink) => GestureDetector(
                        onTap: followLink,
                        child: VideosCard(
                          imagePath: 'https://i.pinimg.com/564x/27/cf/42/27cf4293377b2d028c25a937df33bfb2.jpg',
                          title: 'Twinkle Twinkle',
                          subtitle: '2:33 Min',
                        ),
                      ),
                    ),
                    Link(
                      uri: Uri.parse('https://www.youtube.com/watch?v=TeQ_TTyLGMs'),
                      builder: (context, followLink) => GestureDetector(
                        onTap: followLink,
                        child: VideosCard(
                          imagePath: 'https://i.pinimg.com/564x/56/c8/27/56c827cc1a6d9fb7717deaa348981430.jpg',
                          title: 'Frozen',
                          subtitle: '3:21 Min',
                        ),
                      ),
                    ),
                    Link(
                      uri: Uri.parse('https://www.youtube.com/watch?v=ukcd0dsvSxY'),
                      builder: (context, followLink) => GestureDetector(
                        onTap: followLink,
                        child: VideosCard(
                          imagePath: 'https://i.pinimg.com/564x/b1/b4/7c/b1b47cac46cae6ad696ef972f43893a6.jpg',
                          title: 'جدو علي',
                          subtitle: '3:27 Min',
                        ),
                      ),
                    ),
                    Link(
                      uri: Uri.parse('https://www.youtube.com/watch?v=l_DQpS9lBhE'),
                      builder: (context, followLink) => GestureDetector(
                        onTap: followLink,
                        child: VideosCard(
                          imagePath: 'https://i.pinimg.com/564x/f8/1b/98/f81b9815aac241e259340121cdfea11b.jpg',
                          title: 'Baby\'s First Step',
                          subtitle: '14:18 Min',
                        ),
                      ),
                    ),
                    Link(
                      uri: Uri.parse('https://www.youtube.com/watch?v=pZw9veQ76fo'),
                      builder: (context, followLink) => GestureDetector(
                        onTap: followLink,
                        child: VideosCard(
                          imagePath: 'https://i.pinimg.com/564x/b8/55/a2/b855a2885d32a96baf9ebf14bfa2ac3c.jpg',
                          title: 'Five Little Ducks',
                          subtitle: '2:54 Min',
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          // Handle navigation
        },
        buttonBackgroundColor: Colors.white,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.play_circle),
            label: 'Play',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person),
            label: 'Profile',
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
        width: screenWidth * 0.8,
        padding: EdgeInsets.all(screenWidth * 0.03),
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.3,
                      child: Text(
                        title,
                        style: GoogleFonts.bebasNeue(
                          color: Colors.white,
                          fontSize: screenWidth * 0.06,
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
