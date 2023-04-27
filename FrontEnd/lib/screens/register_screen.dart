// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mainproject/admin/screens/lecture/lectureadd_screen.dart';
import 'package:mainproject/screens/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:mainproject/services/register_service.dart';

class MyRegister extends StatefulWidget {
  const MyRegister(
      {Key? key,
      this.idnum = "",
      this.fname = "",
      this.sname = "",
      this.utype = ""})
      : super(key: key);
  final String idnum;
  final String fname;
  final String sname;
  final String utype;

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

final _formkey = GlobalKey<FormState>();
String username = "", password = "";

class _MyRegisterState extends State<MyRegister> {
  Registercheckservice regchecker = Registercheckservice();
  String? firstname, identity, secondname, usertype;
  void initState() {
    setState(() {
      identity = widget.idnum;
      firstname = widget.fname;
      secondname = widget.sname;
      usertype = widget.utype;
    });
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
                onPressed: () {
                  if (content == "SuccessFully Registered,Please Login") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyLogin()));
                  } else
                    Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<void> register() async {
    if (_formkey.currentState!.validate()) {
      var user = jsonEncode({
        "identity": identity,
        "username": username,
        "password": password,
      });
      try {
        if (usertype == "Admin") {
          final Response? res = await regchecker.registeradmin(user);
          showError("SuccessFully Registered,Please Login", "Admin Account");
        } else if (usertype == "Teacher") {
          final Response? res = await regchecker.registerteacher(user);
          showError("SuccessFully Registered,Please Login", "Teacher Account");
        } else if (usertype == "Student") {
          final Response? res = await regchecker.registerstudent(user);
          showError("SuccessFully Registered,Please Login", "Student Account");
        }
      } on DioError catch (err) {
        if (err.response != null) {
          if (err.response!.statusCode == 404) {
            showError("User Name Allready Exist", "Try Another Username!");
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
            image: AssetImage('images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    'hello,',
                    style: TextStyle(color: Colors.white, fontSize: 33),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    firstname.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 33),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  // Text(
                  //   secondname.toString(),
                  //   style: TextStyle(color: Colors.white, fontSize: 25),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 35, top: 65),
              child: Text(
                'Create Account',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  labelText: "User Name",
                                  hintText: "Enter Your Username",
                                  hintStyle: TextStyle(color: Colors.white),
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
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  labelText: "Password",
                                  hintText: "Enter Your Password",
                                  hintStyle: TextStyle(color: Colors.white),
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
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: register,
                                      icon: Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Navigator.pushNamed(context, "/login");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MyLogin()));
                                  },
                                  // ignore: sort_child_properties_last
                                  child: Text(
                                    'Sign In',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                  style: ButtonStyle(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
