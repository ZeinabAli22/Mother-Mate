// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructionScreen extends StatelessWidget {
  const InstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        elevation: 0.0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg'),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Hi, Malek',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo[500]),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_rounded,
                color: Colors.purple,
                size: 30,
              )),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
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
            const InfoCard(
              title: 'How to make your\nbaby sleep',
              text: 'Our tips on how to organize\nyour baby sleep time ...',
              imag: 'asset/images/image 898.png',
            ),
            const SizedBox(
              height: 20,
            ),
            const InfoCard(
              title: 'Breast Feeding or\nFormula',
              text: 'Our tips on Breast feeding\nbaby or using formal...',
              imag: 'asset/images/image 897.png',
            ),
            const SizedBox(
              height: 20,
            ),
            const InfoCard(
              title: 'How To Manage\nTwo under Two',
              text: 'Our tips on This\nSpecific subject..',
              imag: 'asset/images/image 895.png',
            ),
            const SizedBox(
              height: 20,
            ),
            const InfoCard(
              title: 'How To make your baby\nfeel safe ?',
              text: 'Many step to make your \nbaby feel cared ...',
              imag: 'asset/images/image 896.png',
            ),
          ],
        ),
      )),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String imag;
  final String title;
  final String text;

  const InfoCard({
    super.key,
    required this.imag,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
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
                        color: const Color.fromARGB(255, 178, 58, 197),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      text,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple[200]),
                        foregroundColor:
                            const MaterialStatePropertyAll(Colors.white),
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
