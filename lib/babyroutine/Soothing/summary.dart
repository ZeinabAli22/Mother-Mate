import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SoothingSummary extends StatelessWidget {
  final List<String> sleepData;

  const SoothingSummary({super.key, required this.sleepData});

  Stream<QuerySnapshot> _getSleepData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('sleepData')
          .orderBy('timestamp', descending: true)
          .snapshots();
    } else {
      return const Stream.empty();
    }
  }

  Future<void> _deleteAllSleepData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final batch = FirebaseFirestore.instance.batch();
      final snapshots = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('sleepData')
          .get();
      for (var doc in snapshots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.abc_sharp,size: 0,),
        title: const Text('Reset Sleep Summary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              await _deleteAllSleepData();
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getSleepData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }

          final sleepData = snapshot.data?.docs ?? [];

          if (sleepData.isEmpty) {
            return Column(
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(flex: 1, child: Container()),
                const Expanded(
                  flex: 3,
                  child: SizedBox(
                    child: Column(
                      children: [
                        Icon(
                          Icons.dataset_rounded,
                          size: 100,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "No Data to Show",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            );
          }

          return ListView.builder(
            itemCount: sleepData.length,
            itemBuilder: (context, index) {
              final data = sleepData[index];
              final sleepDuration = data['sleepDuration'] ?? 'No Data';

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: const Icon(Icons.bedtime),
                  title: Text(sleepDuration),
                  subtitle: Text(data['timestamp'] != null
                      ? (data['timestamp'] as Timestamp).toDate().toString()
                      : 'No Timestamp'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
