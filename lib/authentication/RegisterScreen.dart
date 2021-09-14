import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:myvideo/variable.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height / 2,
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 1.6,
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
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.7,
                    child: TextField(
                      controller: emailController,
                      style: mystyle(18, Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          hintStyle: mystyle(20, Colors.grey, FontWeight.w700)
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.7,
                    child: TextField(
                      controller: passwordController,
                      style: mystyle(18, Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          hintStyle: mystyle(20, Colors.grey, FontWeight.w700)
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.7,
                    child: TextField(
                      controller: usernameController,
                      style: mystyle(18, Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: Icon(Icons.person),
                          hintStyle: mystyle(20, Colors.grey, FontWeight.w700)
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2,
                      height: 45,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: GradientColors.pink,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: mystyle(25, Colors.white),
                        ),
                      ),
                    ),
                    onTap: () {
                      try
                          {
                            FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: emailController.text, password: passwordController.text).then((signedInUser) {
                              usercollection.doc(signedInUser.user.uid).set({
                                'username' : usernameController.text,
                                'email' : emailController.text,
                                'password' : passwordController.text,
                                'uid' : signedInUser.user.uid
                              });
                            });
                            Navigator.pop(context);
                          }catch(e){
                        print(e);
                        var snackbar = SnackBar(
                            content: Text(
                              e.toString(),
                              style: mystyle(20),
                            )
                        );
                        Scaffold.of(context).showSnackBar(snackbar);
                      }
                    },
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
