// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdsDoctor extends StatelessWidget {
  const AdsDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.teal[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Get the Best Medical Services',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  'We provide best quality medical services without further cost',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Image.asset('asset/images/Doctors.png'),
        ],
      ),
    );
  }
}
