// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:proj_app/pages/Vaccenation/vaccen.dart';
import 'package:proj_app/pages/Vaccenation/vacen_list.dart';

class VaccenList extends StatefulWidget {
  final List<Vaccens> vaccen;
//  const VaccenList({Key? key, this.vaccen}) : super(key: key);
  const VaccenList(this.vaccen);

  @override
  State<VaccenList> createState() => _VaccenListState();
}

class _VaccenListState extends State<VaccenList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.vaccen.length,
      itemBuilder: (context, index) {
        return VaccenTile(
            vaccenTitle: widget.vaccen[index].name,
            isChecked: widget.vaccen[index].isDone,
            checkboxChange: (bool? newvalue) {
              setState(() {
                // isChecked = newvalue!;
                widget.vaccen[index].doneChange();
              });
            });
      },
    );
    // return ListView(
    //   // ignore: prefer_const_literals_to_create_immutables
    //   children: [
    //     VaccenTile(
    //       vaccenTitle: vaccen[0].name,
    //       isChecked: vaccen[0].isDone,
    //     ),
    //     VaccenTile(
    //       vaccenTitle: vaccen[1].name,
    //       isChecked: vaccen[1].isDone,
    //     ),
    //     VaccenTile(
    //       vaccenTitle: vaccen[2].name,
    //       isChecked: vaccen[2].isDone,
    //     ),
    //   ],
    // );
  }
}
