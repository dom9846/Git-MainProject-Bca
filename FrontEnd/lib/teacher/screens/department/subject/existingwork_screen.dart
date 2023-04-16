// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_interpolation_to_compose_strings, unused_local_variable, prefer_const_declarations, unnecessary_null_comparison

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mainproject/services/subject_service.dart';
import 'package:mainproject/teacher/assets/drawer.dart';

class ExistingSubjectWork_Screen extends StatefulWidget {
  const ExistingSubjectWork_Screen({super.key});

  @override
  State<ExistingSubjectWork_Screen> createState() =>
      _ExistingSubjectWork_ScreenState();
}

class _ExistingSubjectWork_ScreenState
    extends State<ExistingSubjectWork_Screen> {
  String? jwt, userId, subjectid1 = "", semester = "";
  List? subworks;
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    retrievesubwork();
  }

  subjectservice subretrieveworkservice = new subjectservice();
  Future<void> retrievesubwork() async {
    var subwork = jsonEncode({
      "subjectid": subjectid1,
      "semester": semester,
      "teacherid": userId,
    });
    try {
      final Response? res =
          await subretrieveworkservice.retrievesubwork(subwork);
      if (res!.statusCode == 201) {
        setState(() {
          subworks = res.data;
        });
        print(subworks);
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
    subjectid1 = sub['subjectid'].toString();
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
                child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.clear_all),
                    label: Text("Clear all")))
          ],
        ),
        body: ListView(children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Center(
                child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Assigned Works',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 228, 230, 233),
                  ),
                ),
                Column(
                  children: [
                    // Add other widgets here
                    SizedBox(
                      height: 500,
                      child: ListView.builder(
                        itemCount: subworks?.length,
                        itemBuilder: (context, index) {
                          final subwork = subworks?[index];
                          final dateTimeString1 = subwork?['duedate'];
                          final dateTime1 = dateTimeString1 != null
                              ? DateTime.parse(dateTimeString1)
                              : null;
                          final dateString1 = dateTime1 != null
                              ? DateFormat("dd-MM-yyyy").format(dateTime1)
                              : null;
                          final dateTimeString2 = subwork?['date'];
                          final dateTime2 = dateTimeString2 != null
                              ? DateTime.parse(dateTimeString2)
                              : null;
                          final dateString2 = dateTime2 != null
                              ? DateFormat("dd-MM-yyyy").format(dateTime2)
                              : null;
                          return Card(
                            elevation: 2,
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "worktype:" +
                                            (subwork?['worktype'] ?? "Nill"),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      dateString2 != null
                                          ? Text(
                                              "Posted On:" + dateString2,
                                              style: TextStyle(fontSize: 18),
                                            )
                                          : Text("Null"),
                                      SizedBox(height: 8),
                                      dateString1 != null
                                          ? Text(
                                              "duedate:" + dateString1,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 223, 7, 7)),
                                            )
                                          : Text("Null"),
                                      SizedBox(height: 16),
                                      Text(
                                        (subwork?['activity'] ?? "Nill"),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                              onPressed: () {},
                                              child:
                                                  Text("List Of Submissions"))
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                              onPressed: () {},
                                              child: Text("Delete",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 223, 7, 7))))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
