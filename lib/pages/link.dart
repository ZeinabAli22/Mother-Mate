// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Center(
        child: Link(
          target: LinkTarget.blank,
          uri: Uri.parse('https://www.youtube.com/watch?v=cSR34CNXLvo&t=39s'),
          builder: (context, followLink) => ElevatedButton(
            onPressed: followLink,
            child: Text('Open Link'),
          ),
        ),
      ),
    );
  }
}
