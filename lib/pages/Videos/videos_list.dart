// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class VideosCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  const VideosCard(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subtitle});

  @override
  State<VideosCard> createState() => _VideosCardState();
}

class _VideosCardState extends State<VideosCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 80,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Image.network(
                  widget.imagePath,
                  scale: 1,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.subtitle,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
