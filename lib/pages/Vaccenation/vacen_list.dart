// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class VaccenTile extends StatelessWidget {
  final bool isChecked;
  final String vaccenTitle;
  final void Function(bool?) checkboxChange;
  const VaccenTile(
      {required this.isChecked,
      required this.vaccenTitle,
      required this.checkboxChange});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        vaccenTitle,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.blue,
        value: isChecked,
        onChanged: checkboxChange,
      ),
    );
  }
}
//

