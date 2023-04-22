// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mainproject/admin/assets/drawer.dart';
import 'package:mainproject/admin/screens/students/student_screen.dart';

class Studyear_admin extends StatefulWidget {
  const Studyear_admin({super.key});

  @override
  State<Studyear_admin> createState() => _Studyear_adminState();
}

class _Studyear_adminState extends State<Studyear_admin> {
  final storage = new FlutterSecureStorage();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        // ignore: prefer_const_constructors
        image: DecorationImage(
            // ignore: prefer_const_constructors
            image: AssetImage('images/register.png'),
            fit: BoxFit.cover),
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
        body: ListView(children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Center(
                child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                // ignore: prefer_const_constructors
                Text(
                  'Select The Year',
                  // ignore: prefer_const_constructors
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
                    onTap: () => Navigator.pushNamed(context, '/admnstud',
                        arguments: '1'),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(Icons.onetwothree_outlined),
                          SizedBox(width: 16),
                          Text("First Year"),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, '/admnstud',
                        arguments: '2'),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(Icons.onetwothree_outlined),
                          SizedBox(width: 16),
                          Text("Second Year"),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, '/admnstud',
                        arguments: '3'),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(Icons.onetwothree_outlined),
                          SizedBox(width: 16),
                          Text("Third Year"),
                        ],
                      ),
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
