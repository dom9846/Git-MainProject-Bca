// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore, unused_local_variable, non_constant_identifier_names

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mainproject/admin/assets/drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:mainproject/services/timeattendint_service.dart';

class Timetable_Screen extends StatefulWidget {
  const Timetable_Screen({super.key});

  @override
  State<Timetable_Screen> createState() => _Syllabus_ScreenState();
}

class _Syllabus_ScreenState extends State<Timetable_Screen> {
  timeattendintservice timetableupdate = timeattendintservice();
  final storage = new FlutterSecureStorage();
  String? jwt, userId;
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    print(userId);
  }

  void initState() {
    super.initState();
    this.getToken();
  }

  XFile? time_table_1, time_table_2, time_table_3;
  String image1 = "", image2 = "", image3 = "";
  Future<void> _Time_Table_1(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    List<String>? s = pickedFile?.path.toString().split("/");
    final bytes = await File(pickedFile!.path).readAsBytes();
    final base64 = base64Encode(bytes);

    var pic =
        "data:image/" + s![s.length - 1].split(".")[1] + ";base64," + base64;
    print(pic);
    if (pickedFile != null) {
      setState(() {
        image1 = pic;
        time_table_1 = pickedFile;
      });
      update();
    }
  }

  Future<void> _Time_Table_2(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    List<String>? s = pickedFile?.path.toString().split("/");
    final bytes = await File(pickedFile!.path).readAsBytes();
    final base64 = base64Encode(bytes);

    var pic =
        "data:image/" + s![s.length - 1].split(".")[1] + ";base64," + base64;
    print(pic);
    if (pickedFile != null) {
      setState(() {
        image2 = pic;
        time_table_2 = pickedFile;
      });
      update();
    }
  }

  Future<void> _Time_Table_3(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    List<String>? s = pickedFile?.path.toString().split("/");
    final bytes = await File(pickedFile!.path).readAsBytes();
    final base64 = base64Encode(bytes);

    var pic =
        "data:image/" + s![s.length - 1].split(".")[1] + ";base64," + base64;
    print(pic);
    if (pickedFile != null) {
      setState(() {
        image3 = pic;
        time_table_3 = pickedFile;
      });
      update();
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

  Future<void> update() async {
    var timetbl = jsonEncode({
      "identity": userId,
      "year1": image1,
      "year2": image2,
      "year3": image3
    });
    print(timetbl);
    try {
      final Response? res = await timetableupdate.timetable(timetbl);
      // if (res!.statusCode == 401) {}
      showError("Successfully Updated Timetable", "Time Table");
    } on DioError catch (err) {
      if (err.response != null) {
        showError("Some Error Occured!", "Oops");
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        showError("Something Went Wrong!", "Cannot Be Done");
      }
    }
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
        body: ListView(children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Time Table-1st Year',
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
                  padding: EdgeInsets.all(20),
                  height: 250,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: time_table_1 == null
                        ? Text('No image selected.')
                        : Image.file(File(time_table_1!.path),
                            fit: BoxFit.contain),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.camera_alt),
                                  title: Text('Take a photo'),
                                  onTap: () {
                                    _Time_Table_1(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.image),
                                  title: Text('Choose from gallery'),
                                  onTap: () {
                                    _Time_Table_1(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.arrow_upward,
                      color: Colors.black,
                    ),
                    label: Text(
                      "Upload",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Time Table-2nd Year',
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
                  padding: EdgeInsets.all(20),
                  height: 250,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: time_table_2 == null
                        ? Text('No image selected.')
                        : Image.file(File(time_table_2!.path),
                            fit: BoxFit.contain),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.camera_alt),
                                  title: Text('Take a photo'),
                                  onTap: () {
                                    _Time_Table_2(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.image),
                                  title: Text('Choose from gallery'),
                                  onTap: () {
                                    _Time_Table_2(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.arrow_upward,
                      color: Colors.black,
                    ),
                    label: Text(
                      "Upload",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Time Table-3rd Year',
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
                  padding: EdgeInsets.all(20),
                  height: 250,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: time_table_3 == null
                        ? Text('No image selected.')
                        : Image.file(File(time_table_3!.path),
                            fit: BoxFit.contain),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.camera_alt),
                                  title: Text('Take a photo'),
                                  onTap: () {
                                    _Time_Table_3(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.image),
                                  title: Text('Choose from gallery'),
                                  onTap: () {
                                    _Time_Table_3(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.arrow_upward,
                      color: Colors.black,
                    ),
                    label: Text(
                      "Upload",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                // ElevatedButton(
                //     onPressed: () async {
                //       FilePickerResult? result =
                //           await FilePicker.platform.pickFiles();
                //       if (result != null) {
                //         File file = File(result.files.single.path);
                //       } else {
                //         // User canceled the picker
                //       }
                //     },
                //     child: Text("Select The Document"))
              ],
            )),
          ),
        ]),
        drawer: cldrawer(),
      ),
    );
  }
}
