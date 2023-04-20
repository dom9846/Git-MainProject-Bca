// ignore_for_file: unnecessary_cast, prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mainproject/services/rating_service.dart';
import 'package:mainproject/teacher/assets/drawer.dart';

class RateTask_Status extends StatefulWidget {
  const RateTask_Status({super.key});

  @override
  State<RateTask_Status> createState() => _RateTask_StatusState();
}

class _RateTask_StatusState extends State<RateTask_Status> {
  String? jwt, userId, workid = "", semester = "";
  List? rates;
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    retrieverates();
  }

  ratingService rateservice = new ratingService();
  Future<void> retrieverates() async {
    var rate = jsonEncode({
      "id": workid,
    });
    print(rate);
    try {
      final Response? res = await rateservice.retrieverates(rate);
      if (res!.statusCode == 201) {
        setState(() {
          rates = res.data;
        });
        print(rates);
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
    workid = sub['workid'].toString();
    print("object");
    print(workid);
    print("object");
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
                  'List Of Ratings',
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
                          DataColumn(label: Text('Student Name')),
                          DataColumn(label: Text('Teaching')),
                          DataColumn(label: Text('Notes')),
                          DataColumn(label: Text('Behaviour')),
                          DataColumn(label: Text('Overall')),
                          DataColumn(label: Text('Date')),
                        ],
                        rows: List.generate(
                          rates?.length ?? 0,
                          (index) {
                            String file;
                            final rate = rates?[index];
                            final dateTimeString1 = rate?['date'];
                            final dateTime1 = dateTimeString1 != null
                                ? DateTime.parse(dateTimeString1)
                                : null;
                            final dateString1 = dateTime1 != null
                                ? DateFormat("dd-MM-yyyy").format(dateTime1)
                                : null;
                            String doubleString = rate?['overall'];
                            double doubleValue = double.parse(doubleString);
                            String formattedStringoverall =
                                doubleValue.toStringAsFixed(1);
                            return DataRow(cells: [
                              DataCell(Text('${index + 1}')),
                              DataCell(
                                Text(
                                  (rate?['studentfname'] ?? "Nill") +
                                      " " +
                                      (rate?['studentsname'] ?? "Nill"),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              DataCell(
                                Text(
                                  (rate?['rating1'] ?? "Nill"),
                                ),
                              ),
                              DataCell(
                                Text(
                                  (rate?['rating2'] ?? "Nill"),
                                ),
                              ),
                              DataCell(
                                Text(
                                  (rate?['rating3'] ?? "Nill"),
                                ),
                              ),
                              DataCell(
                                Text(
                                  (formattedStringoverall),
                                ),
                              ),
                              DataCell(
                                dateString1 != null
                                    ? Text(dateString1,
                                        style: TextStyle(fontSize: 18))
                                    : Text("Null"),
                              ),
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
        drawer: teach_Drawer(),
      ),
    );
  }
}
