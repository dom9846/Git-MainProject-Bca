// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mainproject/admin/admn_dashboard.dart';
import 'package:dio/dio.dart';
import 'package:mainproject/screens/reg_check.dart';
import 'package:mainproject/services/register_service.dart';
import 'package:mainproject/student/student_dashboard.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mainproject/teacher/teacher_dashboard.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({
    Key? key,
  }) : super(key: key);
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _formkey = GlobalKey<FormState>();
  String username = "", password = "";
  Registercheckservice regchecker = Registercheckservice();
  final storage = new FlutterSecureStorage();

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
                onPressed: () {
                  // if (title == "Registration Successful") {
                  //   // Navigator.pushNamed(context, '/login');
                  // } else
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<void> loginaccount() async {
    if (_formkey.currentState!.validate()) {
      var user = jsonEncode({
        "username": username,
        "password": password,
      });
      try {
        final Response? res = await regchecker.login(user);
        if (res!.statusCode == 201) {
          await storage.write(key: "token", value: res.data["token"]);
          Map<String, String> allValues = await storage.readAll();
          var user = res.data["user"];
          var user_type = user["user_type"];
          if (user_type == "Admin") {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => admnHome(),
              ),
            );
          } else if (user_type == "Teacher") {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => teach_Home(),
              ),
            );
          } else if (user_type == "Student") {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => student_Dashboard(),
              ),
            );
          }
        }
      } on DioError catch (err) {
        if (err.response != null) {
          if (err.response!.statusCode == 404) {
            showError("Invalid username and Password", "Login Failed");
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  labelText: "Username",
                                  hintText: "Enter Your User Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This Field Cannot Be Empty";
                                } else {
                                  setState(() {
                                    username = value;
                                  });
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              style: TextStyle(),
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  labelText: "Password",
                                  hintText: "Enter Your Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This Field Cannot Be Empty";
                                } else {
                                  setState(() {
                                    password = value;
                                  });
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: loginaccount,
                                      icon: Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Reg_Check(),
                                      ),
                                    );
                                  },
                                  // ignore: sort_child_properties_last
                                  child: Text(
                                    'Sign Up',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18),
                                  ),
                                  style: ButtonStyle(),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
