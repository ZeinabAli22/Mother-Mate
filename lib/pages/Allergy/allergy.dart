import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/pages/Allergy/add_allergy.dart';
import 'package:proj_app/pages/Allergy/allergylist.dart';
import 'package:proj_app/pages/Allergy/data.dart';

class Allergy extends StatefulWidget {
  const Allergy({super.key});

  @override
  State<Allergy> createState() => _AllergyState();
}

class _AllergyState extends State<Allergy> {
  List<Allergies> allergy = [Allergies(name: 'Allergy')];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddAllergy((newAllergyTitle) {
                        setState(() {
                          allergy.add(Allergies(name: newAllergyTitle));
                          Navigator.pop(context);
                        });
                      }))));
        },
        backgroundColor: Colors.blue[500],
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 35,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[200],
        // leading
        title: Text(
          'Allergy List',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 60,
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: AllergyList(allergy),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
