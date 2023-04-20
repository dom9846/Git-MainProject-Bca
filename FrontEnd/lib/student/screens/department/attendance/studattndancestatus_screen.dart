// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mainproject/services/timeattendint_service.dart';
import 'package:mainproject/student/assets/drawer.dart';

class Studattendance_Status extends StatefulWidget {
  const Studattendance_Status({super.key});

  @override
  State<Studattendance_Status> createState() => _Studattendance_StatusState();
}

class _Studattendance_StatusState extends State<Studattendance_Status> {
  final _formkey = GlobalKey<FormState>();
  String? jwt, userId;
  List? allattendances, studattendances;
  String? semester = "", studentfname = "", studentsname = "";
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    getattendances();
  }

  timeattendintservice attendanceservice = new timeattendintservice();
  int numStudAttendances = 0;
  int numAllAttendances = 0;
  Future<void> getattendances() async {
    var user = jsonEncode({
      "semester": semester,
      "_id": userId,
    });
    print(user);
    var sem = jsonEncode({"semester": semester});
    print(sem);
    try {
      final Response? res1 = await attendanceservice.getstudattendances(user);
      if (res1!.statusCode == 201) {
        setState(() {
          studattendances = res1.data;
          numStudAttendances = studattendances!.length;
        });
        print(studattendances);
      }
      final Response? res2 = await attendanceservice.getallattendances(sem);
      if (res2!.statusCode == 201) {
        setState(() {
          allattendances = res2.data;
          numAllAttendances = allattendances!.length;
        });
        print(numAllAttendances);
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
            "Time Line",
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
                  'Your Attendance Status',
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
                  height: 150,
                  width: 350,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          'Total periods:' + (numAllAttendances.toString()),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Number of Absents:' +
                              (numStudAttendances.toString()),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Days Which You Are Absent",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color.fromARGB(255, 228, 230, 233),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                    itemCount: studattendances?.length,
                    itemBuilder: (context, index) {
                      final attendance = studattendances?[index];
                      final dateTimeString1 = attendance?['date'];
                      final dateTime1 = dateTimeString1 != null
                          ? DateTime.parse(dateTimeString1)
                          : null;
                      final dateString1 = dateTime1 != null
                          ? DateFormat("dd-MM-yyyy").format(dateTime1)
                          : null;
                      return Card(
                        child: InkWell(
                          // onTap: () => {
                          //   Navigator.pushNamed(
                          //       context, "/studdepaccdemyrateform",
                          //       arguments: {'taskid': ratingtask?['_id']})
                          // },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Title(
                                  color: Colors.black,
                                  child: dateString1 != null
                                      ? Text(
                                          "Attendance On:" + dateString1,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 23, 22, 22)),
                                        )
                                      : Text("Null"),
                                ),
                                SizedBox(height: 10),
                                Text("Period:" +
                                    (attendance?['period'] ?? "Nill")),
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
        drawer: studDrawer(),
      ),
    );
  }
}
