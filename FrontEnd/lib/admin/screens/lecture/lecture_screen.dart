// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, camel_case_types, duplicate_ignore, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mainproject/services/deleteuser_service.dart';
import 'package:mainproject/services/getuser_service.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../assets/drawer.dart';

class lec_screen extends StatefulWidget {
  const lec_screen({super.key});

  @override
  State<lec_screen> createState() => _lec_screenState();
}

class _lec_screenState extends State<lec_screen> {
  String? userId = "", firstname = "", secondname = "", usertype = "";
  List? lectures;
  // int? lecid;
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
      firstname = allValues["fname"];
      secondname = allValues["sname"];
      usertype = allValues["utype"];
    });
    getlectures();
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

  getuserservice getlecservice = new getuserservice();
  Future<void> getlectures() async {
    try {
      // var user = jsonEncode({
      //   "user_type": "Teacher",
      // });
      final Response? res = await getlecservice.getlecturesall("");
      if (res!.statusCode == 201) {
        setState(() {
          lectures = res.data;
        });
        print(lectures);
      }
    } on DioError catch (err) {
      if (err.response != null) {}
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
                  deletelec(id);
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
                  }
                  // Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  deleteuserservice deletelecservice = new deleteuserservice();

  Future<void> deletelec(String id) async {
    try {
      var user = jsonEncode({"_id": id});
      print(user);
      final Response? res = await deletelecservice.deletelecture(user);
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
                    'List Of Lectures',
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
                      child: ListView.builder(
                        itemCount: lectures?.length,
                        itemBuilder: (BuildContext context, int index) {
                          final lecture = lectures?[index];
                          String? id = lecture?['_id'];
                          Uint8List encodedimage;
                          String? propic =
                              lecture?['lec_details']?[0]?['propic'];
                          if (propic != null) {
                            final decodestring =
                                base64Decode(propic.split(',').last);
                            encodedimage = decodestring;
                          } else {
                            encodedimage = Uint8List(0);
                          }
                          return Card(
                            elevation: 5,
                            margin: EdgeInsets.all(10),
                            child: ExpansionTile(
                              leading: CircleAvatar(
                                child: ClipOval(
                                  child: Image.memory(
                                    encodedimage,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Container(
                                        color: Color.fromARGB(255, 61, 29, 29),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 48.0,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                radius: 30,
                              ),
                              title: lecture == null
                                  ? Text(
                                      "Nill",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Text(
                                      lecture['firstname'] +
                                          " " +
                                          lecture['secondname'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              subtitle: Text(
                                "Qualification:" +
                                    (lecture?["lec_details"]?[0]
                                            ?["qualification"] ??
                                        "Nill"),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // ignore: prefer_const_literals_to_create_immutables
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Age:" +
                                              (lecture?["lec_details"]?[0]
                                                      ?["age"] ??
                                                  "Nill"),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Email:" +
                                              (lecture?["lec_details"]?[0]
                                                      ?["email"] ??
                                                  "Nill"),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Contact:" +
                                              (lecture?["lec_details"]?[0]
                                                      ?["mobile"] ??
                                                  "Nill"),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              showError(
                                                  "Do You Want To Delete This Lecture?",
                                                  "Are You Sure?",
                                                  id.toString());
                                            },
                                            child: Text(
                                              "Delete",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ))
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
