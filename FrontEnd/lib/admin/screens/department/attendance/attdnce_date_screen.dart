// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mainproject/services/timeattendint_service.dart';

import '../../../assets/drawer.dart';

class Attdnce_date extends StatefulWidget {
  const Attdnce_date({super.key});

  @override
  State<Attdnce_date> createState() => _Attdnce_dateState();
}

class _Attdnce_dateState extends State<Attdnce_date> {
  String? userId = "", firstname = "", secondname = "", usertype = "";
  List? attendances;
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
    getattendances();
  }

  // final storage = new FlutterSecureStorage();
  bool isLoggedin = true;
  Future<void> checkAuthentication() async {
    try {
      Map<String, String> allValues = await storage.readAll();
      if (allValues["token"] == "") {
        Navigator.pushNamed(context, "/login");
      } else {
        // this.getToken();
      }
    } catch (e) {}
  }

  timeattendintservice attendanceservice = new timeattendintservice();
  Future<void> getattendances() async {
    var sem = jsonEncode({"semester": semester});
    print(sem);
    try {
      final Response? res = await attendanceservice.getallattendances(sem);
      if (res!.statusCode == 201) {
        setState(() {
          attendances = res.data;
        });
      }
    } on DioError catch (err) {
      if (err.response != null) {
        if (err.response!.statusCode == 401) {}
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
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Yes"),
                onPressed: () {
                  deleteattendance();
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
                    Navigator.pushNamed(context, '/admndepattendance');
                  }
                  // Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> deleteattendance() async {
    try {
      var sem = jsonEncode({"semester": semester});
      // print(post);
      final Response? res = await attendanceservice.deleteattendance(sem);
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
    final dynamic id =
        ModalRoute.of(context as BuildContext)?.settings.arguments;
    semester = id['sem'].toString();
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
                    onPressed: () {
                      showError("Do You Want To Delete All?", "Are You Sure?");
                    },
                    icon: Icon(Icons.clear_all),
                    label: Text("Clear all")))
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
                  'Attendance',
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
                    itemCount: attendances?.length,
                    itemBuilder: (context, index) {
                      final attendance = attendances?[index];
                      final dateTimeString1 = attendance?['date'];
                      final dateTime1 = dateTimeString1 != null
                          ? DateTime.parse(dateTimeString1)
                          : null;
                      final dateString1 = dateTime1 != null
                          ? DateFormat("dd-MM-yyyy").format(dateTime1)
                          : null;
                      final innerList = attendance?['absentstudentlist'] ?? [];
                      return Card(
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Title(
                                  color: Colors.black,
                                  child: dateString1 != null
                                      ? Text(
                                          "Date" + dateString1,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 23, 22, 22)),
                                        )
                                      : Text("Null"),
                                ),
                                SizedBox(height: 10),
                                Text("Period:" +
                                    (attendance?['period'] ?? "Nill")),
                                SizedBox(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: innerList?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          final innerObject =
                                              innerList?[index] ?? {};
                                          final firstName =
                                              innerObject['firstname'] ??
                                                  "Nill";
                                          final secondName =
                                              innerObject['secondname'] ??
                                                  "Nill";
                                          return Text("$firstName $secondName");
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
          ),
        ]),
        drawer: cldrawer(),
      ),
    );
  }
}
