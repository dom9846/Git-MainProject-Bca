// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore, unused_local_variable

// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mainproject/admin/assets/drawer.dart';
// import 'package:file_picker/file_picker.dart';

class Timetable_Screen extends StatefulWidget {
  const Timetable_Screen({super.key});

  @override
  State<Timetable_Screen> createState() => _Syllabus_ScreenState();
}

// File? file;

class _Syllabus_ScreenState extends State<Timetable_Screen> {
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
                  height: 150,
                  width: 200,
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
                  child: Center(child: Text("Time Table File")),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Upload a New Time Table",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 30,
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
                  height: 150,
                  width: 200,
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
                  child: Center(child: Text("Time Table File")),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Upload a New Time Table",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 30,
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
                  height: 150,
                  width: 200,
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
                  child: Center(child: Text("Time Table File")),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Upload a New Time Table",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 30,
                ),
                // ElevatedButton(
                //     onPressed: () async {
                //       FilePickerResult? result =
                //           await FilePicker.platform.pickFiles();
                //       if (result != null) {
                //         File file = File(result.files.single.path);
                //       } else {
                //         // User canceled the picker
                //       }
                //     },
                //     child: Text("Select The Document"))
              ],
            )),
          ),
        ]),
        drawer: cldrawer(),
      ),
    );
  }
}
