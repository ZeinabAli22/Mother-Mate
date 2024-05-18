import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../editbaby.dart';

class ListBabiesScreen extends StatefulWidget {
  const ListBabiesScreen({super.key});

  @override
  State<ListBabiesScreen> createState() => _ListBabiesScreenState();
}

class _ListBabiesScreenState extends State<ListBabiesScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Map<String, dynamic>>> fetchBabies() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final List<Map<String, dynamic>> babies =
      List<Map<String, dynamic>>.from(userDoc['babies'] ?? []);
      return babies;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Babies List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchBabies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No babies found.'));
          } else {
            final babies = snapshot.data!;
            return ListView.builder(
              itemCount: babies.length,
              itemBuilder: (context, index) {
                final baby = babies[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        baby['name']?[0]?.toUpperCase() ?? '',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      baby['name'] ?? 'No Name',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Birth date: ${baby['dob'] ?? 'No DOB'}\nWeight: ${baby['weight'] ?? 'No Weight'}',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit, color: Colors.blueAccent),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditBabyDetailsScreen(
                              babyIndex: index,
                              babyData: baby,
                            ),
                          ),
                        ).then((_) => setState(() {})); // Refresh the list after editing
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditBabyDetailsScreen(),
            ),
          ).then((_) => setState(() {})); // Refresh the list after adding
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
