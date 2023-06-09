// ignore_for_file: camel_case_types, prefer_const_constructors, unused_import, sort_child_properties_last, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mainproject/services/subject_service.dart';
import '../../../assets/drawer.dart';

class Subject_details extends StatefulWidget {
  const Subject_details({super.key});

  @override
  State<Subject_details> createState() => _Subject_detailsState();
}

class _Subject_detailsState extends State<Subject_details> {
  String? userId = "", firstname = "", secondname = "", usertype = "";
  List? subjectdetails;
  // int? lecid;
  String? semester;
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
      firstname = allValues["fname"];
      secondname = allValues["sname"];
      usertype = allValues["utype"];
    });
    getsubdetails();
  }

  // final storage = new FlutterSecureStorage();
  bool isLoggedin = true;
  Future<void> checkAuthentication() async {
    try {
      Map<String, String> allValues = await storage.readAll();
      if (allValues["token"] == "") {
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        Navigator.pushNamed(context, "/login");
      } else {
        // this.getToken();
      }
    } catch (e) {}
  }

  subjectservice subjectassign = subjectservice();
  Future<void> getsubdetails() async {
    try {
      var subject = jsonEncode({
        "semester": semester,
      });
      final Response? res = await subjectassign.showsubdetails(subject);
      // print(res);
      if (res!.statusCode == 201) {
        setState(() {
          subjectdetails = res.data;
        });
        print(subjectdetails);
      }
    } on DioError catch (err) {
      if (err.response != null) {}
    }
  }

  showErrorrs(String content, String title, String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Yes"),
                onPressed: () {
                  removesubject(id);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  showErrorra(String content, String title, String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Yes"),
                onPressed: () {
                  removeassignsub(id);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  showError2(String content, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text("ok"),
                onPressed: () {
                  if (title == "Click Ok") {
                    Navigator.pushNamed(context, '/admndashboard');
                    Navigator.of(context).pop();
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> removesubject(String id) async {
    try {
      var sub = jsonEncode({"_id": id});
      print(sub);
      final Response? res = await subjectassign.removesubject(sub);
      if (res!.statusCode == 201) {
        showError2("Successfully deleted", "Click Ok");
      }
    } on DioError catch (err) {
      if (err.response != null) {
        showError2("Something Went Wrong", "Try Again Later");
      }
    }
  }

  Future<void> removeassignsub(String id) async {
    try {
      var sub = jsonEncode({"_id": id});
      print(sub);
      final Response? res = await subjectassign.removeassignsubject(sub);
      if (res!.statusCode == 201) {
        showError2("Successfully Removed", "Click Ok");
      }
    } on DioError catch (err) {
      if (err.response != null) {
        showError2("Something Went Wrong", "Try Again Later");
      }
    }
  }

  void initState() {
    super.initState();
    this.getToken();
  }

  @override
  Widget build(BuildContext context) {
    final Object? subjectsemester =
        ModalRoute.of(context as BuildContext)?.settings.arguments;
    semester = subjectsemester.toString();
    // print(semester);
    return Container(
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          // ignore: prefer_const_constructors
          title: Text(
            "INNOVIS",
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontFamily: 'RobotoMono'),
          ),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/admnaddpost");
                    },
                    // ignore: prefer_const_constructors
                    icon: Icon(Icons.add_card_sharp))),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/admnmessage");
                    },
                    icon: Icon(Icons.message_sharp)))
          ],
        ),
        body: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'List Of Subjects',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 228, 230, 233),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 500,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: subjectdetails?.length,
                        itemBuilder: (context, index) {
                          final subjectdetail = subjectdetails?[index];
                          var subDetails = subjectdetail?["sub_details"];
                          String? id = subjectdetail?['_id'] ?? "";
                          var assignedTo = "Nill";
                          if (subDetails != null && subDetails.isNotEmpty) {
                            var firstDetail = subDetails[0];
                            assignedTo =
                                (firstDetail?["subteacherfname"] ?? "Nill") +
                                    " " +
                                    (firstDetail?["subteachersname"] ?? "Nill");
                          }
                          var assignedToText = "Assigned To: $assignedTo";
                          return Card(
                            elevation: 5,
                            margin: EdgeInsets.all(10),
                            child: ExpansionTile(
                              title: Text(
                                subjectdetail != null &&
                                        subjectdetail['subjectname'] != null
                                    ? subjectdetail['subjectname']
                                    : 'Unknown Subject',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // ignore: prefer_const_literals_to_create_immutables
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text("Subject Type:" +
                                            (subjectdetail != null &&
                                                    subjectdetail[
                                                            'subjecttype'] !=
                                                        null
                                                ? subjectdetail['subjecttype']
                                                : 'Unknown Subject Type')),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(assignedToText),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              showErrorrs(
                                                  "Do You Want To Delete This Post?",
                                                  "Are You Sure?",
                                                  id.toString());
                                            },
                                            child: Text(
                                              "Remove Subject",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              showErrorra(
                                                  "Do You Want To Delete This Post?",
                                                  "Are You Sure?",
                                                  id.toString());
                                            },
                                            child: Text(
                                              "Remove Subject Assign",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )),
                                      ],
                                    )),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: cldrawer(),
      ),
    );
  }
}
