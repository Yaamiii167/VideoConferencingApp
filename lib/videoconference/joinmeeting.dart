import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:myvideo/variable.dart';
import 'package:myvideo/videoconference/ListScreen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController roomcontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  bool isVideoMuted = true;
  bool isAudioMuted = true;
  String username = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    DocumentSnapshot userdoc =
        await usercollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      // username = userdoc.data()['username'];
      username = "demo";
    });
  }

  joinMeeting() async {
    FirebaseFirestore.instance.collection("meet").add({
      "meeting id": roomcontroller.text,
      "name" : namecontroller.text,
      "enrollment number" : numbercontroller.text
    });
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;

      if (Theme.of(context).platform == TargetPlatform.android) {
        featureFlag.callIntegrationEnabled = false;
      } else {
        featureFlag.pipEnabled = false;
      }

      var options = JitsiMeetingOptions()
        ..room = roomcontroller.text
        ..userDisplayName =
            namecontroller.text == '' ? username : namecontroller.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlag = featureFlag;

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("error:" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Room Code",
                  style: mystyle(20),
                ),
                SizedBox(
                  height: 20,
                ),
                PinCodeTextField(
                    controller: roomcontroller,
                    appContext: context,
                    length: 6,
                    autoDisposeControllers: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
                    animationDuration: Duration(microseconds: 300),
                    onChanged: (val) {}),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Please enter your name",
                      labelStyle: mystyle(15)),
                  style: mystyle(20),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: numbercontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Please enter your enrollment number",
                      labelStyle: mystyle(15)),
                  style: mystyle(20),
                ),
                SizedBox(
                  height: 16,
                ),
                CheckboxListTile(
                  value: isVideoMuted,
                  onChanged: (value) {
                    setState(() {
                      isVideoMuted = value;
                    });
                  },
                  title: Text(
                    "Video Muted",
                    style: mystyle(18, Colors.black),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                CheckboxListTile(
                  value: isAudioMuted,
                  onChanged: (value) {
                    setState(() {
                      isAudioMuted = value;
                    });
                  },
                  title: Text(
                    "Audio Muted",
                    style: mystyle(18, Colors.black),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Of Course, you can customise your settings in the metting",
                  style: mystyle(15),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  height: 48,
                  thickness: 2.0,
                ),
                InkWell(
                  onTap: () => joinMeeting(),
                  child: Container(
                    width: double.maxFinite,
                    height: 64,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: GradientColors.facebookMessenger)),
                    child: Center(
                      child: Text(
                        "Join meeting",
                        style: mystyle(20, Colors.white),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 20,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ListScreen(roomcontroller.text))),
                  child: Container(
                    width: double.maxFinite,
                    height: 64,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: GradientColors.darkPink)),
                    child: Center(
                      child: Text(
                        "check list",
                        style: mystyle(20, Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
