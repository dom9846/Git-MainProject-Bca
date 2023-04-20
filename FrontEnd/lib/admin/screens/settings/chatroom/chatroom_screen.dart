// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mainproject/admin/assets/drawer.dart';
import 'package:mainproject/services/chat_service.dart';

class Chat_Room_admn extends StatefulWidget {
  const Chat_Room_admn({super.key});

  @override
  State<Chat_Room_admn> createState() => _Chat_Room_admnState();
}

class _Chat_Room_admnState extends State<Chat_Room_admn> {
  String? userId = "", firstname = "", secondname = "", usertype = "";
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
    getrooms();
  }

  chatService chatservice = new chatService();
  Future<void> getrooms() async {
    try {
      final Response? res = await chatservice.getallchatroom("");
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
                    onPressed: () {
                      Navigator.pushNamed(context, "/admnsettaddchatroom");
                    },
                    icon: Icon(Icons.add),
                    label: Text("Create")))
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
                  'Select Chat',
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
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.delete_outlined),
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
        drawer: cldrawer(),
      ),
    );
  }
}
