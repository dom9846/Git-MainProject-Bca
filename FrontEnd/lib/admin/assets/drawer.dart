// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class cldrawer extends StatefulWidget {
  const cldrawer({super.key});

  @override
  State<cldrawer> createState() => _cldrawerState();
}

class _cldrawerState extends State<cldrawer> {
  final storage = new FlutterSecureStorage();
  logout() async {
    await storage.delete(key: "token");
    Navigator.pushNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        Container(
          width: double.infinity,
          height: 300,
          padding: EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 81, 169, 251),
              // border: Border.all(),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
              )),
          child: DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('images/propic1.jpg'))),
                ),
                Text(
                  "Admin name",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Head Of the Department",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.dashboard_customize_outlined),
          title: Text("Dashboard"),
          onTap: () => {Navigator.pushNamed(context, "/admndashboard")},
        ),
        ExpansionTile(
          leading: Icon(Icons.person_4_outlined),
          title: Text('Department'),
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(left: 30),
              leading: Icon(Icons.person_4),
              title: Text('Attendance'),
              onTap: () => {Navigator.pushNamed(context, "/admndepattendance")},
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 30),
              leading: Icon(Icons.person_4),
              title: Text('Subjects'),
              onTap: () => {Navigator.pushNamed(context, "/admndepsubject")},
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 30),
              leading: Icon(Icons.person_4),
              title: Text('Accademy'),
              onTap: () => {Navigator.pushNamed(context, "/admndepaccademics")},
            ),
          ],
        ),
        ExpansionTile(
          leading: Icon(Icons.person_4_outlined),
          title: Text('Lectures'),
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(left: 30),
              leading: Icon(Icons.person_4),
              title: Text('Lecture Details'),
              onTap: () => {Navigator.pushNamed(context, "/admnlec")},
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 30),
              leading: Icon(Icons.person_4),
              title: Text('Add Lecture'),
              onTap: () => {Navigator.pushNamed(context, "/admnlectureadd")},
            ),
          ],
        ),
        ExpansionTile(
          leading: Icon(Icons.person_4_outlined),
          title: Text('Students'),
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(left: 30),
              leading: Icon(Icons.person_4),
              title: Text('Student List'),
              onTap: () => {Navigator.pushNamed(context, "/admnstud")},
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 30),
              leading: Icon(Icons.person_4),
              title: Text('Add Student'),
              onTap: () => {Navigator.pushNamed(context, "/admnstudentadd")},
            ),
          ],
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
          onTap: () => {Navigator.pushNamed(context, "/admnsett")},
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app), title: Text("Log Out"),
          onTap: logout,
          // onTap: () => {Navigator.pushNamed(context, "/login")},
        )
      ],
    ));
  }
}
