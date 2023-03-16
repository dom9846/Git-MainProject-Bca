// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, duplicate_ignore, camel_case_types, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../assets/drawer.dart';

class teach_Rate extends StatefulWidget {
  const teach_Rate({super.key});

  @override
  State<teach_Rate> createState() => _teach_RateState();
}

final _formkey = GlobalKey<FormState>();
String? _selectedValue1;
String? _selectedValue2;
String? _selectedValue3;
String? _selectedValue4;
String? _selectedValue5;
String? comment;

class _teach_RateState extends State<teach_Rate> {
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
                      Navigator.pushNamed(context, "/teachmessage");
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
                        'Rate Any\n Student',
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
                                  hint: Text('Select The Year'),
                                  value: _selectedValue1,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValue1 = newValue;
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('Year 1'),
                                      value: '1',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Year 2'),
                                      value: '2',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Year 3'),
                                      value: '3',
                                    ),
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This Field Cannot Be Empty";
                                    } else {
                                      setState(() {
                                        _selectedValue1 = value;
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
                                  hint: Text('Select A Student'),
                                  value: _selectedValue2,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValue2 = newValue;
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('Option 1'),
                                      value: 'Student 1',
                                    ),
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This Field Cannot Be Empty";
                                    } else {
                                      setState(() {
                                        _selectedValue2 = value;
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
                                  hint: Text('Studies'),
                                  value: _selectedValue3,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValue3 = newValue;
                                    });
                                  },
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
                                        _selectedValue3 = value;
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
                                  hint: Text('Concentration'),
                                  value: _selectedValue4,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValue4 = newValue;
                                    });
                                  },
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
                                        _selectedValue4 = value;
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
                                  hint: Text('Continuos Evaluation'),
                                  value: _selectedValue5,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValue5 = newValue;
                                    });
                                  },
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
                                        _selectedValue5 = value;
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
                                        print(_selectedValue1);
                                        print(_selectedValue2);
                                        print(_selectedValue3);
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
        drawer: teach_Drawer(),
      ),
    );
  }
}
