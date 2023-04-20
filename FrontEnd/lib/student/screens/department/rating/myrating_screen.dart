// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mainproject/services/rating_service.dart';
import 'package:mainproject/student/assets/drawer.dart';

class Myrating_ScreenStud extends StatefulWidget {
  const Myrating_ScreenStud({super.key});

  @override
  State<Myrating_ScreenStud> createState() => _Myrating_ScreenStudState();
}

class _Myrating_ScreenStudState extends State<Myrating_ScreenStud> {
  // final _formkey = GlobalKey<FormState>();
  String? jwt, userId;
  List? ratings;
  String? semester = "", studentfname = "", studentsname = "";
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    getinternals();
  }

  ratingService ratingservice = new ratingService();
  Future<void> getinternals() async {
    var user = jsonEncode({
      "semester": semester,
      "studentid": userId,
    });
    print(user);
    try {
      final Response? res = await ratingservice.retrieveratesstud(user);
      if (res!.statusCode == 201) {
        setState(() {
          ratings = res.data;
        });
        print(ratings);
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
    print(semester);
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
                  'My Ratings',
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
                          DataColumn(label: Text('Rating')),
                        ],
                        rows: List.generate(
                          ratings?.length ?? 0,
                          (index) {
                            final rate = ratings?[index];
                            return DataRow(cells: [
                              DataCell(Text('${index + 1}')),
                              DataCell(
                                Text(
                                  (rate?['subname'] ?? "Nill"),
                                ),
                              ),
                              DataCell(
                                Text(
                                  (rate?['teachfname'] ?? "Nill") +
                                      " " +
                                      (rate?['teachsname'] ?? "Nill"),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              DataCell(
                                Text(
                                  (rate?['rating'] ?? "Nill"),
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
