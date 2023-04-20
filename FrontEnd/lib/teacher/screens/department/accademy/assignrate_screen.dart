// ignore_for_file: prefer_const_constructors, camel_case_types

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mainproject/services/getuser_service.dart';
import 'package:mainproject/services/rating_service.dart';
import 'package:mainproject/teacher/assets/drawer.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';

class AssignRate_teacherScreen extends StatefulWidget {
  const AssignRate_teacherScreen({super.key});

  @override
  State<AssignRate_teacherScreen> createState() =>
      _AssignRate_teacherScreenState();
}

class _AssignRate_teacherScreenState extends State<AssignRate_teacherScreen> {
  final _formkey = GlobalKey<FormState>();
  String? teachfname = "", teachsname = "", usertype = "";
  String? propic = "", email = "", mobile = "", age = "", qualification = "";
  String? year, duedate = "";
  final List<String> items1 = ['1', '2', '3'];
  DateTime? _selectedDate, _todaydate;
  String? jwt, userId, subjectid, semester;
  List<dynamic>? students;
  List<dynamic> selectedOptions = [];
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    getteacherprof();
  }

  getuserservice getteacherservice = new getuserservice();
  Future<void> getteacherprof() async {
    try {
      var user = jsonEncode({
        "id": userId,
      });
      final Response? res = await getteacherservice.getteacher(user);
      if (res!.statusCode == 201) {
        setState(() {
          teachfname = res.data["fname"];
          teachsname = res.data["sname"];
          // mobile = res.data["mobile"].toString();
          // age = res.data["age"].toString();
          // qualification = res.data["qualification"];
        });
      }
    } on DioError catch (err) {
      if (err.response != null) {}
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _todaydate = DateTime.now();
      });
    }
  }

  ratingService rateassignservice = new ratingService();
  Future<void> assignteachratework() async {
    if (_formkey.currentState!.validate()) {
      var assigntask = jsonEncode({
        "teacherid": userId,
        "teachfname": teachfname,
        "teachsname": teachsname,
        "year": year,
        "duedate": _selectedDate!.toIso8601String(),
        "date": _todaydate!.toIso8601String()
      });
      print(assigntask);
      try {
        final Response? res =
            await rateassignservice.assignratetask(assigntask);
        if (res!.statusCode == 201) {
          showError("Successfully Assigned", "New Rating Tak");
        }
      } on DioError catch (err) {
        if (err.response != null) {
          if (err.response!.statusCode == 401) {
            showError("Already Assigned,Delete It First!", "Cannot Done");
          }
        }
      }
    }
  }

  showError(String content, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  // if (title == "Registration Successful") {
                  //   // Navigator.pushNamed(context, '/login');
                  // } else
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
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
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Assign Rating',
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
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 50, bottom: 50, left: 20, right: 20),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(left: 35, right: 35),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: const [
                                        Icon(
                                          Icons.list,
                                          size: 16,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Select Year',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: items1
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: year,
                                    onChanged: (value) {
                                      setState(() {
                                        year = value as String;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 60,
                                      width: 300,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        color: Colors.white,
                                      ),
                                      elevation: 2,
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 200,
                                      padding: null,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.white,
                                      ),
                                      elevation: 8,
                                      offset: const Offset(-20, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness:
                                            MaterialStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            MaterialStateProperty.all<bool>(
                                                true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          labelText: _selectedDate == null
                                              ? 'Select a date'
                                              : DateFormat('yyyy-MM-dd')
                                                  .format(_selectedDate!),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    ElevatedButton(
                                      onPressed: () => _selectDate(context),
                                      child: Text('Select'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(80, 40)),
                                    onPressed: () {
                                      assignteachratework();
                                    },
                                    child: Text("Assign"))
                              ],
                            ),
                          ),
                        )
                      ],
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
