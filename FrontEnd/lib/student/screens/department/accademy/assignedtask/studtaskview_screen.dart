// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mainproject/student/assets/drawer.dart';

class TaskView_semesterwise extends StatefulWidget {
  const TaskView_semesterwise({super.key});

  @override
  State<TaskView_semesterwise> createState() => _TaskView_semesterwiseState();
}

class _TaskView_semesterwiseState extends State<TaskView_semesterwise> {
  File? _selectedFile;

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
                  'Task`s',
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
                Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: ExpansionTile(
                    title: Text(
                      'Task Type',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Question",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text("Subject"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Semester"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Status"),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                width: 150,
                                height: 150,
                                child: Center(child: Text("data")),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextButton(
                                  onPressed: () async {
                                    final result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['pdf'],
                                    );
                                    if (result != null) {
                                      setState(() {
                                        _selectedFile =
                                            File(result.files.single.path!);
                                      });
                                    }
                                  },
                                  child: Text("Upload")),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          )),
                    ],
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
