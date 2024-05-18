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
  final TextEditingController _heightController = TextEditingController();
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
              stream: _growthService.getEntries(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final entries = snapshot.data!.docs;
                if (entries.isEmpty) {
                  return Container(
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
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    final weight = entry['weight'];
                    final height = entry['height'];
                    final entryDate = entry['entryDate'] != null
                        ? DateFormat('yyyy-MM-dd HH:mm:ss').format((entry['entryDate'] as Timestamp).toDate())
                        : '';
                    return ListTile(
                      title: Text('Weight: $weight kg, Height: $height cm'),
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
                  TextFormField(
                    controller: _heightController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter height';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Height (cm)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await _growthService.addEntry(
                            _weightController.text.trim(),
                            _heightController.text.trim(),
                          );
                          _weightController.clear();
                          _heightController.clear();
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
                      "Add Entry",
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
  final CollectionReference _collection = FirebaseFirestore.instance.collection('entries');

  Future<void> addEntry(String weight, String height) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _collection.add({
        'userId': user.uid,
        'weight': double.parse(weight),
        'height': double.parse(height),
        'entryDate': Timestamp.now(),
      });
    }
  }

  Stream<QuerySnapshot> getEntries() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return _collection.where('userId', isEqualTo: user.uid).snapshots();
    }
    return Stream.empty();
  }
}
