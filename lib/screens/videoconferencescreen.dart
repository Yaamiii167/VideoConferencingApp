import 'package:flutter/material.dart';
import 'package:myvideo/variable.dart';
import 'package:myvideo/videoconference/createmeeting.dart';
import 'package:myvideo/videoconference/joinmeeting.dart';

class VideoConferenceScreen extends StatefulWidget {
  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen> with SingleTickerProviderStateMixin{
  TabController tabController;

  buildTab(String name) {
    return Container(
      width: 150,
      height: 50,
      child: Card(
        child: Center(
          child: Text(
            name,
            style: mystyle(15, Colors.black, FontWeight.w700),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MyVideo",
          style: mystyle(20, Colors.white, FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            buildTab("Join Meeting"),
            buildTab("Create Meeting")
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          JoinMeeting(),
          CreateMeeting()
        ],
      ),
    );
  }
}
