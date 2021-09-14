import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../variable.dart';

class ListScreen extends StatefulWidget {
  var roomid;
  var li = ["abc","abd","abm"];
  ListScreen(var roomid)
  {
    this.roomid = roomid;
  }
  @override
  _ListScreenState createState() => _ListScreenState(roomid);
}

class _ListScreenState extends State<ListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var roomid;
  List studentList =[];
  var snapshots2;
  _ListScreenState(var roomid)
  {
    this.roomid =roomid;
  }

  @override
  void initState() {
    super.initState();
    snapshots2 = FirebaseFirestore.instance.collection('meet').snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Attendance"
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('meet').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.hasData)
              {
                studentList.clear();
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.size,
                              itemBuilder: (context,index)
                              {
                                print(index);
                                print("meet id : " + snapshot.data.docs[index].get("meeting id"));
                                print(roomid);
                                print("name : " + snapshot.data.docs[index].get("name"));
                                if(roomid.toString() == snapshot.data.docs[index].get("meeting id").toString())
                                {
                                  studentList.add(snapshot.data.docs[index]);
                                  print("my length : " + studentList.length.toString());
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom:8.0),
                                    child: Container(
                                      height: 60,
                                      color: Colors.grey[350],
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Name :" + snapshot.data.docs[index].get("name"),
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "enrollment number :" + snapshot.data.docs[index].get("enrollment number"),
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                else
                                  {
                                    return Container();
                                  }
                              }
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () => getCsv(),
                          child: Container(
                            width: double.maxFinite,
                            height: 64,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: GradientColors.darkPink)),
                            child: Center(
                              child: Text(
                                "Download list",
                                style: mystyle(20, Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            /*return ListView(
              children: snapshot.data.docs.map((document) {
                return Container(
                  child: Center(child: Text(document['name'])),
                );
              }).toList(),
            );*/
          },
        ),
      ),
    );
  }

  getCsv() async {
    List<List<dynamic>> rows = List<List<dynamic>>();
    var header1= "Meeting id";
    var header2 = "Roll no.";
    var header3 = "Name";
    studentList.insert(0,header1);
    print(studentList[0]);
    print("student length" + studentList.length.toString());
    for (int i = 0; i < studentList.length; i++) {
      List row = [];
      if(i!=0)
        {
          row.add(studentList[i].get("meeting id"));
          row.add(studentList[i].get("enrollment number"));
          row.add(studentList[i].get("name"));
        }
      else
        {
          row.add(header1);
          row.add(header2);
          row.add(header3);
        }
      rows.add(row);
    }
      print("rows" + rows.toString());
      print("hello world");
      final path = await _localPath;
      String p = await path.substring(0,20)+"Documents";
      print("local path" + path);
      print(p);
      File dir = await File(path+"/attend.csv");
      print(dir);
      dir.openWrite();
      String csv = const ListToCsvConverter().convert(rows);
      dir.writeAsString(csv);
    print(path);
    print(p);
      _showScaffold("Successfully downloaded");
  }
  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<String> get _localPath async {
    final directory = (await getExternalStorageDirectory()).path;
    return directory;
  }}




