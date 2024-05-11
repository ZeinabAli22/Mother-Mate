import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proj_app/pages/Vaccenation/add_vaccen_screen.dart';
import 'package:proj_app/pages/Vaccenation/vaccen.dart';

class VaccenationScreen extends StatefulWidget {
  const VaccenationScreen({Key? key}) : super(key: key);

  @override
  State<VaccenationScreen> createState() => _VaccenationScreenState();
}
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final String? uid = user?.uid;
class _VaccenationScreenState extends State<VaccenationScreen> {
  CollectionReference vaccenCollection =
  FirebaseFirestore.instance.collection('vaccenations');

  Future<void> deleteVaccen(String docId) async {
    await vaccenCollection.doc(docId).delete();
  }
  late String Username = 'loading...';

  Future<void> getUserData() async {


    if (uid!= null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      setState(() {
        Username =userData['username'];

      });
      print(' Email: ${userData['email']}');
      print(' username: ${userData['username']}');
    } else {
      print('No user is currently signed in.');
    }
  }
  @override
  void initState() {
    super.initState();
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? uid = user?.uid;

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
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddVaccenScreen((newVaccenTitle) {
                  if (newVaccenTitle.trim().isNotEmpty) {
                    // Perform action only if the text field is not empty
                    vaccenCollection.add({'uid': uid, 'name': newVaccenTitle});
                    Navigator.pop(context);
                  } else {
                    // Show a generic SnackBar when the text field is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(''),
                      ),
                    );
                  }
                }),
              ),
            ),
          );
        },
        backgroundColor: Colors.indigo[800],
        icon: Icon(Icons.add),
        label: Text(
          'Add Vaccenation',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
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
        child: StreamBuilder<QuerySnapshot>(
          stream: vaccenCollection.where('uid', isEqualTo: uid).snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50), // 50% of the width/height for a perfect circle
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10,right: 10),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot document = snapshot.data!.docs[index];
                    final String vaccenTitle = document['name'];
                    final String docId = document.id;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Dismissible(

                        key: Key(docId),
                        direction: DismissDirection.startToEnd,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(right: 30.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          // You can add a confirmation dialog here if needed
                          return true;
                        },
                        onDismissed: (direction) {
                          deleteVaccen(docId);
                        },
                        child: ListTile(
                          title: Text(
                            vaccenTitle,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // You can add more information or actions to the list tile if needed
                        ),
                      ),
                    );
                  },
                ),
              ),

            );
          },
        ),
      ),
    );
  }
}
