// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:flutter/material.dart';

import '../../../assets/drawer.dart';

class Subject_details extends StatefulWidget {
  const Subject_details({super.key});

  @override
  State<Subject_details> createState() => _Subject_detailsState();
}

class _Subject_detailsState extends State<Subject_details> {
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
                  'Subjects',
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
                      'Subject Name',
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
                              Text("Subject Type"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Assigned To:Lecture name"),
                              SizedBox(
                                height: 8,
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Remove Subject",
                                    style: TextStyle(color: Colors.red),
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Remove Subject Assign",
                                    style: TextStyle(color: Colors.red),
                                  )),
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
