// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, camel_case_types, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mainproject/services/getuser_service.dart';

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
        body: Container(
          child: ListView.builder(
            itemCount: lectures?.length,
            itemBuilder: (BuildContext context, int index) {
              final lecture = lectures?[index];
              final lecturer = lectures?[index]['lec_details'];
              String? age = lecturer[0]['age'];
              // String email = lecturer[1]['email'];
              // String mobile = lecturer[2]['mobile'];
              // // String propic = lecturer[0]['propic'];
              // String? qualification = lecturer[4]['qualification'];
              // print(lecturer['age']);
              return Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://picsum.photos/200'),
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
                          lecture['firstname'] + " " + lecture['secondname'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  subtitle: Text(
                    'Rating',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/admnchatbox");
                      },
                      icon: Icon(Icons.message)),
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            lecture == null
                                ? Text(
                                    "Nill",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    "Age:" + " " + age!,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            SizedBox(
                              height: 8,
                            ),
                            // lecture == null
                            //     ? Text(
                            //         "Nill",
                            //         style: TextStyle(
                            //           fontSize: 20,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       )
                            //     : Text(
                            //         qualification!,
                            //         style: TextStyle(
                            //           fontSize: 20,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       ),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            // lecture == null
                            //     ? Text(
                            //         "Nill",
                            //         style: TextStyle(
                            //           fontSize: 20,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       )
                            //     : Text(
                            //         email,
                            //         style: TextStyle(
                            //           fontSize: 20,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       ),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            // lecture == null
                            //     ? Text(
                            //         "Nill",
                            //         style: TextStyle(
                            //           fontSize: 20,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       )
                            //     : Text(
                            //         mobile,
                            //         style: TextStyle(
                            //           fontSize: 20,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       ),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ))
                          ],
                        )),
                  ],
                ),
              );
            },
          ),
        ),
        drawer: cldrawer(),
      ),
    );
  }
}
