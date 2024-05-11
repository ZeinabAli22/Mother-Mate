import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenG extends StatelessWidget {
  const HomeScreenG({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.pink[200],
        body: Stack(
          children: <Widget>[
            Container(
              height: size.height * .45,
              decoration: BoxDecoration(
                color: Colors.pink[200],
              ),
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
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
                            color: Colors.blue[300],
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
                              onTap: () {},
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
                        //3rd
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.teal[300],
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
                                Navigator.pushNamed(context, 'entert');
                              },
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

                        ///4th
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.deepPurple[200],
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
                                Navigator.pushNamed(context, "Instruction");
                              },
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

// ignore: must_be_immutable
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.pink[400],
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
            Navigator.pushNamed(context, "home_layout");
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
