import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/widget/Categories_Med.dart';

class MedicalHistoryScreen extends StatefulWidget {
  const MedicalHistoryScreen({super.key});

  @override
  State<MedicalHistoryScreen> createState() => _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  void openAllergieScreen() {
    Navigator.pushNamed(context, 'allergies_screen');
  }

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
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Mother Mate",
                    style: GoogleFonts.inter(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                const SizedBox(
                  height: 20,
                ),
                const MedicalCateg(
                    img: 'asset/images/image 46.png', title: 'Schedual'),
                const SizedBox(
                  height: 20,
                ),

                //2nnddd categoryy

                InkWell(
                  child: Container(
                    height: 90,
                    padding: const EdgeInsets.symmetric(
                        vertical: 22, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(children: [
                      Image.asset(
                        'asset/images/image 77.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Doctors',
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
                    ]),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'doctor_screen');
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                //3rd category

                InkWell(
                  child: const MedicalCateg(
                      img: 'asset/images/image 35.png', title: 'Baby routine'),
                  onTap: () {
                    Navigator.pushNamed(context, 'baby_routine');
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Container(
                    height: 90,
                    padding: const EdgeInsets.symmetric(
                        vertical: 22, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(children: [
                      Image.asset(
                        'asset/images/Physical Therapy Icon.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vaccinations',
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
                    ]),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'vaccenation_screen');
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                //5th category

                InkWell(
                  child: const MedicalCateg(
                      img: 'asset/images/image 45.png',
                      title: 'Medical History'),
                  onTap: () {
                    Navigator.pushNamed(context, 'medical_perspective');
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: openAllergieScreen,
                  child: Container(
                    height: 90,
                    padding: const EdgeInsets.symmetric(
                        vertical: 22, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(children: [
                      Image.asset(
                        'asset/images/Allergies.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Allergies',
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
                    ]),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
