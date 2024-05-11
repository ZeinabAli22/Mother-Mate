// growth.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Growth extends StatefulWidget {
  const Growth({Key? key}) : super(key: key);

  @override
  State<Growth> createState() => _GrowthState();
}

class _GrowthState extends State<Growth> {
  final TextEditingController _weightController = TextEditingController();
  final GrowthService _growthService = GrowthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Growth',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _growthService.getWeightEntries(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final weightEntries = snapshot.data!.docs;
                if (weightEntries.isEmpty) {
                  return  Container(
                    height: 200, // Set a fixed height for the container
                    child: SizedBox(
                      child: Column(
                        children: [
                          Image.asset(
                            'asset/images/baby.png',
                            color: Colors.grey,
                            scale: 0.7,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "No data to show",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: weightEntries.length,
                  itemBuilder: (context, index) {
                    final entry = weightEntries[index];
                    final weight = entry['weight'];
                    final entryDate = entry['entryDate'] != null
                        ? DateFormat('yyyy-MM-dd HH:mm:ss').format((entry['entryDate'] as Timestamp).toDate())
                        : '';
                    return ListTile(
                      title: Text('$weight kg'),
                      subtitle: Text(entryDate),
                    );
                  },
                );

              },
            ),
          ),
          Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                children: [
                  TextFormField(
                    controller: _weightController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter weight';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Weight (kg)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await _growthService.addWeightEntry(_weightController.text.trim());
                          _weightController.clear();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xff49CCD3)),
                    ),
                    child: const Text(
                      "Add Weight",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class GrowthService {
  final CollectionReference _weightCollection = FirebaseFirestore.instance.collection('weight_entries');

  Future<void> addWeightEntry(String weight) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _weightCollection.add({
        'userId': user.uid,
        'weight': double.parse(weight),
        'entryDate': Timestamp.now(),
      });
    }
  }

  Stream<QuerySnapshot> getWeightEntries() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return _weightCollection.where('userId', isEqualTo: user.uid).snapshots();
    }
    return Stream.empty();
  }
}
