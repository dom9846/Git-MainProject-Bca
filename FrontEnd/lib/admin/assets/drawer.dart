// ignore_for_file: camel_case_types, prefer_const_constructors, unnecessary_this, annotate_overrides

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:mainproject/services/getuser_service.dart';

class cldrawer extends StatefulWidget {
  const cldrawer({super.key});

  @override
  State<cldrawer> createState() => _cldrawerState();
}

class _cldrawerState extends State<cldrawer> {
  final storage = new FlutterSecureStorage();
  String? userId = "", firstname = "", secondname = "", usertype = "";
  String? propic = "",
      email = "",
      mobile = "",
      age = "",
      qualification = "",
      designation = "";
  Uint8List? profilepic;
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
      firstname = allValues["fname"];
      secondname = allValues["sname"];
      usertype = allValues["utype"];
      if (usertype == "Admin") {
        designation = "Head Of Department";
      }
    });
    getadmin();
  }

  getuserservice getadminservice = new getuserservice();
  Future<void> getadmin() async {
    try {
      var user = jsonEncode({
        "id": userId,
      });
      final Response? res = await getadminservice.getadmin(user);
      if (res!.statusCode == 201) {
        setState(() {
          propic = res.data["propic"];
          email = res.data["email"];
          mobile = res.data["mobile"].toString();
          age = res.data["age"].toString();
          qualification = res.data["qualification"];
        });
        if (propic != null) {
          final decodestring = base64Decode(propic!.split(',').last);
          profilepic = decodestring;
        } else {
          profilepic = Uint8List(0);
        }
      }
    } on DioError catch (err) {
      if (err.response != null) {}
    }
  }

  void initState() {
    super.initState();
    this.getToken();
  }

  logout() async {
    await storage.delete(key: "token");
    Navigator.of(context)
        .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
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
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: Image.memory(
                        profilepic ?? Uint8List(0),
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
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
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      firstname!,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      secondname!,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                designation == null
                    ? Text("Nill",
                        style: TextStyle(color: Colors.white, fontSize: 15))
                    : Text(
                        designation!,
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
              onTap: () => {Navigator.pushNamed(context, "/admnstudyear")},
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
