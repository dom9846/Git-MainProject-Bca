// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../assets/drawer.dart';

class stud_activities extends StatefulWidget {
  const stud_activities({super.key});

  @override
  State<stud_activities> createState() => _stud_activitiesState();
}

class _stud_activitiesState extends State<stud_activities> {
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
            child: Text("activities Page"),
          ),
        ),
        drawer: studDrawer(),
      ),
    );
  }
}
