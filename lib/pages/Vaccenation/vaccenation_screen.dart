// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proj_app/pages/Vaccenation/add_vaccen_screen.dart';
import 'package:proj_app/pages/Vaccenation/vaccen.dart';
import 'package:proj_app/pages/Vaccenation/vaccen_list.dart';

class VaccenationScreen extends StatefulWidget {
  const VaccenationScreen({super.key});

  @override
  State<VaccenationScreen> createState() => _VaccenationScreenState();
}

class _VaccenationScreenState extends State<VaccenationScreen> {
  List<Vaccens> vaccen = [
    Vaccens(name: 'Vaccens'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddVaccenScreen((newVaccenTitle) {
                          setState(() {
                            vaccen.add(Vaccens(name: newVaccenTitle));
                            Navigator.pop(context);
                          });
                        })),
                  ));
        },
        backgroundColor: Colors.indigo[800],
        icon: Icon(Icons.add),
        label: Text(
          'Add Vaccenation',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        // child: Icon(Icons.add),
      ),
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        elevation: 0.0,
        title: Text(
          'Vaccenation',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${vaccen.length} Vaccenations',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                // height: 300,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: VaccenList(vaccen),
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Container(
            //     padding: const EdgeInsets.all(16),
            //     width: double.infinity,
            //     child: ElevatedButton(
            //       onPressed: () {},
            //       style: ButtonStyle(
            //           backgroundColor:
            //               MaterialStateProperty.all(const Color(0xff49CCD3))),
            //       child: const Text(
            //         "Add Vaccenation",
            //         style: TextStyle(color: Colors.white, fontSize: 20),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
