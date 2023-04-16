// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mainproject/services/getuser_service.dart';
import 'package:mainproject/services/timeattendint_service.dart';
import 'package:mainproject/teacher/assets/drawer.dart';

class Teach_InternalStudent extends StatefulWidget {
  const Teach_InternalStudent({super.key});

  @override
  State<Teach_InternalStudent> createState() => _Teach_InternalStudentState();
}

final _formkey = GlobalKey<FormState>();
String mark = "";

class _Teach_InternalStudentState extends State<Teach_InternalStudent> {
  String? jwt, userId, subjectid1 = "", semester = "", year = "";
  List? students;
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    getstudents();
  }

  getuserservice getstudservice = new getuserservice();
  Future<void> getstudents() async {
    print(semester);
    if (semester == '1' || semester == '2') {
      print("hello");
      setState(() {
        year = '1';
      });
    } else if (semester == '3' || semester == '4') {
      setState(() {
        year = '2';
      });
    } else if (semester == '5' || semester == '6') {
      setState(() {
        year = '3';
      });
    } else {}
    // print(year);
    try {
      var user = jsonEncode({
        "year": year,
      });
      final Response? res = await getstudservice.getstudentssall(user);
      if (res!.statusCode == 201) {
        setState(() {
          students = res.data;
        });
        print(students);
      }
    } on DioError catch (err) {
      if (err.response != null) {}
    }
  }

  timeattendintservice internalservice = new timeattendintservice();
  Future<void> submit() async {
    if (_formkey.currentState!.validate()) {
      // var attendance = jsonEncode({
      //   "semester": semester,
      //   "date": _selectedDate!.toIso8601String(),
      //   "period": period,
      //   "absentstudentlist": selectedOptions
      // });
      // print(attendance);
      try {
        // final Response? res = await internalservice.putattendance(attendance);
        // if (res!.statusCode == 401) {}
        showError("Successfully Recorded", "Attendance");
      } on DioError catch (err) {
        if (err.response != null) {
          if (err.response!.statusCode == 401) {
            showError("Attendance Allready Marked", "Period Was Finished");
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
    final dynamic sub =
        ModalRoute.of(context as BuildContext)?.settings.arguments;
    subjectid1 = sub['subjectid'].toString();
    semester = sub['semester'].toString();
    print(semester);
    print(subjectid1);
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
                      Navigator.pushNamed(context, "/teachaddnewpost");
                    },
                    // ignore: prefer_const_constructors
                    icon: Icon(Icons.add_card_sharp))),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/teachmessage");
                    },
                    icon: Icon(Icons.message_sharp)))
          ],
        ),
        body: ListView(children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Center(
                child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Internal For Students',
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
                Column(
                  children: [
                    // Add other widgets here
                    SizedBox(
                      height: 800,
                      child: ListView.builder(
                        itemCount: students?.length,
                        itemBuilder: (context, index) {
                          final student = students?[index];
                          String? studentid = student?['_id'].toString();
                          // final studDetails =
                          //     student?['stud_details']?[0];
                          return Card(
                            elevation: 5,
                            margin: EdgeInsets.all(10),
                            child: ExpansionTile(
                              // leading: CircleAvatar(
                              //   backgroundImage:
                              //       NetworkImage('https://picsum.photos/200'),
                              //   radius: 30,
                              // ),
                              title: Text(
                                (students?[index]?['firstname'] ?? "Nill") +
                                    " " +
                                    (students?[index]?['secondname'] ?? "Nill"),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text("Roll No:" +
                                  (students?[index]?['stud_details']?[0]
                                          ?['rollno'] ??
                                      "Nill")),
                              // ignore: prefer_const_literals_to_create_immutables
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Form(
                                            key: _formkey,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  keyboardType:
                                                      TextInputType.name,
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255, 22, 47, 230),
                                                        ),
                                                      ),
                                                      labelText:
                                                          "Internal Mark",
                                                      labelStyle: TextStyle(
                                                          color: Colors.black),
                                                      hintText:
                                                          "You Cannot Edit This Later",
                                                      hintStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 12, 12, 12)),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      )),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "This Field Cannot Be Empty";
                                                    } else {
                                                      setState(() {
                                                        mark = value;
                                                      });
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                ),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            fixedSize:
                                                                Size(80, 40)),
                                                    onPressed: () {
                                                      submit();
                                                    },
                                                    child: Text("Submit"))
                                              ],
                                            ))
                                      ],
                                    )),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ),
        ]),
        drawer: teach_Drawer(),
      ),
    );
  }
}
