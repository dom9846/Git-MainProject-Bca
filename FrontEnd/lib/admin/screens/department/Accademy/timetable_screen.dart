// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore, unused_local_variable, non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mainproject/admin/assets/drawer.dart';
import 'package:image_picker/image_picker.dart';

class Timetable_Screen extends StatefulWidget {
  const Timetable_Screen({super.key});

  @override
  State<Timetable_Screen> createState() => _Syllabus_ScreenState();
}

class _Syllabus_ScreenState extends State<Timetable_Screen> {
  File? time_table_1, time_table_2, time_table_3;
  Future<void> _Time_Table_1(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        time_table_1 = File(pickedFile.path);
      });
    }
  }

  Future<void> _Time_Table_2(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        time_table_2 = File(pickedFile.path);
      });
    }
  }

  Future<void> _Time_Table_3(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        time_table_3 = File(pickedFile.path);
      });
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
                        : Image.file(time_table_1!, fit: BoxFit.contain),
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
                        : Image.file(time_table_2!, fit: BoxFit.contain),
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
                        : Image.file(time_table_3!, fit: BoxFit.contain),
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
