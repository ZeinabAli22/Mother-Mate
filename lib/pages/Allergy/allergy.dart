import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/pages/Allergy/add_allergy.dart';
import 'package:proj_app/pages/Allergy/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Allergy extends StatefulWidget {
  const Allergy({Key? key}) : super(key: key);

  @override
  State<Allergy> createState() => _AllergyState();
}

class _AllergyState extends State<Allergy> {
  final CollectionReference allergenCollection =
  FirebaseFirestore.instance.collection('allergens');

  late String uid;
  List<Allergies> allergy = [];

  @override
  void initState() {
    super.initState();
    getUserUid();
    getAllergies();
  }

  Future<void> getUserUid() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        uid = user.uid;
      });
    } else {
      // Handle when user is not signed in
    }
  }

  Future<void> getAllergies() async {
    final QuerySnapshot snapshot =
    await allergenCollection.where('uid', isEqualTo: uid).get();

    setState(() {
      allergy = snapshot.docs
          .map((doc) => Allergies(name: doc['name'], id: doc.id))
          .toList();
    });
  }

  void addAllergy(String newAllergyTitle) async {
    print('Adding allergy: $newAllergyTitle');
    print('User UID: $uid'); // Check if uid is retrieved properly

    await allergenCollection.add({
      'uid': uid,
      'name': newAllergyTitle,
    });

    // Update the local list
    getAllergies();
  }

  void deleteAllergy(String allergyId) async {
    // Delete the allergy from Firestore
    await allergenCollection.doc(allergyId).delete();

    // Update the local list
    getAllergies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddAllergy(addAllergy),
              ),
            ),
          );
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
        title: Text(
          'Allergy List',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25), // Adjust the radius as needed
          ),
          child: ListView.builder(
            itemCount: allergy.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(allergy[index].id!), // Use id as the key
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 25.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  // Call deleteAllergy function when the ListTile is dismissed
                  deleteAllergy(allergy[index].id!);
                },
                child: ListTile(
                  title: Text(allergy[index].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
