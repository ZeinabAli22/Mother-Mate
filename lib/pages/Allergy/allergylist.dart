// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:proj_app/pages/Allergy/allergytile.dart';
import 'package:proj_app/pages/Allergy/data.dart';

class AllergyList extends StatefulWidget {
  // const AllergyList({super.key});
  // final <Allergies> allergy;
  //  AllergyList(this.allergy,);
  final List<Allergies> allergy;

  const AllergyList(this.allergy);

  @override
  State<AllergyList> createState() => _AllergyListState();
}

class _AllergyListState extends State<AllergyList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.allergy.length,
        itemBuilder: (context, index) {
          return AllergyTile(
            allergyTitle: widget.allergy[index].name,
          );
        });
    // return ListView(
    //   children: [
    //     AllergyTile(),
    //     ListTile(
    //       title: Text('Go Shopping'),
    //     ),
    //   ],
    // );
  }
}
