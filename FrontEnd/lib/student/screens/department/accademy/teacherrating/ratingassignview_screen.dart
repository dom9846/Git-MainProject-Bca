// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mainproject/services/getuser_service.dart';
import 'package:mainproject/services/rating_service.dart';
import 'package:mainproject/student/assets/drawer.dart';

class AssignedRate_Task extends StatefulWidget {
  const AssignedRate_Task({super.key});

  @override
  State<AssignedRate_Task> createState() => _AssignedRate_TaskState();
}

class _AssignedRate_TaskState extends State<AssignedRate_Task> {
  // final _formkey = GlobalKey<FormState>();
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
          // studentfname = res.data["fname"].toString();
          // studentsname = res.data["sname"].toString();
          year = res.data["year"].toString();
        });
      }
    } on DioError catch (err) {
      if (err.response != null) {}
    }
    retrieveassignedrating();
  }

  ratingService ratetaskservice = new ratingService();
  Future<void> retrieveassignedrating() async {
    var yearofstud = jsonEncode({
      "year": year,
    });
    try {
      final Response? res =
          await ratetaskservice.retrieveratetaskbyyear(yearofstud);
      if (res!.statusCode == 201) {
        setState(() {
          ratetasks = res.data;
        });
        print(ratetasks);
      }
    } on DioError catch (err) {
      if (err.response != null) {
        if (err.response!.statusCode == 401) {}
      }
    }
  }

  void initState() {
    super.initState();
    this.getToken();
  }

  @override
  Widget build(BuildContext context) {
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
                  'Assigned Rate Task',
                  // ignore: prefer_const_constructors
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
                    itemCount: ratetasks?.length,
                    itemBuilder: (context, index) {
                      final ratingtask = ratetasks?[index];
                      final dateTimeString1 = ratingtask?['duedate'];
                      final dateTime1 = dateTimeString1 != null
                          ? DateTime.parse(dateTimeString1)
                          : null;
                      final dateString1 = dateTime1 != null
                          ? DateFormat("dd-MM-yyyy").format(dateTime1)
                          : null;
                      final dateTimeString2 = ratingtask?['date'];
                      final dateTime2 = dateTimeString2 != null
                          ? DateTime.parse(dateTimeString2)
                          : null;
                      final dateString2 = dateTime2 != null
                          ? DateFormat("dd-MM-yyyy").format(dateTime2)
                          : null;
                      return Card(
                        child: InkWell(
                          onTap: () => {
                            Navigator.pushNamed(
                                context, "/studdepaccdemyrateform",
                                arguments: {'taskid': ratingtask?['_id']})
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Title(
                                  color: Colors.black,
                                  child: Text(
                                    "Assigned By:" +
                                        (ratingtask?['teachfname'] ?? "Nill") +
                                        " " +
                                        (ratingtask?['teachsname'] ?? "Nill"),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("Year:" + (ratingtask?['year'] ?? "Nill")),
                                SizedBox(height: 10),
                                dateString2 != null
                                    ? Text(
                                        "Posted On:" + dateString2,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 23, 22, 22)),
                                      )
                                    : Text("Null"),
                                SizedBox(height: 10),
                                dateString1 != null
                                    ? Text(
                                        "duedate:" + dateString1,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Color.fromARGB(255, 223, 7, 7)),
                                      )
                                    : Text("Null"),
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
        drawer: studDrawer(),
      ),
    );
  }
}
