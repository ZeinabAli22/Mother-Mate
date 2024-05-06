import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[300],
        body: Stack(
          children: <Widget>[
            Container(
              height: size.height * .45,
              decoration: BoxDecoration(
                color: Colors.blue[300],
              ),
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  Text("Mother Mate",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        icon: SvgPicture.asset('asset/images/search.svg'),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        "Services:",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        const CategoryCard(
                          title: "MotherHood \n Community",
                          svgSrc: 'asset/images/Medical Doctor.png',
                        ),

                        //2nd
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(15),
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
                                children: <Widget>[
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Image(
                                    image: AssetImage("asset/images/Pill.png"),
                                    height: 100,
                                    width: 100,
                                  ),
                                  // Spacer(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Medical History",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //3rd Feature Entertainment
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 4, 105, 11),
                            borderRadius: BorderRadius.circular(15),
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
                                children: <Widget>[
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Image(
                                    image: AssetImage(
                                        "asset/images/Rectangle 27.png"),
                                    height: 100,
                                    width: 100,
                                  ),
                                  // Spacer(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Entertainment",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        ///4th Feature Instruction
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[900],
                            borderRadius: BorderRadius.circular(15),
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
                                children: <Widget>[
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Image(
                                    image:
                                        AssetImage("asset/images/Instruct.png"),
                                    height: 100,
                                    width: 100,
                                  ),
                                  // Spacer(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Mother\nInstructions",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
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
                    //    const SizedBox(
                    //   height: 20,
                    // ),
                    // Text("Nearaby Doctors:")
                  ),
                  Row(
                    children: [
                      Text(
                        "Nearby Doctors:",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Row(
                      children: [
                        const Image(
                            image: AssetImage('asset/images/Image.png')),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dr.Mazen",
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "About 800m Away from your Location",
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            )),
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
  // void openCommunityScreen() {
  //   // Navigator.pushNamed(context as BuildContext, '/home_layout');
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 182, 76, 76),
        borderRadius: BorderRadius.circular(15),
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
            children: <Widget>[
              // Spacer(),
              const SizedBox(
                height: 15,
              ),
              Image(
                image: AssetImage(svgSrc),
                height: 90,
                width: 90,
              ),
              // Spacer(),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
