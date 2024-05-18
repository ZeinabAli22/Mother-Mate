import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddVaccenScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) addVaccenCallback;

  const AddVaccenScreen(this.addVaccenCallback);

  @override
  _AddVaccenScreenState createState() => _AddVaccenScreenState();
}

class _AddVaccenScreenState extends State<AddVaccenScreen> {
  String? newVaccenTitle;
  int? doses;
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
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
            decoration: InputDecoration(hintText: 'Vaccine Name'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (newText) {
              doses = int.tryParse(newText);
            },
            decoration: InputDecoration(hintText: 'Doses'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () => _selectDate(context),
            child: Text(selectedDate == null
                ? 'Select Date'
                : DateFormat('yyyy-MM-dd').format(selectedDate!)),
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              widget.addVaccenCallback({
                'name': newVaccenTitle,
                'doses': doses,
                'date': selectedDate,
              });
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
