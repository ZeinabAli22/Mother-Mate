import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:proj_app/layout/add_post.dart';
import 'package:proj_app/layout/chats.dart';
import 'package:proj_app/layout/home.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const AddPostScreen(),
    const ChatsScreen(),
  ];

  List<String> titles = [
    'Explore',
    'Create Post',
    'Chats',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            titles[currentIndex],
            // textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.blue[300],
        ),
        body: screens[currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.blueAccent,
            animationDuration: const Duration(milliseconds: 300),
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
              // print(index);
            },
            buttonBackgroundColor: Colors.white,
            items: const [
              CurvedNavigationBarItem(
                child: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.add),
                label: 'Create Post',
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.chat_bubble),
                label: 'Chats',
              ),
            ]));
  }
}
