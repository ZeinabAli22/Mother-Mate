// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class AddVaccenScreen extends StatelessWidget {
  final Function addVaccenCallback;
  const AddVaccenScreen(this.addVaccenCallback);

  @override
  Widget build(BuildContext context) {
    String? newVaccenTitle;
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Vaccen',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[800]),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newVaccenTitle = newText;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              addVaccenCallback(newVaccenTitle);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.indigo[800],
            ),
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
