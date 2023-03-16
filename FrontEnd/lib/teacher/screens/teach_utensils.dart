// ignore_for_file: prefer_const_constructors, duplicate_ignore, avoid_unnecessary_containers, camel_case_types

import 'package:flutter/material.dart';

import '../assets/drawer.dart';

class teach_Utensils extends StatefulWidget {
  const teach_Utensils({super.key});

  @override
  State<teach_Utensils> createState() => _teach_UtensilsState();
}

class _teach_UtensilsState extends State<teach_Utensils> {
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
        body: Container(
          child: Center(
            child: Text("utensils page"),
          ),
        ),
        drawer: teach_Drawer(),
      ),
    );
  }
}
