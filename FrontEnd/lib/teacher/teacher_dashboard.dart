// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:mainproject/teacher/assets/drawer.dart';

class teach_Home extends StatefulWidget {
  const teach_Home({super.key});

  @override
  State<teach_Home> createState() => _teach_HomeState();
}

class _teach_HomeState extends State<teach_Home> {
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
            child: Text("Teacher Dashboard"),
          ),
        ),
        drawer: teach_Drawer(),
      ),
    );
  }
}
