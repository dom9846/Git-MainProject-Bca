// ignore_for_file: prefer_const_constructors, unnecessary_nullable_for_final_variable_declarations

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mainproject/services/getuser_service.dart';
import 'package:mainproject/services/rating_service.dart';
import 'package:mainproject/student/assets/drawer.dart';

class StudentRateTeach_Form extends StatefulWidget {
  const StudentRateTeach_Form({super.key});

  @override
  State<StudentRateTeach_Form> createState() => _StudentRateTeach_FormState();
}

class _StudentRateTeach_FormState extends State<StudentRateTeach_Form> {
  final _formkey = GlobalKey<FormState>();
  String? teaching = "", notes = "", behaviour = "", taskid;
  int? num1, num2, num3, sum;
  double? overall;
  String? jwt, userId;
  List? ratetasks;
  String? year = "", studentfname = "", studentsname = "";
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    getstudent();
  }

  bool isLoggedin = true;
  // final storage = new FlutterSecureStorage();
  Future<void> checkAuthentication() async {
    try {
      Map<String, String> allValues = await storage.readAll();
      if (allValues.isEmpty) {
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        Navigator.pushNamed(context, "/login");
      } else {
        // this.getToken();
        // getposts();
      }
    } catch (e) {}
  }

  getuserservice getstudentservice = new getuserservice();
  Future<void> getstudent() async {
    try {
      var user = jsonEncode({
        "id": userId,
      });
      final Response? res = await getstudentservice.getstudent(user);
      print(res);
      if (res!.statusCode == 201) {
        setState(() {
          studentfname = res.data["fname"].toString();
          studentsname = res.data["sname"].toString();
          // year = res.data["year"].toString();
        });
      }
    } on DioError catch (err) {
      if (err.response != null) {}
    }
    // retrieveassignedrating();
  }

  ratingService rateteacherservice = new ratingService();
  DateTime currentDateTime = DateTime.now();
  Future<void> rateteacherbystud() async {
    if (_formkey.currentState!.validate()) {
      if (teaching != null && notes != null && behaviour != null) {
        num1 = int.parse(teaching.toString());
        num2 = int.parse(notes.toString());
        num3 = int.parse(behaviour.toString());
        sum = (num1 ?? 0) + (num2 ?? 0) + (num3 ?? 0);
        overall = sum! / 3;
      }
      print(taskid);
      print(overall);
      var rate = jsonEncode({
        "id": taskid,
        "studentid": userId,
        "studentfname": studentfname,
        "studentsname": studentsname,
        "rating1": teaching,
        "rating2": notes,
        "rating3": behaviour,
        "overall": overall,
        "date": currentDateTime.toIso8601String()
      });
      print(rate);
      try {
        final Response? res = await rateteacherservice.rateteacher(rate);
        if (res!.statusCode == 201) {
          showError("Successfully rated!", "Committed");
        }
      } on DioError catch (err) {
        if (err.response != null) {
          if (err.response!.statusCode == 402) {
            showError("You Have Allready Rated!", "Cannot Done");
          }
        }
      }
    }
  }

  showError(String content, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  // if (title == "Registration Successful") {
                  //   // Navigator.pushNamed(context, '/login');
                  // } else
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void initState() {
    super.initState();
    this.getToken();
  }

  @override
  Widget build(BuildContext context) {
    final dynamic id =
        ModalRoute.of(context as BuildContext)?.settings.arguments;
    taskid = id['taskid'].toString();
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
                      Navigator.pushNamed(context, "/studaddnewpost");
                    },
                    // ignore: prefer_const_constructors
                    icon: Icon(Icons.add_card_sharp))),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/studmessage");
                    },
                    icon: Icon(Icons.message_sharp)))
          ],
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 55, top: 60),
              child: Text(
                'Rate_Lecturer',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 50, bottom: 50, left: 20, right: 20),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 22, 47, 230),
                                    ),
                                  ),
                                  labelText: "Teaching",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: "Rate Out Of 5",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 14, 14, 14)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This Field Cannot Be Empty";
                                } else {
                                  setState(() {
                                    teaching = value;
                                  });
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 22, 47, 230),
                                    ),
                                  ),
                                  labelText: "Notes",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: "Rate Out Of 5",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 7, 7, 7)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This Field Cannot Be Empty";
                                } else {
                                  setState(() {
                                    notes = value;
                                  });
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 22, 47, 230),
                                    ),
                                  ),
                                  labelText: "Behaviour",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: "Rate Out Of 5",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 12, 12, 12)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This Field Cannot Be Empty";
                                } else {
                                  setState(() {
                                    behaviour = value;
                                  });
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(80, 40)),
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    rateteacherbystud();
                                  }
                                },
                                child: Text("Submit"))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        drawer: studDrawer(),
      ),
    );
  }
}
