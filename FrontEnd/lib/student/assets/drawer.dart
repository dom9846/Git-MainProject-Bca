// ignore_for_file: camel_case_types, prefer_const_constructors, unnecessary_new

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:mainproject/services/getuser_service.dart';

class studDrawer extends StatefulWidget {
  const studDrawer({super.key});

  @override
  State<studDrawer> createState() => _studDrawerState();
}

class _studDrawerState extends State<studDrawer> {
  final storage = new FlutterSecureStorage();
  String? userId = "", firstname = "", secondname = "", usertype = "";
  String? propic = "",
      email = "",
      mobile = "",
      age = "",
      qualification = "",
      designation = "",
      semester;
  Uint8List? profilepic;
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
      firstname = allValues["fname"];
      secondname = allValues["sname"];
      usertype = allValues["utype"];
      if (usertype == "Student") {
        designation = "Student";
      }
    });
    getstudent();
  }

  getuserservice getstudentservice = new getuserservice();
  Future<void> getstudent() async {
    try {
      var user = jsonEncode({
        "id": userId,
      });
      final Response? res = await getstudentservice.getstudent(user);
      // print(res);
      if (res!.statusCode == 201) {
        setState(() {
          propic = res.data["propic"];
          email = res.data["email"];
          mobile = res.data["mobile"].toString();
          age = res.data["age"].toString();
          semester = res.data["semester"].toString();
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

  // final storage = new FlutterSecureStorage();
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
                      width: 10,
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
              onTap: () => {
                Navigator.pushNamed(context, "/studdepattndancestatus",
                    arguments: {
                      'semester': semester,
                    })
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 30),
              leading: Icon(Icons.person_4),
              title: Text('Internal'),
              onTap: () => {
                Navigator.pushNamed(context, "/studdepinternalstatus",
                    arguments: {
                      'semester': semester,
                    })
              },
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
          // contentPadding: EdgeInsets.only(left: 30),
          leading: Icon(Icons.person_4),
          title: Text('My rating'),
          onTap: () => {
            Navigator.pushNamed(context, "/studdepratingstatus", arguments: {
              'semester': semester,
            })
          },
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
