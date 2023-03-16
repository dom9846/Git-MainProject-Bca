// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, camel_case_types

import 'package:flutter/material.dart';

import '../../assets/drawer.dart';

class Stud_screen extends StatefulWidget {
  const Stud_screen({super.key});

  @override
  State<Stud_screen> createState() => _Stud_screenState();
}

class _Stud_screenState extends State<Stud_screen> {
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
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Our Students',
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
                              Text("Semester"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("age"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("email"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Mobile"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Parent Name"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Parent Contact"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Attendance Percentage"),
                              SizedBox(
                                height: 8,
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
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
        drawer: cldrawer(),
      ),
    );
  }
}
