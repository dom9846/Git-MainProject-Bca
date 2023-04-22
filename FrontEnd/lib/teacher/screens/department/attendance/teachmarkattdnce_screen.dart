// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mainproject/services/getuser_service.dart';
import 'package:mainproject/services/timeattendint_service.dart';
import 'package:mainproject/teacher/assets/drawer.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class MarkAttendance_Teacher extends StatefulWidget {
  const MarkAttendance_Teacher({super.key});

  @override
  State<MarkAttendance_Teacher> createState() => _MarkAttendance_TeacherState();
}

class _MarkAttendance_TeacherState extends State<MarkAttendance_Teacher> {
  final _formkey = GlobalKey<FormState>();

  String? jwt, userId;
  String? semester, period, year = "";
  final List<String> items2 = ['1', '2', '3', '4', '5', '6', '7'];
  List<dynamic>? students;
  List<dynamic> selectedOptions = [];
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    getstudents();
  }

  // final storage = new FlutterSecureStorage();
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
    print(semester);
    if (semester == '1' || semester == '2') {
      print("hello");
      setState(() {
        year = '1';
      });
    } else if (semester == '3' || semester == '4') {
      setState(() {
        year = '2';
      });
    } else if (semester == '5' || semester == '6') {
      setState(() {
        year = '3';
      });
    } else {}
    // print(year);
    try {
      var user = jsonEncode({
        "year": year,
      });
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

  DateTime? _selectedDate;

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
      });
    }
  }

  timeattendintservice attendanceservice = new timeattendintservice();
  Future<void> submit() async {
    print(selectedOptions);
    if (_formkey.currentState!.validate()) {
      var attendance = jsonEncode({
        "semester": semester,
        "date": _selectedDate!.toIso8601String(),
        "period": period,
        "absentstudentlist": selectedOptions
      });
      print(attendance);
      try {
        final Response? res = await attendanceservice.putattendance(attendance);
        // if (res!.statusCode == 401) {}
        showError("Successfully Recorded", "Attendance");
      } on DioError catch (err) {
        if (err.response != null) {
          if (err.response!.statusCode == 401) {
            showError("Attendance Allready Marked", "Period Was Finished");
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
    final Object? semesterofstudent =
        ModalRoute.of(context as BuildContext)?.settings.arguments;
    semester = semesterofstudent.toString();
    // print(semester);
    return Container(
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // ignore: duplicate_ignore
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          // ignore: prefer_const_constructors
          title: Text(
            "INNOVIS",
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
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 55, top: 60),
              child: Text(
                'Mark Attendance',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
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
                            offset: Offset(0, 3), // changes position of shadow
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
                                        'Period',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: items2
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
                                value: period,
                                onChanged: (value) {
                                  setState(() {
                                    period = value as String;
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
                                        MaterialStateProperty.all<double>(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Column(
                              children: [
                                // Add other widgets here
                                SizedBox(
                                  height: 300,
                                  child: ListView.builder(
                                    itemCount: students?.length,
                                    itemBuilder: (context, index) {
                                      final student = students?[index];
                                      // final studDetails =
                                      //     student?['stud_details']?[0];
                                      return CheckboxListTile(
                                        title: Text(
                                          (students?[index]?['firstname'] ??
                                                  "Nill") +
                                              " " +
                                              (students?[index]
                                                      ?['secondname'] ??
                                                  "Nill"),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        value: selectedOptions
                                            .contains(students?[index]),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value != null) {
                                              selectedOptions.add(student);
                                            } else {
                                              selectedOptions.remove(student);
                                            }
                                          });
                                        },
                                        subtitle: Text("Roll No:" +
                                            (students?[index]?['stud_details']
                                                    ?[0]?['rollno'] ??
                                                "Nill")),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(80, 40)),
                                onPressed: () {
                                  submit();
                                },
                                child: Text("Submit"))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        drawer: teach_Drawer(),
      ),
    );
  }
}
