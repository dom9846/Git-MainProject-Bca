// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mainproject/services/subject_service.dart';
import 'package:mainproject/teacher/assets/drawer.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf_flutter/pdf_flutter.dart';

class submittedWork_screen extends StatefulWidget {
  const submittedWork_screen({super.key});

  @override
  State<submittedWork_screen> createState() => _submittedWork_screenState();
}

class _submittedWork_screenState extends State<submittedWork_screen> {
  String? jwt, userId, workid = "", semester = "";
  List? submittedworks;
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    retrievework();
  }

  subjectservice submittedworkservice = new subjectservice();
  Future<void> retrievework() async {
    var work = jsonEncode({
      "id": workid,
    });
    try {
      final Response? res =
          await submittedworkservice.retrievesubmittedwork(work);
      if (res!.statusCode == 201) {
        setState(() {
          submittedworks = res.data;
        });
        print(submittedworks);
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
    print(workid);
    // semester = sub['semester'].toString();
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
                  'List Of Submissions',
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
                          DataColumn(label: Text('Assigned Work')),
                          DataColumn(label: Text('Date')),
                        ],
                        rows: List.generate(
                          submittedworks?.length ?? 0,
                          (index) {
                            String file;
                            final submittedwork = submittedworks?[index];
                            final dateTimeString1 = submittedwork?['date'];
                            final dateTime1 = dateTimeString1 != null
                                ? DateTime.parse(dateTimeString1)
                                : null;
                            final dateString1 = dateTime1 != null
                                ? DateFormat("dd-MM-yyyy").format(dateTime1)
                                : null;
                            // if (submittedwork != null) {
                            //   final pdfBase64 = submittedwork?['workfile'];
                            //   final pdfBytes = base64Decode(pdfBase64);
                            //   final pdfDoc = await PDFDocument.fromBytes(pdfBytes);
                            //   file = PDF.network(
                            //     pdfBase64,
                            //     height: 40,
                            //     width: 40,
                            //   );
                            // }
                            return DataRow(cells: [
                              DataCell(Text('${index + 1}')),
                              DataCell(
                                Text(
                                  (submittedwork?['studentfname'] ?? "Nill") +
                                      " " +
                                      (submittedwork?['studentsname'] ??
                                          "Nill"),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              DataCell(Icon(Icons.picture_as_pdf)),
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
