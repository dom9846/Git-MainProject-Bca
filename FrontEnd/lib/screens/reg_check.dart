// ignore: implementation_imports
// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_import, implementation_imports, duplicate_ignore, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mainproject/screens/register_screen.dart';
import 'package:mainproject/services/register_service.dart';
import 'login_screen.dart';

// ignore: camel_case_types
class Reg_Check extends StatefulWidget {
  const Reg_Check({super.key});

  @override
  State<Reg_Check> createState() => _Reg_CheckState();
}

// ignore: camel_case_types
class _Reg_CheckState extends State<Reg_Check> {
  final _formkey = GlobalKey<FormState>();
  String iden = "";
  Registercheckservice regchecker = Registercheckservice();

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
                  if (title == "Please Login") {
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

  Future<void> regcheck() async {
    if (_formkey.currentState!.validate()) {
      var id = jsonEncode({
        "identity": iden,
      });
      // print(id);
      try {
        final Response? res = await regchecker.registercheck(id);
        var identity = res?.data["identity"];
        var userfname = res?.data["firstname"];
        var usersname = res?.data["secondname"];
        var usertype = res?.data["user_type"];
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MyRegister(
                idnum: identity.toString(),
                fname: userfname,
                sname: usersname,
                utype: usertype),
          ),
        );
      } on DioError catch (err) {
        if (err.response != null) {
          if (err.response!.statusCode == 404) {
            showError("You Are Allready Registered", "Please Login");
          } else if (err.response!.statusCode == 401) {
            showError("No Such User Exist", "Registration Failed");
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
            SizedBox(
              height: 150,
            ),
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: Text(
                'Enter The ID or Admission Number',
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
                              keyboardType: TextInputType.number,
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
                                  labelText: "ID/ADMN NUM",
                                  hintText: "Enter Your ID or Admn Number",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This Field Cannot Be Empty";
                                } else {
                                  setState(() {
                                    iden = value;
                                  });
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Submit',
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
                                      onPressed: regcheck,
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
    ;
  }
}
