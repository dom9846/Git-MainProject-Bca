// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:mainproject/student/assets/drawer.dart';

class student_Dashboard extends StatefulWidget {
  const student_Dashboard({super.key});

  @override
  State<student_Dashboard> createState() => _student_DashboardState();
}

class _student_DashboardState extends State<student_Dashboard> {
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
                      Navigator.pushNamed(context, "/studmessage");
                    },
                    icon: Icon(Icons.message_sharp)))
          ],
        ),
        body: Container(
          child: Center(
            child: Text("Student Dashboard"),
          ),
        ),
        drawer: studDrawer(),
      ),
    );
  }
}
