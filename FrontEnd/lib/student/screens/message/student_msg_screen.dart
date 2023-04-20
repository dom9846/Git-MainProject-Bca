// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mainproject/services/chat_service.dart';
import 'package:mainproject/services/getuser_service.dart';
import 'package:mainproject/student/assets/drawer.dart';

class Student_Message extends StatefulWidget {
  const Student_Message({super.key});

  @override
  State<Student_Message> createState() => _Student_MessageState();
}

class _Student_MessageState extends State<Student_Message> {
  String? userId = "", firstname = "", secondname = "", usertype = "", year;
  List? rooms;
  // int? lecid;
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
      firstname = allValues["fname"];
      secondname = allValues["sname"];
      usertype = allValues["utype"];
    });
    getstudent();
  }

  getuserservice getstudentservice = new getuserservice();
  Future<void> getstudent() async {
    try {
      var user = jsonEncode({
        "id": userId,
      });
      final Response? res = await getstudentservice.getstudent(user);
      // print(res);
      if (res!.statusCode == 201) {
        setState(() {
          year = res.data["year"].toString();
        });
      }
    } on DioError catch (err) {
      if (err.response != null) {}
    }
    getrooms();
  }

  chatService chatservice = new chatService();
  Future<void> getrooms() async {
    try {
      var sem = jsonEncode({
        "year": year,
      });
      print(sem);
      final Response? res = await chatservice.getstudchatroom(sem);
      if (res!.statusCode == 201) {
        setState(() {
          rooms = res.data;
        });
        print(rooms);
      }
    } on DioError catch (err) {
      if (err.response != null) {}
    }
  }

  void initState() {
    super.initState();
    this.getToken();
  }

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
            "Messages",
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
                      Navigator.pushNamed(context, "/studaddnewpost");
                    },
                    // ignore: prefer_const_constructors
                    icon: Icon(Icons.add_card_sharp))),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/studmessage");
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
                  'Chat Box',
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
                SizedBox(
                  height: 500,
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: rooms?.length,
                      itemBuilder: (context, index) {
                        final room = rooms?[index];
                        return Card(
                          child: InkWell(
                            onTap: () => {
                              Navigator.pushNamed(context, "/studchats",
                                  arguments: {'chatid': room?['_id']})
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Icon(Icons.onetwothree_outlined),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Text((room?['roomname'] ?? "Nill")),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )),
          ),
        ]),
        drawer: studDrawer(),
      ),
    );
  }
}
