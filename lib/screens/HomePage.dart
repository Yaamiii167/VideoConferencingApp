import 'package:flutter/material.dart';
import 'package:myvideo/screens/profilescreen.dart';
import 'package:myvideo/screens/videoconferencescreen.dart';
import 'package:myvideo/variable.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var page = 0;
  List PageOptions = [
    VideoConferenceScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: mystyle(17, Colors.blue),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: mystyle(17, Colors.black),
        currentIndex: page,
        onTap: (index) {
          setState(
            () {
              page = index;
            },
          );
        },
        items: [
          BottomNavigationBarItem(
            label: "Video Call",
            icon: Icon(
              Icons.video_call,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              Icons.person,
              size: 32,
            ),
          ),
        ],
      ),
      body: PageOptions[page]
    );
  }
}
