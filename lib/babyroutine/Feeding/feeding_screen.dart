import 'package:flutter/material.dart';
import 'package:proj_app/babyroutine/Feeding/bottle_page.dart';
import 'package:proj_app/babyroutine/Feeding/solid_page.dart';
import 'package:proj_app/babyroutine/Feeding/summary.dart';

class FeedingMain extends StatefulWidget {
  const FeedingMain({super.key});

  @override
  State<FeedingMain> createState() => _FeedingMainState();
}

class _FeedingMainState extends State<FeedingMain> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            'Feeding',
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
          ),
          bottom: const TabBar(
            labelColor: Color(0xff49CCD3),
            indicatorColor: Color(0xff49CCD3),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: "BOTTLE",
              ),
              Tab(
                text: "SOLIDS",
              ),

            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FeedingBottle(),
            FeedingSolid(),
          ],
        ),
      ),
    );
  }
}
