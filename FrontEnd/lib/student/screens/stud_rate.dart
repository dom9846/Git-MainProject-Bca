// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../assets/drawer.dart';

class stud_Rate extends StatefulWidget {
  const stud_Rate({super.key});

  @override
  State<stud_Rate> createState() => _stud_RateState();
}

final _formkey = GlobalKey<FormState>();
String? lecture_name;
String? notes_value;
String? teach_Value;
String? communication_value;
String? comment;

class _stud_RateState extends State<stud_Rate> {
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
                      Navigator.pushNamed(context, "/studmessage");
                    },
                    icon: Icon(Icons.message_sharp)))
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        'Rate Any\n Lecture',
                        style: GoogleFonts.alike(
                            textStyle: Theme.of(context).textTheme.displaySmall,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      // top: MediaQuery.of(context).size.height * 0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 35, right: 35),
                            child: Column(
                              children: [
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                                  hint: Text('Select A Lecture'),
                                  value: lecture_name,
                                  onChanged: (newValue) {
                                    setState(() {
                                      lecture_name = newValue;
                                    });
                                  },
                                  // ignore: prefer_const_literals_to_create_immutables
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('Option 1'),
                                      value: 'Lecture 1',
                                    ),
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This Field Cannot Be Empty";
                                    } else {
                                      setState(() {
                                        lecture_name = value;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                                  hint: Text('Notes'),
                                  value: notes_value,
                                  onChanged: (newValue) {
                                    setState(() {
                                      notes_value = newValue;
                                    });
                                  },
                                  // ignore: prefer_const_literals_to_create_immutables
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('Star 1'),
                                      value: '1',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Star 2'),
                                      value: '2',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Star 3'),
                                      value: '3',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Star 4'),
                                      value: '4',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Star 5'),
                                      value: '5',
                                    ),
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This Field Cannot Be Empty";
                                    } else {
                                      setState(() {
                                        notes_value = value;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                                  hint: Text('Teaching'),
                                  value: teach_Value,
                                  onChanged: (newValue) {
                                    setState(() {
                                      teach_Value = newValue;
                                    });
                                  },
                                  // ignore: prefer_const_literals_to_create_immutables
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('Star 1'),
                                      value: '1',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Star 2'),
                                      value: '2',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Star 3'),
                                      value: '3',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Star 4'),
                                      value: '4',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Star 5'),
                                      value: '5',
                                    ),
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This Field Cannot Be Empty";
                                    } else {
                                      setState(() {
                                        teach_Value = value;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                                  hint: Text('Communication'),
                                  value: communication_value,
                                  onChanged: (newValue) {
                                    setState(() {
                                      communication_value = newValue;
                                    });
                                  },
                                  // ignore: prefer_const_literals_to_create_immutables
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('Star 1'),
                                      value: '1',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Star 2'),
                                      value: '2',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Star 3'),
                                      value: '3',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Star 4'),
                                      value: '4',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Star 5'),
                                      value: '5',
                                    ),
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This Field Cannot Be Empty";
                                    } else {
                                      setState(() {
                                        communication_value = value;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  style: TextStyle(),
                                  maxLines: 2,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      labelText: "Comment",
                                      hintText: "Give A Comment",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This Field Cannot Be Empty";
                                    } else {
                                      setState(() {
                                        comment = value;
                                      });
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        print(lecture_name);
                                        print(notes_value);
                                        print(teach_Value);
                                        print(communication_value);
                                        print(comment);
                                      }
                                    },
                                    child: Text("Submit")),
                                SizedBox(
                                  height: 40,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        drawer: studDrawer(),
      ),
    );
  }
}
