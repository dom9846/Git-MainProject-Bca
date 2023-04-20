// ignore_for_file: camel_case_types, duplicate_ignore, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_new, use_build_context_synchronously, unnecessary_this

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mainproject/admin/assets/drawer.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:mainproject/services/getuser_service.dart';
import 'package:mainproject/services/post_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class admnHome extends StatefulWidget {
  const admnHome({super.key});

  @override
  State<admnHome> createState() => _admnHomeState();
}

// ignore: camel_case_types
class _admnHomeState extends State<admnHome> {
  final storage = new FlutterSecureStorage();
  String? jwt;
  List? posts;
  String? userId = "", firstname = "", secondname = "", usertype = "";
  String? propic = "", email = "", mobile = "", age = "", qualification = "";
  bool isLoggedin = true;
  Future<void> checkAuthentication() async {
    try {
      Map<String, String> allValues = await storage.readAll();
      if (allValues["token"] == "") {
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        Navigator.pushNamed(context, "/login");
      } else {
        this.getToken();
      }
    } catch (e) {}
  }

  Future<void> getToken() async {
    String normalizedSource;
    String userid;
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      jwt = allValues["token"];
    });
    normalizedSource = base64Url.normalize(allValues["token"]!.split(".")[1]);
    userid =
        json.decode(utf8.decode(base64Url.decode(normalizedSource)))["_id"];
    setState(() {
      userId = userid;
      firstname = allValues["fname"];
      secondname = allValues["sname"];
      usertype = allValues["utype"];
    });
    await storage.write(key: "userid", value: userId);
    getadmin();
    getposts();
  }

  getuserservice getadminservice = new getuserservice();
  Future<void> getadmin() async {
    try {
      var user = jsonEncode({
        "id": userId,
      });
      final Response? res = await getadminservice.getadmin(user);
      if (res!.statusCode == 201) {
        setState(() {
          propic = res.data["propic"];
          email = res.data["email"];
          mobile = res.data["mobile"].toString();
          age = res.data["age"].toString();
          qualification = res.data["qualification"];
        });
      }
      print(qualification);
    } on DioError catch (err) {
      if (err.response != null) {
        propic = "Nill";
        email = "Nill";
        mobile = "Nill";
        age = "Nill";
        qualification = "Nill";
      }
    }
  }

  PostService postservice = new PostService();
  Future<void> getposts() async {
    try {
      final Response? res = await postservice.getposts("");
      if (res!.statusCode == 201) {
        setState(() {
          posts = res.data;
        });
      }
      print(posts);
    } on DioError catch (err) {
      if (err.response != null) {}
    }
  }

  // logout() async {
  //   await storage.delete(key: "token");
  //   Navigator.pushNamed(context, "/login");
  //   // Navigator.of(context)
  //   //     .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  // }

  void initState() {
    super.initState();
    this.checkAuthentication();
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
