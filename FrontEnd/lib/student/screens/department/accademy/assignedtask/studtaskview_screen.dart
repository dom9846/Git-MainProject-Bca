// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_local_variable, prefer_interpolation_to_compose_strings, unnecessary_new
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mainproject/services/getuser_service.dart';
import 'package:mainproject/services/subject_service.dart';
import 'package:mainproject/student/assets/drawer.dart';

class TaskView_semesterwise extends StatefulWidget {
  const TaskView_semesterwise({super.key});

  @override
  State<TaskView_semesterwise> createState() => _TaskView_semesterwiseState();
}

class _TaskView_semesterwiseState extends State<TaskView_semesterwise> {
  final _formkey = GlobalKey<FormState>();
  String? jwt, userId;
  List? subworks;
  String? semester = "", studentfname = "", studentsname = "";
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    getstudent();
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
          semester = res.data["semester"].toString();
        });
      }
    } on DioError catch (err) {
      if (err.response != null) {}
    }
    retrievesubwork();
  }

  File? _selectedFile;
  String? _selectedFileBase64;
  subjectservice subretrieveworkservice = new subjectservice();
  Future<void> retrievesubwork() async {
    var subwork = jsonEncode({
      "semester": semester,
    });
    try {
      final Response? res =
          await subretrieveworkservice.retrievesubworksemways(subwork);
      if (res!.statusCode == 201) {
        setState(() {
          subworks = res.data;
        });
        print(subworks);
      }
    } on DioError catch (err) {
      if (err.response != null) {
        if (err.response!.statusCode == 401) {}
      }
    }
  }

  DateTime currentDateTime = DateTime.now();
  subjectservice submitworkservice = new subjectservice();
  Future<void> submitwork(
    String workid,
  ) async {
    if (_selectedFileBase64 == null || _selectedFileBase64!.isEmpty) {
      showError("Select Your Work", "Cannot Update");
    } else {
      var subwork = jsonEncode({
        "id": workid,
        "studentid": userId,
        "studentfname": studentfname,
        "studentsname": studentsname,
        "semester": semester,
        "workfile": _selectedFileBase64,
        "date": currentDateTime.toIso8601String()
      });
      print(subwork);
      try {
        final Response? res = await submitworkservice.submitsubwork(subwork);
        if (res!.statusCode == 201) {
          showError("Successfully Submitted!", "Committed");
        }
      } on DioError catch (err) {
        if (err.response != null) {
          if (err.response!.statusCode == 401) {
            showError("You Have Allready Submitted!", "Cannot Done");
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
    // final dynamic sub =
    //     ModalRoute.of(context as BuildContext)?.settings.arguments;
    // semester = sub['semester'].toString();
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
        body: ListView(children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Center(
                child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Task`s',
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
                  child: ListView.builder(
                    itemCount: subworks?.length,
                    itemBuilder: (context, index) {
                      String subworkid = "";
                      final subwork = subworks?[index];
                      // sub = subworks?[index]?['subjectid'];
                      // lec = subworks?[index]?['teacherid'];
                      // getteacher(lec);
                      // getsubdetails(sub);
                      if (subwork != null) {
                        subworkid = subwork?['_id'];
                      }
                      // print("object");
                      // print(subworkid);
                      final dateTimeString1 = subwork?['duedate'];
                      final dateTime1 = dateTimeString1 != null
                          ? DateTime.parse(dateTimeString1)
                          : null;
                      final dateString1 = dateTime1 != null
                          ? DateFormat("dd-MM-yyyy").format(dateTime1)
                          : null;
                      final dateTimeString2 = subwork?['date'];
                      final dateTime2 = dateTimeString2 != null
                          ? DateTime.parse(dateTimeString2)
                          : null;
                      final dateString2 = dateTime2 != null
                          ? DateFormat("dd-MM-yyyy").format(dateTime2)
                          : null;
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                        child: ExpansionTile(
                          title: Text(
                            (subwork?['worktype'] ?? "Nill"),
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: dateString2 != null
                              ? Text(
                                  "Posted On:" + dateString2,
                                  style: TextStyle(fontSize: 16),
                                )
                              : Text("Null"),
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    dateString1 != null
                                        ? Text(
                                            "duedate:" + dateString1,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 223, 7, 7)),
                                          )
                                        : Text("Null"),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      (subwork?['activity'] ?? "Nill"),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Subject Name" +
                                          (subwork?['subjectname'] ?? "Nill"),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Semester" +
                                          (subwork?['semester'] ?? "Nill"),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("Status"),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      width: 150,
                                      height: 150,
                                      child: Center(
                                          child: Text("Upload Your Work")),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Form(
                                        key: _formkey,
                                        child: Column(
                                          children: [
                                            TextButton(
                                                onPressed: () async {
                                                  final result =
                                                      await FilePicker.platform
                                                          .pickFiles(
                                                    type: FileType.custom,
                                                    allowedExtensions: ['pdf'],
                                                  );
                                                  if (result != null) {
                                                    setState(() {
                                                      _selectedFile = File(
                                                          result.files.single
                                                              .path!);
                                                    });
                                                    if (_selectedFile != null) {
                                                      final bytes =
                                                          await _selectedFile!
                                                              .readAsBytes();
                                                      final base64String =
                                                          base64Encode(bytes);

                                                      setState(() {
                                                        _selectedFileBase64 =
                                                            base64String;
                                                      });
                                                      print("hello");
                                                      print(
                                                          _selectedFileBase64);
                                                      print("hello1");
                                                    }
                                                  }
                                                },
                                                child: Text("Upload")),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    fixedSize: Size(80, 40)),
                                                onPressed: () {
                                                  submitwork(subworkid);
                                                },
                                                child: Text("Assign"))
                                          ],
                                        )),
                                  ],
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
          ),
        ]),
        drawer: studDrawer(),
      ),
    );
  }
}
