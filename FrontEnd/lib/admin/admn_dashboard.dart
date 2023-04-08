// ignore_for_file: camel_case_types, duplicate_ignore, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_new, use_build_context_synchronously, unnecessary_this

import 'package:flutter/material.dart';
import 'package:mainproject/admin/assets/drawer.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:mainproject/services/getuser_service.dart';

class admnHome extends StatefulWidget {
  const admnHome({super.key});

  @override
  State<admnHome> createState() => _admnHomeState();
}

// ignore: camel_case_types
class _admnHomeState extends State<admnHome> {
  final storage = new FlutterSecureStorage();
  String? jwt;
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
      firstname = allValues["sname"];
      firstname = allValues["utype"];
    });
    await storage.write(key: "userid", value: userId);
    getadmin();
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
            Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('https://picsum.photos/200'),
                                  radius: 20,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text('John Doe',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('10 mins ago',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.more_horiz),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consequat velit ut leo sollicitudin, vel viverra augue porttitor. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('https://picsum.photos/200'),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('https://picsum.photos/200'),
                                  radius: 20,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text('John Doe',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('10 mins ago',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.more_horiz),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consequat velit ut leo sollicitudin, vel viverra augue porttitor. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('https://picsum.photos/200'),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('https://picsum.photos/200'),
                                  radius: 20,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text('John Doe',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('10 mins ago',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.more_horiz),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consequat velit ut leo sollicitudin, vel viverra augue porttitor. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('https://picsum.photos/200'),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('https://picsum.photos/200'),
                                  radius: 20,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text('John Doe',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('10 mins ago',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.more_horiz),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consequat velit ut leo sollicitudin, vel viverra augue porttitor. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('https://picsum.photos/200'),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('https://picsum.photos/200'),
                                  radius: 20,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text('John Doe',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('10 mins ago',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.more_horiz),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consequat velit ut leo sollicitudin, vel viverra augue porttitor. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('https://picsum.photos/200'),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        drawer: cldrawer(),
      ),
    );
  }
}
