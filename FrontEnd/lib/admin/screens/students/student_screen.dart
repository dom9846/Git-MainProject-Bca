// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, camel_case_types, unused_import, implementation_imports, unnecessary_new, unnecessary_this, annotate_overrides

import 'dart:convert';

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
    getlectures();
  }

  getuserservice getlecservice = new getuserservice();
  Future<void> getlectures() async {
    try {
      var user = jsonEncode({
        "year": year,
      });
      print(user);
      final Response? res = await getlecservice.getstudentssall(user);
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
                final stud_det = students?[index]['lec_details'];
                // String? roll = stud_det[0]['age'];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://picsum.photos/200'),
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
                      'Roll No',
                      style: TextStyle(fontSize: 16),
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
                              Text("Semester"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("age"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("email"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Mobile"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Parent Name"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Parent Contact"),
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
