// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/widget/advertising.dart';

class MedicalPerscription extends StatefulWidget {
  const MedicalPerscription({super.key});

  @override
  State<MedicalPerscription> createState() => _MedicalPerscriptionState();
}

class _MedicalPerscriptionState extends State<MedicalPerscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
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
                color: Colors.indigo,
                size: 30,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: <Widget>[
              Text("Mother Mate",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: Container(
                  height: 90,
                  padding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'View Prescription',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.indigo[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.open_in_new_rounded,
                          color: Colors.indigo,
                        )),
                  ]),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'doctor_screen');
                },
              ),
              const SizedBox(
                height: 30,
              ),
              AdsDoctor(),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                child: Container(
                  height: 90,
                  padding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Scan Prescription',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.indigo[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(35)),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.qr_code_scanner_rounded,
                            color: Colors.white,
                            size: 30,
                          )),
                    ),
                  ]),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'doctor_screen');
                },
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                child: Container(
                  height: 90,
                  padding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upload Photo',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.indigo[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(35)),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.upload_file_rounded,
                            color: Colors.white,
                            size: 30,
                          )),
                    ),
                  ]),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'doctor_screen');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
