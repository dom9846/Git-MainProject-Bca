// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mainproject/services/rating_service.dart';
import 'package:mainproject/teacher/assets/drawer.dart';

class ViewassignedRate_screen extends StatefulWidget {
  const ViewassignedRate_screen({super.key});

  @override
  State<ViewassignedRate_screen> createState() =>
      _ViewassignedRate_screenState();
}

class _ViewassignedRate_screenState extends State<ViewassignedRate_screen> {
  String? jwt, userId;
  List? ratingtasks;
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    getassignedtask();
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

  ratingService assignedtask = new ratingService();
  Future<void> getassignedtask() async {
    var user = jsonEncode({'teacherid': userId});
    print(user);
    try {
      final Response? res = await assignedtask.retrieveassignedtasks(user);
      print(res);
      if (res!.statusCode == 201) {
        setState(() {
          ratingtasks = res.data;
        });
        print(ratingtasks);
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
                  deleteratetask(id);
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

  ratingService deleteratetaskservice = new ratingService();

  Future<void> deleteratetask(String id) async {
    try {
      var rate = jsonEncode({"_id": id});
      print(rate);
      final Response? res = await deleteratetaskservice.deleterate(rate);
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
                  'Assigned Rate tasks',
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
                    itemCount: ratingtasks?.length,
                    itemBuilder: (context, index) {
                      final ratingtask = ratingtasks?[index];
                      final dateTimeString1 = ratingtask?['duedate'];
                      String? id = ratingtask?['_id'];
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
                            Navigator.pushNamed(context, "/viewratestatus",
                                arguments: {'workid': ratingtask?['_id']})
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Title(
                                  color: Colors.black,
                                  child: dateString2 != null
                                      ? Text(
                                          "Posted On:" + dateString2,
                                          style: TextStyle(fontSize: 18),
                                        )
                                      : Text("Null"),
                                ),
                                SizedBox(height: 10),
                                Text("Year:" + (ratingtask?['year'] ?? "Nill")),
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
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                        ),
                      );
                    },
                  ),
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
