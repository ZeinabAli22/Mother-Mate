// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAllergy extends StatelessWidget {
  final Function addAllergyCallback;

  const AddAllergy(this.addAllergyCallback);

  @override
  Widget build(BuildContext context) {
    String? newAllergyTitle;
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Your Allergy',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700]),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newAllergyTitle = newText;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              addAllergyCallback(newAllergyTitle);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue[800],
            ),
            child: Text(
              'Add',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
