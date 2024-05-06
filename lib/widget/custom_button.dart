// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  //
  final String text;
  const CustomButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.indigoAccent[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: MaterialButton(
          onPressed: () {},
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 60),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
