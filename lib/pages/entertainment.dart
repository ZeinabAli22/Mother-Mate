import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';

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
  String gender = 'Girl'; // Default gender

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
        gender = userData['gender'] ?? 'Girl'; // Get the gender
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
    final screenHeight = size.height;
    final screenWidth = size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: gender == 'Boy' ? Colors.blue[200] : Colors.pink[200],
        appBar: AppBar(
          backgroundColor: gender == 'Boy' ? Colors.blue[200] : Colors.pink[200],
          elevation: 0.0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style: GoogleFonts.poppins(
                          color: gender == 'Boy' ? Colors.blue[900] : Colors.pink[900],
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      firstName,
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: gender == 'Boy' ? Colors.blue[900] : Colors.pink[900]),
                    )
                  ],
                ),
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(profileImageUrl),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Categories',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: gender == 'Boy' ? Colors.blue[800] : Colors.pink[800]),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CategoryTile(
                  title: 'Stories',
                  imagePath: 'asset/images/Group 1171275143.png',
                  onTap: () {
                    Navigator.pushNamed(context, 'storie_screen');
                  },
                ),
                const SizedBox(height: 30),
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CategoryTile(
                      title: 'Games',
                      imagePath: 'asset/images/Group 1171275146.png',
                      onTap: () {
                        Navigator.pushNamed(context, 'game');
                      },
                    ),
                    CategoryTile(
                      title: 'Videos',
                      imagePath: 'asset/images/Group 1171275148.png',
                      onTap: () {
                        Navigator.pushNamed(context, 'videos');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CategoryTile(
                  title: 'AI-Engine',
                  imagePath: 'asset/images/image 907.png',
                  onTap: () {
                    Navigator.pushNamed(context, 'ai_screen');
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Recommended for you',
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
                            title: 'Videos',
                          ),
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
                            title: 'Videos',
                          ),
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
                            title: 'Bedtime Story',
                          ),
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
                            title: 'Bedtime Story',
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
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const CategoryTile({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: screenWidth * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
        ),
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
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
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
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.5),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: screenWidth * 0.07,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
