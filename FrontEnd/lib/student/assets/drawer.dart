// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class studDrawer extends StatefulWidget {
  const studDrawer({super.key});

  @override
  State<studDrawer> createState() => _studDrawerState();
}

class _studDrawerState extends State<studDrawer> {
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
                          image: AssetImage('images/propic3.jpg'))),
                ),
                Text(
                  "Student Name",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Department",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.dashboard_customize_outlined),
          title: Text("Dashboard"),
          onTap: () => {Navigator.pushNamed(context, "/studdashboard")},
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
              onTap: () => {Navigator.pushNamed(context, "/studdepattndance")},
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 30),
              leading: Icon(Icons.person_4),
              title: Text('Internal'),
              onTap: () => {Navigator.pushNamed(context, "/studdepinternal")},
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 30),
              leading: Icon(Icons.person_4),
              title: Text('Accademy'),
              onTap: () => {Navigator.pushNamed(context, "/studdepaccdemy")},
            ),
          ],
        ),
        ListTile(
          leading: Icon(Icons.timer_10_rounded),
          title: Text("Time Table"),
          onTap: () => {Navigator.pushNamed(context, "/studtimetablescreen")},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
          onTap: () => {Navigator.pushNamed(context, "/studsettings")},
        ),
        ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Log Out"),
            onTap: logout)
      ],
    ));
  }
}
