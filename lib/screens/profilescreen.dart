import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:myvideo/variable.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  bool dataisthere = false;
  TextEditingController usernamecontroller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    DocumentSnapshot userdoc = await usercollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      username = userdoc.get('username');
      dataisthere = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[250],
      body: dataisthere == false ? Center(
        child: CircularProgressIndicator(),
      ) : Stack(
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: GradientColors.facebookMessenger
                )
              ),
            )
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 2 - 64,
              top: MediaQuery.of(context).size.height / 3.1
            ),
            child: CircleAvatar(
              radius: 64,
              child: ClipOval(
                child: ColorFiltered(
                    child: Image.asset("assets/Images/profile.png"),
                    colorFilter: ColorFilter.mode(Colors.yellow, BlendMode.color),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                ),
                Text(
                  username,
                  style: mystyle(40, Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    openEditProfileDialog();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: GradientColors.cherry)
                    ),
                    child: Center(
                      child: Text(
                        "Edit Profile",
                        style: mystyle(17, Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: 40,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: GradientColors.darkOcean)
                    ),
                    child: Center(
                      child: Text(
                        "SignOut",
                        style: mystyle(17, Colors.white),
                      ),
                    ),
                  ),
                  onTap: (){
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          )
        ],
      )
    );
  }


  openEditProfileDialog() async {
      return showDialog(
          context: context,
          builder: (context){
            return Dialog(
              child: Container(
                height: 200,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        controller: usernamecontroller,
                        style: mystyle(18, Colors.black),
                        decoration: InputDecoration(
                          labelText: "Update Username",
                          labelStyle: mystyle(16, Colors.grey)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () => editProfile(),
                      child: Container(
                        width: MediaQuery.of(context).size.width/2,
                        height: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: GradientColors.cherry)
                        ),
                        child: Center(
                          child: Text(
                            "Update now",
                            style: mystyle(17, Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ),
            );
          }
      );
  }

  editProfile() async{
    usercollection.doc(FirebaseAuth.instance.currentUser.uid).update({
      'username' : usernamecontroller.text
    });
    setState(() {
      username = usernamecontroller.text;
    });
    Navigator.pop(context);
  }
}
