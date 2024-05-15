import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proj_app/auth_page.dart';
import 'package:proj_app/babyroutine/baby_routine.dart';
import 'package:proj_app/pages/Allergy/allergies_screen.dart';
import 'package:proj_app/pages/Allergy/allergy.dart';
import 'package:proj_app/pages/Ai-Engine/ai_screen.dart';
import 'package:proj_app/pages/About/aboutBaby.dart';
import 'package:proj_app/pages/About/aboutMother.dart';
import 'package:proj_app/pages/Onboarding/onboarding_page.dart';
import 'package:proj_app/pages/doctors_screen.dart';
import 'package:proj_app/pages/entertainment.dart';
import 'package:proj_app/pages/Games/game.dart';
import 'package:proj_app/pages/games.dart';
import 'package:proj_app/pages/homescreen.dart';
import 'package:proj_app/pages/jump.dart';
import 'package:proj_app/pages/link.dart';
// import 'package:proj_app/pages/jump.dart';
import 'package:proj_app/pages/medical_history.dart';
import 'package:proj_app/pages/medical_perspective.dart';
import 'package:proj_app/pages/profile_screen.dart';
import 'package:proj_app/pages/schedual_screen.dart';
import 'package:proj_app/pages/storie_screen.dart';
import 'package:proj_app/pages/Vaccenation/vaccenation_screen.dart';
import 'package:proj_app/pages/Videos/videos.dart';
import 'package:proj_app/pages/update_profile_screen.dart';
import 'firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:proj_app/layout/home_layout.dart';
import 'package:proj_app/pages/Instruction.dart';
// import 'package:proj_app/pages/Jump.dart';
import 'package:proj_app/pages/Sign.dart';
// import 'package:proj_app/pages/Signup.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:proj_app/pages/choosegender.dart';
import 'package:proj_app/pages/Girls/entert.dart';
import 'package:proj_app/pages/homescreenboy.dart';
import 'package:proj_app/pages/Girls/homescreengirl.dart';
import 'package:proj_app/pages/signuup.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('America/Detroit'));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

  await _requestPermissions();

  runApp(const MyApp());
}
Future<void> _requestPermissions() async {
  if (await Permission.systemAlertWindow.request().isGranted) {
    // Permission granted.
  }

  if (await Permission.scheduleExactAlarm.request().isGranted) {
    // Permission granted.
  }
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
        // '/': (context) => const Auth(),
        "/": (context) => const Jump(),
        // "sign": (context) => const Sign(),
        "signup": (context) => const Signup(),
        "signuup": (context) => const SignUp(),
        "ScheduleScreen": (context) => ScheduleScreen(),
        "choosegender": (context) => const ChooseGender(),
        'homescreen': (context) => const Home(),
        "homescreenboy": (context) => const HomeScreenB(),
        "homescreengirl": (context) => const HomeScreenG(),
        "home_layout": (context) => const HomeLayout(),
        "Instruction": (context) => const InstructionScreen(),
        "entert": (context) => const EntertainmentGirl(),
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
        'ai_screen': (context) => const AiEngineScreen(),
        'aboutMother': (context) => const AboutMother(),
        'aboutBaby': (context) => const AboutBaby(),
        'test': (context) => const Test(),
        'game': (context) => const GameScreen(),
        'videos': (context) => const VideosScreen(),
        'jump': (context) => const Jump(),
        'onboarding_page': (context) => const OnBoardingPage(),
        'profile_screen': (context) => ProfileScreen(),
        'update_profile': (context) => UpdateProfileScreen(),
      },
    );
  }
}
