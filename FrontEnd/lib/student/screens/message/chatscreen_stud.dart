// ignore_for_file: camel_case_types, prefer_const_constructors
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mainproject/services/chat_service.dart';
import 'package:mainproject/student/assets/drawer.dart';

class ChatScreen_Stud extends StatefulWidget {
  const ChatScreen_Stud({super.key});

  @override
  State<ChatScreen_Stud> createState() => _ChatScreen_StudState();
}

class _ChatScreen_StudState extends State<ChatScreen_Stud> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final _formkey = GlobalKey<FormState>();
  String? message = "", chatid;
  String? userId = "", firstname = "", secondname = "", usertype = "", year;
  List? messagebox;
  final storage = new FlutterSecureStorage();
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
      firstname = allValues["fname"];
      secondname = allValues["sname"];
      usertype = allValues["utype"];
    });
  }

  DateTime currentDateTime = DateTime.now();
  chatService chatservice = chatService();
  Future<void> sendstudmessage() async {
    if (_formkey.currentState!.validate()) {
      var msg = jsonEncode({
        "id": chatid,
        "sender": userId,
        "senderfname": firstname,
        "sendersname": secondname,
        "senderutype": usertype,
        "message": message,
        "date": currentDateTime.toIso8601String(),
      });
      print(msg);
      try {
        final Response? res = await chatservice.sendmessage(msg);
        if (res!.statusCode == 201) {}
      } on DioError catch (err) {
        if (err.response != null) {}
      }
    }
  }

  Future<void> getmessages() async {
    if (_formkey.currentState!.validate()) {
      var chid = jsonEncode({"id": chatid});
      print(chid);
      try {
        final Response? res = await chatservice.getmessage(chid);
        if (res!.statusCode == 201) {
          setState(() {
            messagebox = res.data;
          });
        }
        print(messagebox);
      } on DioError catch (err) {
        if (err.response != null) {}
      }
    }
  }

  showError(String content, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {},
              )
            ],
          );
        });
  }

  void initState() {
    super.initState();
    this.getToken();
    this.getmessages();
  }

  @override
  Widget build(BuildContext context) {
    final dynamic sub =
        ModalRoute.of(context as BuildContext)?.settings.arguments;
    chatid = sub['chatid'].toString();
    print(chatid);
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
        // body: _MyBody(key: _bodyKey),
        body: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  // controller: _scrollController,
                  // itemCount: _messages.length,
                  // itemBuilder: (BuildContext context, int index) {
                  //   return Text(_messages[index]);
                  // },
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            constraints: BoxConstraints(
                              minWidth: 100,
                              maxWidth: 350,
                              minHeight: 30,
                              maxHeight: 800,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Hello,How Are You?",
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            constraints: BoxConstraints(
                              minWidth: 100,
                              maxWidth: 350,
                              minHeight: 30,
                              maxHeight: 800,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Hai,I am Fine",
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formkey,
                child: Row(
                  children: [
                    SizedBox(
                      width: 270,
                      child: TextFormField(
                        controller: _textController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
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
                          hintText: "Type Your Message",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 12, 12, 12),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This Field Cannot Be Empty";
                          } else {
                            setState(() {
                              message = value;
                            });
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(fixedSize: Size(50, 40)),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          sendstudmessage();
                          _textController.clear(); // clear the TextFormField
                        }
                      },
                      child: Text("Send"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        drawer: studDrawer(),
      ),
    );
  }
}
