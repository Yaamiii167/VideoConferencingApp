import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:myvideo/authentication/LoginScreen.dart';
import 'package:myvideo/authentication/RegisterScreen.dart';
import 'package:myvideo/variable.dart';

class NavigateAuthScreen extends StatefulWidget {
  @override
  _NavigateAuthScreenState createState() => _NavigateAuthScreenState();
}

class _NavigateAuthScreenState extends State<NavigateAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: GradientColors.blue),
            ),
            child: Center(
              child: Image.asset(
                "assets/Images/logo.png",
                height: 100,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.6,
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: GradientColors.beautifulGreen,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "Sign in",
                          style: mystyle(30, Colors.white),
                        ),
                      ),
                    ),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen())),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: GradientColors.pink,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: mystyle(30, Colors.white),
                        ),
                      ),
                    ),
                    onTap: ()=> Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegisterScreen())),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
