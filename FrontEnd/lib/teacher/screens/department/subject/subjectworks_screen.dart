// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mainproject/teacher/assets/drawer.dart';

class SubjectWork_Screen extends StatefulWidget {
  const SubjectWork_Screen({super.key});

  @override
  State<SubjectWork_Screen> createState() => _SubjectWork_ScreenState();
}

class _SubjectWork_ScreenState extends State<SubjectWork_Screen> {
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
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Subject Work',
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
                  child: InkWell(
                    onTap: () =>
                        {Navigator.pushNamed(context, "/teachdepexistwork")},
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(Icons.onetwothree_outlined),
                          SizedBox(width: 16),
                          Text("Existing Work"),
                        ],
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 30,
                // ),
                Card(
                  child: InkWell(
                    onTap: () =>
                        {Navigator.pushNamed(context, "/teachdepnewwork")},
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(Icons.onetwothree_outlined),
                          SizedBox(width: 16),
                          Text("Assign New Work"),
                        ],
                      ),
                    ),
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
