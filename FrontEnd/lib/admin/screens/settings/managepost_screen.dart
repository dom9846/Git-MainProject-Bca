// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import 'package:timeago/timeago.dart' as timeago;
import '../../../services/post_service.dart';
import '../../assets/drawer.dart';

class Manage_Post extends StatefulWidget {
  const Manage_Post({super.key});

  @override
  State<Manage_Post> createState() => _Manage_PostState();
}

class _Manage_PostState extends State<Manage_Post> {
  final storage = new FlutterSecureStorage();
  String? jwt, userId;
  List? posts;
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    print(userId);
    getposts();
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

  PostService postservice = new PostService();
  Future<void> getposts() async {
    try {
      final Response? res = await postservice.managepost("");
      if (res!.statusCode == 201) {
        setState(() {
          posts = res.data;
        });
      }
      // print(posts);
    } on DioError catch (err) {
      if (err.response != null) {}
    }
  }

  showError(String content, String title, String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text("No"),
                onPressed: () {
                  // if (title == "Registration Successful") {
                  //   // Navigator.pushNamed(context, '/login');
                  // } else
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Yes"),
                onPressed: () {
                  deletepost(id);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  showError2(String content, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text("ok"),
                onPressed: () {
                  if (title == "Click Ok") {
                    Navigator.pushNamed(context, '/admnsettpostmanage');
                  }
                  // Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> deletepost(String id) async {
    try {
      var post = jsonEncode({"_id": id});
      // print(post);
      final Response? res = await postservice.deletepost(post);
      if (res!.statusCode == 201) {
        showError2("Successfully deleted", "Click Ok");
      }
    } on DioError catch (err) {
      if (err.response != null) {
        showError2("Something Went Wrong", "Try Again Later");
      }
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
            "Time Line",
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
        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 600,
              child: SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: posts?.length,
                  itemBuilder: (context, index) {
                    Uint8List? profilepic, postpic;
                    final post = posts?[index];
                    String? id = post?['_id'];
                    final dateTimeString1 = post?['datetime'];
                    final dateTime1 = dateTimeString1 != null
                        ? DateTime.parse(dateTimeString1)
                        : null;
                    final dateString1 = dateTime1 != null
                        ? DateFormat("dd-MM-yyyy").format(dateTime1)
                        : null;
                    final elapsed = dateTime1 != null
                        ? timeago.format(dateTime1)
                        : null; // add this line
                    if (post?['post'] != null) {
                      final decodestring =
                          base64Decode(post?['post']!.split(',').last);
                      postpic = decodestring;
                    } else {
                      postpic = Uint8List(0);
                    }
                    if (post?['userpic'] != null) {
                      final decodestring =
                          base64Decode(post?['userpic']!.split(',').last);
                      profilepic = decodestring;
                    } else {
                      profilepic = Uint8List(0);
                    }
                    return Container(
                        margin: EdgeInsets.all(10),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 33,
                                          child: ClipOval(
                                            child: Image.memory(
                                              profilepic,
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return Container(
                                                  color: Colors.grey,
                                                  child: Icon(
                                                    Icons.person,
                                                    color: Colors.white,
                                                    size: 48.0,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Text(
                                                (post?['userfname'] ?? "Nill") +
                                                    " " +
                                                    (post?['usersname'] ??
                                                        "Nill"),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(height: 5),
                                            Text(elapsed ?? 'N/A',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  (post?['comment'] ?? "Nill"),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: 200,
                                child: Image.memory(
                                  postpic,
                                  fit: BoxFit.cover,
                                  width: 350,
                                  height: 280,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Container(
                                      color: Colors.grey,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 48.0,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      showError(
                                          "Do You Want To Delete This Post?",
                                          "Are You Sure?",
                                          id.toString());
                                    },
                                    icon: Icon(Icons.delete),
                                    label: Text('Remove'),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
        drawer: cldrawer(),
      ),
    );
  }
}
