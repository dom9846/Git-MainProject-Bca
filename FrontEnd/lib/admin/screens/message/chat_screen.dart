// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mainproject/admin/assets/drawer.dart';
import 'package:mainproject/services/chat_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class Chat_Screen_admn extends StatefulWidget {
  const Chat_Screen_admn({super.key});

  @override
  State<Chat_Screen_admn> createState() => _Chat_Screen_admnState();
}

class _Chat_Screen_admnState extends State<Chat_Screen_admn> {
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
    getmessages();
  }

  // final storage = new FlutterSecureStorage();
  bool isLoggedin = true;
  Future<void> checkAuthentication() async {
    try {
      Map<String, String> allValues = await storage.readAll();
      if (allValues["token"] == "") {
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        Navigator.pushNamed(context, "/login");
      } else {
        // this.getToken();
      }
    } catch (e) {}
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
        "date": currentDateTime.toIso8601String().toString(),
      });
      try {
        final Response? res = await chatservice.sendmessage(msg);
        if (res!.statusCode == 201) {
          // setState(() {
          //   messagebox!.add(msg);
          // });
        }
        getmessages();
      } on DioError catch (err) {
        if (err.response != null) {}
      }
    }
  }

  Future<void> getmessages() async {
    try {
      var chid = jsonEncode({"id": chatid});
      final Response? res = await chatservice.getmessage(chid);
      if (res!.statusCode == 201) {
        setState(() {
          messagebox = res.data;
        });
      }
      // print(messagebox);
    } on DioError catch (err) {
      if (err.response != null) {}
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

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void initState() {
    super.initState();
    this.getToken();
  }

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();
    final dynamic sub =
        ModalRoute.of(context as BuildContext)?.settings.arguments;
    chatid = sub['chatid'].toString();

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
        body: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 500,
                      child: ListView.builder(
                        // controller: _scrollController,
                        itemCount: messagebox?.length,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          final msg = messagebox?[index];
                          final dateTimeString1 = msg?['date'];
                          final dateTime1 = dateTimeString1 != null
                              ? DateTime.parse(dateTimeString1)
                              : null;
                          final dateString1 = dateTime1 != null
                              ? DateFormat("dd-MM-yyyy").format(dateTime1)
                              : null;
                          final elapsed = dateTime1 != null
                              ? timeago.format(dateTime1)
                              : null;
                          print('msg?["sender"]: ${msg?["sender"]}');
                          print('userId: $userId');
                          final isCurrentUser = msg?['sender'] == userId;
                          return Expanded(
                            child: Row(
                              mainAxisAlignment: isCurrentUser
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          color: isCurrentUser
                                              ? Colors.green
                                              : Colors.grey),
                                    ),
                                    color: isCurrentUser
                                        ? Colors.green
                                        : Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (msg?['senderfname'] ?? '') +
                                                "" +
                                                (msg?['sendersname'] ?? ''),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: isCurrentUser
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            msg?['message'] ?? '',
                                            style: TextStyle(
                                              color: isCurrentUser
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            elapsed ?? 'N/A',
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: isCurrentUser
                                                  ? Colors.white
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
                          _textController.clear();
                          _scrollToBottom(); // clear the TextFormField
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
        drawer: cldrawer(),
      ),
    );
  }
}
