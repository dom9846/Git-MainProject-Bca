// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';

import '../../../assets/drawer.dart';

class Attdnce_date extends StatefulWidget {
  const Attdnce_date({super.key});

  @override
  State<Attdnce_date> createState() => _Attdnce_dateState();
}

class _Attdnce_dateState extends State<Attdnce_date> {
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
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Attendance',
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
                      'Date',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text("Total Number Of Absence"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Students List(rollno)"),
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
        drawer: cldrawer(),
      ),
    );
  }
}
