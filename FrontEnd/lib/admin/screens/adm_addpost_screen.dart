// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, duplicate_ignore, unused_local_variable
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mainproject/admin/assets/drawer.dart';
import 'package:file_picker/file_picker.dart';

class Admin_Add_Post extends StatefulWidget {
  const Admin_Add_Post({super.key});

  @override
  State<Admin_Add_Post> createState() => _Admin_Add_PostState();
}

final _formkey = GlobalKey<FormState>();
String content = "";

class _Admin_Add_PostState extends State<Admin_Add_Post> {
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
                    // ignore: prefer_const_constructors
                    icon: Icon(Icons.message_sharp)))
          ],
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 105, top: 60),
              child: Text(
                'Add New Post',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 250,
                        width: 350,
                        padding: EdgeInsets.only(
                            top: 50, bottom: 50, left: 20, right: 20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Center(child: Text("image"))),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  final result =
                                      await FilePicker.platform.pickFiles();
                                  if (result == null) {
                                    return;
                                  }
                                  final file = result.files.first;
                                  // openFile(file);
                                },
                                child: Text("Upload Media")),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.all(30),
                              child: TextFormField(
                                maxLines: 5,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
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
                                    hintText: "Enter The Content",
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 14, 14, 14)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This Field Cannot Be Empty";
                                  } else {
                                    setState(() {
                                      content = value;
                                    });
                                  }
                                  return null;
                                },
                              ),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(80, 40)),
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    // print(identity);
                                    // print(firstname);
                                    // print(secondname);
                                    Navigator.pushNamed(
                                        context, "/admndashboard");
                                  }
                                },
                                child: Text("Post"))
                          ],
                        )),
                  ],
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
