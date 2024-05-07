import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proj_app/auth_page.dart';
import 'package:proj_app/babyroutine/baby_routine.dart';
import 'package:proj_app/pages/Allergy/allergies_screen.dart';
import 'package:proj_app/pages/Allergy/allergy.dart';
import 'package:proj_app/pages/doctors_screen.dart';
import 'package:proj_app/pages/entertainment.dart';
import 'package:proj_app/pages/games.dart';
// import 'package:proj_app/pages/jump.dart';
import 'package:proj_app/pages/medical_history.dart';
import 'package:proj_app/pages/medical_perspective.dart';
import 'package:proj_app/pages/storie_screen.dart';
import 'package:proj_app/pages/Vaccenation/vaccenation_screen.dart';
import 'firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:proj_app/layout/home_layout.dart';
import 'package:proj_app/pages/Instruction.dart';
// import 'package:proj_app/pages/Jump.dart';
import 'package:proj_app/pages/Sign.dart';
// import 'package:proj_app/pages/Signup.dart';
import 'package:proj_app/pages/choosegender.dart';
import 'package:proj_app/pages/entert.dart';
import 'package:proj_app/pages/homescreenboy.dart';
import 'package:proj_app/pages/homescreengirl.dart';
import 'package:proj_app/pages/signuup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,

  );
  runApp(const MyApp());
}
// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Auth(),
      // initialRoute: "/",
      routes: {
        '/': (context) => const Auth(),
        // "/": (context) => const Jump(),
        // "sign": (context) => const Sign(),
        "signup": (context) => const Signup(),
        "signuup": (context) => const SignUp(),
        "choosegender": (context) => const ChooseGender(),
        "homescreenboy": (context) => const HomeScreenB(),
        "homescreengirl": (context) => const HomeScreenG(),
        "home_layout": (context) => const HomeLayout(),
        "Instruction": (context) => const InstructionScreen(),
        "entert": (context) => EnterScreenB(),
        "entertainment": (context) => const EntertainScreen(),
        "medical_history": (context) => const MedicalHistoryScreen(),
        "doctor_screen": (context) => const DoctorScreen(),
        'baby_routine': (context) => const BabyRoutineScreen(),
        'storie_screen': (context) => const StoriesScreen(),
        'games': (context) => const GamesScreen(),
        'vaccenation_screen': (context) => const VaccenationScreen(),
        'allergies_screen': (context) => const AllergiesScreen(),
        'allergy': (context) => const Allergy(),
        'medical_perspective': (context) => const MedicalPerscription(),
      },
    );
  }
}
