// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mainproject/teacher/assets/drawer.dart';

class AssignNew_Work extends StatefulWidget {
  const AssignNew_Work({super.key});

  @override
  State<AssignNew_Work> createState() => _AssignNew_WorkState();
}

final _formkey = GlobalKey<FormState>();
String worktype = "", duedate = "", objective = "";

class _AssignNew_WorkState extends State<AssignNew_Work> {
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
                'Assign New Work',
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
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 22, 47, 230),
                                    ),
                                  ),
                                  labelText: "Work Type",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: "Select Type Of work",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 14, 14, 14)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This Field Cannot Be Empty";
                                } else {
                                  setState(() {
                                    worktype = value;
                                  });
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.datetime,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 22, 47, 230),
                                    ),
                                  ),
                                  labelText: "Due Date",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: "Enter The Last Date",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 7, 7, 7)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This Field Cannot Be Empty";
                                } else {
                                  setState(() {
                                    duedate = value;
                                  });
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.name,
                              obscureText: true,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 22, 47, 230),
                                    ),
                                  ),
                                  labelText: "Objective",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: "Describe The Work",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 12, 12, 12)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This Field Cannot Be Empty";
                                } else {
                                  setState(() {
                                    objective = value;
                                  });
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(80, 40)),
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    print(worktype);
                                    print(duedate);
                                    print(objective);
                                  }
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
        ),
        drawer: teach_Drawer(),
      ),
    );
  }
}
