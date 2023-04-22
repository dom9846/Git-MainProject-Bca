// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mainproject/services/timeattendint_service.dart';
// import 'package:mainproject/services/timetable_service.dart';
import 'package:mainproject/teacher/assets/drawer.dart';

class TimeTable_Teach extends StatefulWidget {
  const TimeTable_Teach({super.key});

  @override
  State<TimeTable_Teach> createState() => _TimeTable_TeachState();
}

class _TimeTable_TeachState extends State<TimeTable_Teach> {
  final storage = new FlutterSecureStorage();
  String? jwt, userId;
  List? timetable;
  Uint8List? time1, time2, time3;
  String? timetable1, timetable2, timetable3;
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    gettimetable();
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

  timeattendintservice timetableretrieve = timeattendintservice();
  Future<void> gettimetable() async {
    try {
      final Response? res = await timetableretrieve.retrievetimetable("");
      if (res!.statusCode == 201) {
        setState(() {
          timetable = res.data;
        });
        timetable1 = timetable?[0]?['year1'];
        if (timetable1 != null) {
          final decodestring = base64Decode(timetable1!.split(',').last);
          time1 = decodestring;
        } else {
          time1 = Uint8List(0);
        }
        timetable2 = timetable?[0]?['year2'];
        if (timetable2 != null) {
          final decodestring = base64Decode(timetable2!.split(',').last);
          time2 = decodestring;
        } else {
          time2 = Uint8List(0);
        }
        timetable3 = timetable?[0]?['year3'];
        if (timetable3 != null) {
          final decodestring = base64Decode(timetable3!.split(',').last);
          time3 = decodestring;
        } else {
          time3 = Uint8List(0);
        }
      }
      // convert();
    } on DioError catch (err) {
      if (err.response != null) {
      } else {}
    }
  }

  // Future<void> convert() async {
  //   String? Timetable1 = timetable!['year1'];
  // }

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
                  'Time Table-1st Year',
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
                Container(
                  height: 250,
                  width: 300,
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
                  child: Image.memory(
                    time1 ?? Uint8List(0),
                    fit: BoxFit.cover,
                    width: 200,
                    height: 250,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Container(
                        color: Colors.grey,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 48.0,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Time Table-2nd Year',
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
                Container(
                  height: 250,
                  width: 300,
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
                  child: Image.memory(
                    time2 ?? Uint8List(0),
                    fit: BoxFit.cover,
                    width: 200,
                    height: 250,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Container(
                        color: Colors.grey,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 48.0,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Time Table-3rd Year',
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
                Container(
                  height: 250,
                  width: 300,
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
                  child: Image.memory(
                    time3 ?? Uint8List(0),
                    fit: BoxFit.cover,
                    width: 200,
                    height: 250,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Container(
                        color: Colors.grey,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 48.0,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
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
