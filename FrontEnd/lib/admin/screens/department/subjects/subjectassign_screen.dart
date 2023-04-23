// ignore_for_file: camel_case_types, avoid_print, prefer_const_constructors, unnecessary_this, implementation_imports, unused_local_variable

import 'package:flutter/material.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mainproject/services/subject_service.dart';
import '../../../assets/drawer.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class Subject_Assign extends StatefulWidget {
  const Subject_Assign({super.key});

  @override
  State<Subject_Assign> createState() => _Subject_AssignState();
}

class _Subject_AssignState extends State<Subject_Assign> {
  final _formkey = GlobalKey<FormState>();
  String? semester;
  dynamic subjectname, teachername;
  List<dynamic> items1 = [];
  List<dynamic> items2 = [];
  // List? items1;
  // List? items2;
  final List<String> items3 = ['1', '2', '3', '4', '5', '6'];
  subjectservice subjectassign = subjectservice();
  final storage = new FlutterSecureStorage();
  bool isLoggedin = true;
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

  Future<void> getsubjects(String sem) async {
    try {
      var subject = jsonEncode({
        "semester": sem,
      });
      print(subject);
      final Response? res = await subjectassign.subjectretrieve(subject);
      if (res!.statusCode == 201) {
        setState(() {
          items1 = res.data;
        });
        print(items1);
      }
    } on DioError catch (err) {
      if (err.response != null) {}
    }
  }

  Future<void> getlectures() async {
    try {
      // var user = jsonEncode({
      //   "user_type": "Teacher",
      // });
      // print("hello");
      final Response? res = await subjectassign.lectureretrieve("");
      // print(res);
      if (res!.statusCode == 201) {
        setState(() {
          items2 = res.data;
        });
      }
    } on DioError catch (err) {
      if (err.response != null) {}
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

  Future<void> assignsub() async {
    if (_formkey.currentState!.validate()) {
      var subassign = jsonEncode({
        "subid": subjectname['_id'],
        "subteacher": teachername['_id'],
        "subteacherfname": teachername['firstname'],
        "subteachersname": teachername['secondname'],
      });
      print(subassign);
      try {
        final Response? res = await subjectassign.subjectassign(subassign);
        if (res!.statusCode == 201) {
          showError("Successfully Assigned Subject", "Subject Assigned");
        }
      } on DioError catch (err) {
        if (err.response != null) {
          if (err.response!.statusCode == 401) {
            showError("Remove it for another Assign", "Allready Assigned");
          }
        }
      }
    }
  }

  void initState() {
    super.initState();
    this.getlectures();
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
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 55, top: 60),
              child: Text(
                'Assign Subject',
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
                                        'Semester',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: items3
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
                                value: semester,
                                onChanged: (value) {
                                  setState(() {
                                    semester = value as String;
                                  });
                                  getsubjects(semester!);
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
                                        'Subject',
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
                                    .map((item) => DropdownMenuItem<dynamic>(
                                          value: item,
                                          child: Text(
                                            item['subjectname'],
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: subjectname,
                                onChanged: (value) {
                                  setState(() {
                                    subjectname = value;
                                    print(subjectname);
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
                                        'Teacher',
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
                                    .map((item) => DropdownMenuItem<dynamic>(
                                          value: item,
                                          child: Text(
                                            item['firstname'] +
                                                " " +
                                                item['secondname'],
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: teachername,
                                onChanged: (value) {
                                  setState(() {
                                    teachername = value;
                                    print(teachername);
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
                            // ignore: prefer_const_constructors
                            SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(80, 40)),
                                onPressed: assignsub,
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
        ),
        drawer: cldrawer(),
      ),
    );
  }
}
