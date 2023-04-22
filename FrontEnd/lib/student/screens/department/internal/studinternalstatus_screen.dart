// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mainproject/student/assets/drawer.dart';

import '../../../../services/timeattendint_service.dart';

class StudentInternal_status extends StatefulWidget {
  const StudentInternal_status({super.key});

  @override
  State<StudentInternal_status> createState() => _StudentInternal_statusState();
}

class _StudentInternal_statusState extends State<StudentInternal_status> {
  // final _formkey = GlobalKey<FormState>();
  String? jwt, userId;
  List? internals;
  String? semester = "", studentfname = "", studentsname = "";
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    getinternals();
  }

  bool isLoggedin = true;
  // final storage = new FlutterSecureStorage();
  Future<void> checkAuthentication() async {
    try {
      Map<String, String> allValues = await storage.readAll();
      if (allValues.isEmpty) {
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        Navigator.pushNamed(context, "/login");
      } else {
        // this.getToken();
        // getposts();
      }
    } catch (e) {}
  }

  timeattendintservice internalservice = new timeattendintservice();
  Future<void> getinternals() async {
    var internalmark = jsonEncode({
      "semester": semester,
      "studentid": userId,
    });
    // print(internalmark);
    try {
      final Response? res = await internalservice.getinternal(internalmark);
      if (res!.statusCode == 201) {
        setState(() {
          internals = res.data;
        });
        print(internals);
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
    final dynamic sub =
        ModalRoute.of(context as BuildContext)?.settings.arguments;
    semester = sub['semester'].toString();
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
                      Navigator.pushNamed(context, "/studaddnewpost");
                    },
                    // ignore: prefer_const_constructors
                    icon: Icon(Icons.add_card_sharp))),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/studmessage");
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
                  'Internal For Subjects',
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
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    height: 500,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('SL No')),
                          DataColumn(label: Text('Subject Name')),
                          DataColumn(label: Text('Name Of Lecture')),
                          DataColumn(label: Text('Internal Mark')),
                        ],
                        rows: List.generate(
                          internals?.length ?? 0,
                          (index) {
                            final internal = internals?[index];
                            return DataRow(cells: [
                              DataCell(Text('${index + 1}')),
                              DataCell(
                                Text(
                                  (internal?['subname'] ?? "Nill"),
                                ),
                              ),
                              DataCell(
                                Text(
                                  (internal?['teachfname'] ?? "Nill") +
                                      " " +
                                      (internal?['teachsname'] ?? "Nill"),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              DataCell(
                                Text(
                                  (internal?['internalmark'] ?? "Nill"),
                                ),
                              )
                            ]);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ]),
        drawer: studDrawer(),
      ),
    );
  }
}
