// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, camel_case_types, unused_import, implementation_imports, unnecessary_new, unnecessary_this, annotate_overrides, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mainproject/services/getuser_service.dart';

import '../../assets/drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Stud_screen extends StatefulWidget {
  const Stud_screen(String? year1, {super.key});

  @override
  State<Stud_screen> createState() => _Stud_screenState();
}

class _Stud_screenState extends State<Stud_screen> {
  String? userId = "", firstname = "", secondname = "", usertype = "";
  List? students;
  // int? lecid;
  final storage = new FlutterSecureStorage();

  String? year;
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
      firstname = allValues["fname"];
      secondname = allValues["sname"];
      usertype = allValues["utype"];
    });
    getstudents();
  }

  // final storage = new FlutterSecureStorage();
  bool isLoggedin = true;
  Future<void> checkAuthentication() async {
    try {
      Map<String, String> allValues = await storage.readAll();
      if (allValues["token"] == "") {
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        Navigator.pushNamed(context, "/login");
      } else {
        // this.getToken();
      }
    } catch (e) {}
  }

  getuserservice getstudservice = new getuserservice();
  Future<void> getstudents() async {
    try {
      var user = jsonEncode({
        "year": year,
      });
      print(user);
      final Response? res = await getstudservice.getstudentssall(user);
      if (res!.statusCode == 201) {
        setState(() {
          students = res.data;
        });
        print(students);
      }
    } on DioError catch (err) {
      if (err.response != null) {}
    }
  }

  void initState() {
    super.initState();
    this.getToken();
  }

  @override
  Widget build(BuildContext context) {
    final Object? yearofstudent =
        ModalRoute.of(context as BuildContext)?.settings.arguments;
    year = yearofstudent.toString();
    // print(year);
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
                      Navigator.pushNamed(context, "/admnaddpost");
                    },
                    // ignore: prefer_const_constructors
                    icon: Icon(Icons.add_card_sharp))),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/admnmessage");
                    },
                    icon: Icon(Icons.message_sharp)))
          ],
        ),
        body: Container(
          child: ListView.builder(
              itemCount: students?.length,
              itemBuilder: (BuildContext context, int index) {
                final student = students?[index];
                Uint8List encodedimage;
                String? propic = student?['stud_details']?[0]?['propic'];
                if (propic != null) {
                  final decodestring = base64Decode(propic.split(',').last);
                  encodedimage = decodestring;
                } else {
                  encodedimage = Uint8List(0);
                }
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      child: ClipOval(
                        child: Image.memory(
                          encodedimage,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
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
                      radius: 30,
                    ),
                    title: student == null
                        ? Text(
                            "Nill",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            student['firstname'] + " " + student['secondname'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    subtitle: Text(
                      "Roll No:" +
                          (student?["stud_details"]?[0]?["rollno"] ?? "Nill"),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/admnchatbox");
                        },
                        icon: Icon(Icons.message)),
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "Age:" +
                                    (student?["stud_details"]?[0]?["age"]
                                            ?.toString() ??
                                        "Nill"),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Email:" +
                                    (student?["stud_details"]?[0]?["email"] ??
                                        "Nill"),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Mobile:" +
                                    (student?["stud_details"]?[0]?["mobile"]
                                            ?.toString() ??
                                        "Nill"),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Parent Name:" +
                                    (student?["stud_details"]?[0]?["parent"] ??
                                        "Nill"),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Parent Contact:" +
                                    (student?["stud_details"]?[0]
                                                ?["parentcontact"]
                                            ?.toString() ??
                                        "Nill"),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Year" +
                                    (student?["stud_details"]?[0]?["year"]
                                            ?.toString() ??
                                        "Nill"),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Semester" +
                                    (student?["stud_details"]?[0]?["semester"]
                                            ?.toString() ??
                                        "Nill"),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Attendance Percentage"),
                              SizedBox(
                                height: 8,
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ))
                            ],
                          )),
                    ],
                  ),
                );
              }),
        ),
        drawer: cldrawer(),
      ),
    );
  }
}
