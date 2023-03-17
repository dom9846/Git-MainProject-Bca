// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';

class teach_Drawer extends StatefulWidget {
  const teach_Drawer({super.key});

  @override
  State<teach_Drawer> createState() => _teach_DrawerState();
}

class _teach_DrawerState extends State<teach_Drawer> {
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
                          image: AssetImage('images/propic2.jpg'))),
                ),
                Text(
                  "Lecture name",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Lecture Designation",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.dashboard_customize_outlined),
          title: Text("Dashboard"),
          onTap: () => {Navigator.pushNamed(context, "/teachdashboard")},
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
              onTap: () => {Navigator.pushNamed(context, "/teachdepattdnce")},
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
              title: Text('First Year'),
              onTap: () => {Navigator.pushNamed(context, "/admnstud")},
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 30),
              leading: Icon(Icons.person_4),
              title: Text('Second Year'),
              onTap: () => {Navigator.pushNamed(context, "/admnstud")},
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 30),
              leading: Icon(Icons.person_4),
              title: Text('Third Year'),
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
          leading: Icon(Icons.exit_to_app),
          title: Text("Log Out"),
          onTap: () => {Navigator.pushNamed(context, "/login")},
        )
      ],
    ));
  }
}