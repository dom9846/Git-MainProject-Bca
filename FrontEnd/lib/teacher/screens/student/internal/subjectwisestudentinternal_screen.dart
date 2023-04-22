// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mainproject/services/subject_service.dart';
import 'package:mainproject/teacher/assets/drawer.dart';

class SubjectWise_StudentInternal extends StatefulWidget {
  const SubjectWise_StudentInternal({super.key});

  @override
  State<SubjectWise_StudentInternal> createState() =>
      _SubjectWise_StudentState();
}

class _SubjectWise_StudentState extends State<SubjectWise_StudentInternal> {
  String? jwt, userId;
  List? subdetails;
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    getsubjectsassigned();
  }

  Future<void> checkAuthentication() async {
    try {
      Map<String, String> allValues = await storage.readAll();
      if (allValues["token"] == "") {
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        Navigator.pushNamed(context, "/login");
      } else {
        this.getToken();
      }
    } catch (e) {}
  }

  subjectservice subjectretrieve = new subjectservice();
  Future<void> getsubjectsassigned() async {
    var subject = jsonEncode({'subteacher': userId});
    print(subject);
    try {
      final Response? res =
          await subjectretrieve.retrieveassignedsubjects(subject);
      if (res!.statusCode == 201) {
        setState(() {
          subdetails = res.data;
        });
        print(subdetails);
      }
    } on DioError catch (err) {
      if (err.response != null) {
        if (err.response!.statusCode == 401) {}
      }
    }
  }

  void initState() {
    super.initState();
    this.getToken();
  }

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
                      Navigator.pushNamed(context, "/teachaddnewpost");
                    },
                    // ignore: prefer_const_constructors
                    icon: Icon(Icons.add_card_sharp))),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/teachmessage");
                    },
                    icon: Icon(Icons.message_sharp)))
          ],
        ),
        body: ListView(children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Center(
                child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Select Subjects',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 228, 230, 233),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                    itemCount: subdetails?.length,
                    itemBuilder: (context, index) {
                      final subdetail = subdetails?[index];
                      return Card(
                        child: InkWell(
                          onTap: () => {
                            Navigator.pushNamed(context, "/teachstudsinternal",
                                arguments: {
                                  'subjectid': subdetail?['_id'],
                                  'subjectname': subdetail?['subjectname'],
                                  'semester': subdetail?['semester'],
                                })
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Title(
                                    color: Colors.black,
                                    child: Text(
                                      (subdetail?['subjectname'] ?? "Nill"),
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )),
                                SizedBox(height: 10),
                                Text("Semester:" +
                                    (subdetail?['semester'] ?? "Nill"))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
          ),
        ]),
        drawer: teach_Drawer(),
      ),
    );
  }
}
