// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';

class studDrawer extends StatefulWidget {
  const studDrawer({super.key});

  @override
  State<studDrawer> createState() => _studDrawerState();
}

class _studDrawerState extends State<studDrawer> {
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
        ListTile(
          leading: Icon(Icons.book),
          title: Text("Department"),
          onTap: () => {Navigator.pushNamed(context, "/studdepartment")},
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Rate Lectures"),
          onTap: () => {Navigator.pushNamed(context, "/studrate")},
        ),
        ListTile(
          leading: Icon(Icons.person_4_outlined),
          title: Text("Activities"),
          onTap: () => {Navigator.pushNamed(context, "/studactivities")},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
          onTap: () => {Navigator.pushNamed(context, "/studsett")},
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text("Log Out"),
          onTap: () => {Navigator.pushNamed(context, "/login")},
        )
      ],
    ));
  }
}
