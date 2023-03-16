// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';

class Chat_Screen_admn extends StatefulWidget {
  const Chat_Screen_admn({super.key});

  @override
  State<Chat_Screen_admn> createState() => _Chat_Screen_admnState();
}

class _Chat_Screen_admnState extends State<Chat_Screen_admn> {
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
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.clear_all),
                      label: Text("Clear all")))
            ],
          ),
          body: ListView(children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Center(
                  child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 30,
                  ),
                  // ignore: prefer_const_constructors
                  Text(
                    '1-2-3 Year Chat Box',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 228, 230, 233),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 30,
                  ),
                ],
              )),
            ),
          ])),
    );
  }
}
