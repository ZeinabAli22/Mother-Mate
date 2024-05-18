import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditBabyDetailsScreen extends StatefulWidget {
  final int? babyIndex;
  final Map<String, dynamic>? babyData;

  const EditBabyDetailsScreen({Key? key, this.babyIndex, this.babyData})
      : super(key: key);

  @override
  _EditBabyDetailsScreenState createState() => _EditBabyDetailsScreenState();
}

class _EditBabyDetailsScreenState extends State<EditBabyDetailsScreen> {
  final TextEditingController _babyNameController = TextEditingController();
  final TextEditingController _babyDobController = TextEditingController();
  final TextEditingController _babyWeightController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.babyData != null) {
      _babyNameController.text = widget.babyData!['name'] ?? '';
      _babyDobController.text = widget.babyData!['dob'] ?? '';
      _babyWeightController.text = widget.babyData!['weight'] ?? '';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _babyDobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _saveBabyDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentReference userDoc =
      FirebaseFirestore.instance.collection('users').doc(user.uid);

      final babyData = {
        'name': _babyNameController.text,
        'dob': _babyDobController.text,
        'weight': _babyWeightController.text,
      };

      setState(() {
        _isLoading = true;
      });

      try {
        final DocumentSnapshot userSnapshot = await userDoc.get();
        final List<dynamic> babies =
        List<dynamic>.from(userSnapshot['babies'] ?? []);

        if (widget.babyIndex == null) {
          // Add new baby details
          babies.add(babyData);
        } else {
          // Update existing baby details
          babies[widget.babyIndex!] = babyData;
        }

        await userDoc.update({'babies': babies});

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save data.'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _babyNameController.dispose();
    _babyDobController.dispose();
    _babyWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.babyIndex == null ? 'Add Baby Details' : 'Edit Baby Details'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _babyNameController,
                decoration: const InputDecoration(labelText: 'Baby\'s Name'),
              ),
              TextFormField(
                controller: _babyDobController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                onTap: () => _selectDate(context),
              ),
              TextFormField(
                controller: _babyWeightController,
                decoration: const InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveBabyDetails,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
