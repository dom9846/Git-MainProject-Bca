// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mainproject/teacher/assets/drawer.dart';

class Teach_InternalStudent extends StatefulWidget {
  const Teach_InternalStudent({super.key});

  @override
  State<Teach_InternalStudent> createState() => _Teach_InternalStudentState();
}

final _formkey = GlobalKey<FormState>();
String mark = "";

class _Teach_InternalStudentState extends State<Teach_InternalStudent> {
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
                  'Internal For Students',
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
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://picsum.photos/200'),
                      radius: 30,
                    ),
                    title: Text(
                      'Student Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Roll No',
                      style: TextStyle(fontSize: 16),
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Form(
                                  key: _formkey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        style: TextStyle(color: Colors.black),
                                        keyboardType: TextInputType.name,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 22, 47, 230),
                                              ),
                                            ),
                                            labelText: "Internal Mark",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            hintText:
                                                "You Cannot Edit This Later",
                                            hintStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 12, 12, 12)),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This Field Cannot Be Empty";
                                          } else {
                                            setState(() {
                                              mark = value;
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
                                            if (_formkey.currentState!
                                                .validate()) {
                                              print(mark);
                                            }
                                          },
                                          child: Text("Submit"))
                                    ],
                                  ))
                            ],
                          )),
                    ],
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
