// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, duplicate_ignore

import 'package:flutter/material.dart';

import '../assets/drawer.dart';

class teach_attendance extends StatefulWidget {
  const teach_attendance({super.key});

  @override
  State<teach_attendance> createState() => _teach_attendanceState();
}

class _teach_attendanceState extends State<teach_attendance> {
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
                      Navigator.pushNamed(context, "/teachmessage");
                    },
                    icon: Icon(Icons.message_sharp)))
          ],
        ),
        body: Container(
          child: Center(
            child: Text("Attendance Page"),
          ),
        ),
        drawer: teach_Drawer(),
      ),
    );
  }
}
