// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AllergiesScreen extends StatefulWidget {
  const AllergiesScreen({super.key});

  @override
  State<AllergiesScreen> createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        elevation: 0.0,
        title: const Row(children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
                'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg'),
          ),
          SizedBox(
            width: 10,
          ),
        ]),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit_rounded,
                color: Colors.indigo,
                size: 30,
              )),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Colors.blue[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(children: <Widget>[
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
              // Container(
              //   margin: const EdgeInsets.symmetric(vertical: 20),
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
                height: 15,
              ),
              AllergyCard(),
            ]),
          ),
        ],
      ),
    );
  }
}

class AllergyCard extends StatelessWidget {
  const AllergyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    '  Welcome Back!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Add Your Allergies Here',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
            ),
            Image.asset(
              'asset/images/Allergie.png',
              height: 180,
              // width: 110,
              // alignment: Alignment.topLeft,
            ),
            // const SizedBox(
            //   width: 20,
            // ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'allergy');
      },
    );
  }
}
