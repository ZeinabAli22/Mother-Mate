import 'package:flutter/material.dart';
import 'package:proj_app/babyroutine/Soothing/sleeping_page.dart';
import 'package:proj_app/babyroutine/Soothing/summary.dart';

class SoothingMain extends StatefulWidget {
  const SoothingMain({super.key});

  @override
  State<SoothingMain> createState() => _SoothingMainState();
}

class _SoothingMainState extends State<SoothingMain> {
  List<String> sleepData = [];

  void updateSleepData(String data) {
    setState(() {
      sleepData.add(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            'Soothing',
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
          ),
          bottom: const TabBar(
            labelColor: Color(0xff49CCD3),
            indicatorColor: Color(0xff49CCD3),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: "SLEEPING",
              ),
              Tab(
                text: "SUMMARY",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SoothingSleeping(onFinish: updateSleepData),
            SoothingSummary(sleepData: sleepData),
          ],
        ),
      ),
    );
  }
}
