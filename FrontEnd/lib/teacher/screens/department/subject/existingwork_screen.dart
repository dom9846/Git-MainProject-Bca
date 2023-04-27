// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_interpolation_to_compose_strings, unused_local_variable, prefer_const_declarations, unnecessary_null_comparison

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mainproject/services/subject_service.dart';
import 'package:mainproject/teacher/assets/drawer.dart';

class ExistingSubjectWork_Screen extends StatefulWidget {
  const ExistingSubjectWork_Screen({super.key});

  @override
  State<ExistingSubjectWork_Screen> createState() =>
      _ExistingSubjectWork_ScreenState();
}

class _ExistingSubjectWork_ScreenState
    extends State<ExistingSubjectWork_Screen> {
  String? jwt, userId, subjectid1 = "", semester = "";
  List? subworks;
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    retrievesubwork();
  }

  // final storage = new FlutterSecureStorage();
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

  subjectservice subretrieveworkservice = new subjectservice();
  Future<void> retrievesubwork() async {
    var subwork = jsonEncode({
      "subjectid": subjectid1,
      "semester": semester,
      "teacherid": userId,
    });
    try {
      final Response? res =
          await subretrieveworkservice.retrievesubwork(subwork);
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

  showError(String content, String title, String id) {
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
                  // if (title == "Registration Successful") {
                  //   // Navigator.pushNamed(context, '/login');
                  // } else
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Yes"),
                onPressed: () {
                  deletework(id);
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
                    Navigator.pushNamed(context, '/teachdashboard');
                  }
                  // Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  subjectservice deletesubworkservice = new subjectservice();

  Future<void> deletework(String id) async {
    try {
      var sub = jsonEncode({"_id": id});
      print(sub);
      final Response? res = await deletesubworkservice.removesubjectwork(sub);
      if (res!.statusCode == 201) {
        showError2("Successfully deleted", "Click Ok");
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
    final dynamic sub =
        ModalRoute.of(context as BuildContext)?.settings.arguments;
    subjectid1 = sub['subjectid'].toString();
    semester = sub['semester'].toString();
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
                child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.clear_all),
                    label: Text("Clear all")))
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
                  'Assigned Works',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 228, 230, 233),
                  ),
                ),
                Column(
                  children: [
                    // Add other widgets here
                    SizedBox(
                      height: 500,
                      child: ListView.builder(
                        itemCount: subworks?.length,
                        itemBuilder: (context, index) {
                          final subwork = subworks?[index];
                          final dateTimeString1 = subwork?['duedate'];
                          String? id = subwork?['_id'];
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
                            elevation: 2,
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "worktype:" +
                                            (subwork?['worktype'] ?? "Nill"),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      dateString2 != null
                                          ? Text(
                                              "Posted On:" + dateString2,
                                              style: TextStyle(fontSize: 18),
                                            )
                                          : Text("Null"),
                                      SizedBox(height: 8),
                                      dateString1 != null
                                          ? Text(
                                              "duedate:" + dateString1,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 223, 7, 7)),
                                            )
                                          : Text("Null"),
                                      SizedBox(height: 16),
                                      Text(
                                        (subwork?['activity'] ?? "Nill"),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    "/teachdepsubmittedworks",
                                                    arguments: {
                                                      'workid': subwork?['_id']
                                                    });
                                              },
                                              child:
                                                  Text("List Of Submissions"))
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                showError(
                                                    "Do You Want To Delete This Work?",
                                                    "Are You Sure?",
                                                    id.toString());
                                              },
                                              child: Text("Delete",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 223, 7, 7))))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
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
