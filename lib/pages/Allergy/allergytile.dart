// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class AllergyTile extends StatelessWidget {
  final String allergyTitle;

  const AllergyTile({required this.allergyTitle});
  // const AllergyTile({
  //   super.key,
  // });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(allergyTitle),
    );
  }
}
