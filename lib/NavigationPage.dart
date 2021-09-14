
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myvideo/screens/HomePage.dart';
import 'package:myvideo/screens/IntroAuthScreen.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  bool isSigned = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if(user!=null){
        setState(() {
          isSigned = true;
        });
      }
      else
        {
          setState(() {
            isSigned = false;
          });
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSigned == false ? IntroAuthScreen() : HomePage(),
    );
  }
}
