// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_print, duplicate_ignore

import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mainproject/services/updation_service.dart';
import 'package:mainproject/teacher/assets/drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TeachEdit_Profile extends StatefulWidget {
  const TeachEdit_Profile({super.key});

  @override
  State<TeachEdit_Profile> createState() => _TeachEdit_ProfileState();
}

class _TeachEdit_ProfileState extends State<TeachEdit_Profile> {
  final storage = new FlutterSecureStorage();
  String? jwt, userId;
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    print(userId);
  }

  void initState() {
    super.initState();
    this.getToken();
  }

  final _formkey = GlobalKey<FormState>();
  String email = "", mobile = "", age = "", qualification = "", image = "";
  Updationservice teacherupdate = Updationservice();
// ignore: unused_element
  XFile? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    List<String>? s = pickedFile?.path.toString().split("/");
    final bytes = await File(pickedFile!.path).readAsBytes();
    final base64 = base64Encode(bytes);

    var pic =
        "data:image/" + s![s.length - 1].split(".")[1] + ";base64," + base64;
    print(pic);
    if (pickedFile != null) {
      setState(() {
        image = pic;
        _imageFile = pickedFile;
      });
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

  Future<void> update() async {
    if (_formkey.currentState!.validate()) {
      var user = jsonEncode({
        "id": userId,
        "propic": image,
        "email": email,
        "mobile": mobile,
        "age": age,
        "qualification": qualification,
      });
      print(user);
      try {
        final Response? res = await teacherupdate.updateteacher(user);
        // if (res!.statusCode == 401) {}
        showError("Successfully Updated Your Profile", "Profile Updated");
      } on DioError catch (err) {
        if (err.response != null) {
          showError("Some Error Occured!", "Oops");
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          showError("Something Went Wrong!", "Cannot Be Done");
        }
      }
    }
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
        // ignore: duplicate_ignore
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          // ignore: prefer_const_constructors
          title: Text(
            "INNOVIS",
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
                      Navigator.pushNamed(context, "/teachaddnewpost");
                    },
                    // ignore: prefer_const_constructors
                    icon: Icon(Icons.add_card_sharp))),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/teachmessage");
                    },
                    icon: Icon(Icons.message_sharp)))
          ],
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 55, top: 60),
              child: Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 50, bottom: 50, left: 20, right: 20),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: _imageFile == null
                                    ? Text('No image selected.')
                                    : Image.file(File(_imageFile!.path),
                                        fit: BoxFit.contain),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SafeArea(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(Icons.camera_alt),
                                            title: Text('Take a photo'),
                                            onTap: () {
                                              _pickImage(ImageSource.camera);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.image),
                                            title: Text('Choose from gallery'),
                                            onTap: () {
                                              _pickImage(ImageSource.gallery);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(child: Icon(Icons.camera)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
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
                                  labelText: "Email",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: "Enter Your Email Id",
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
                                    email = value;
                                  });
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
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
                                  labelText: "Mobile Number",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: "Enter The Mobile Number",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 7, 7, 7)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This Field Cannot Be Empty";
                                } else if (value.length != 10) {
                                  return "Enter a valid mobile number";
                                } else {
                                  setState(() {
                                    mobile = value;
                                  });
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.number,
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
                                  labelText: "Age",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: "Enter The Age",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 12, 12, 12)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This Field Cannot Be Empty";
                                } else if (value.length != 2) {
                                  return "Enter a valid age";
                                } else {
                                  setState(() {
                                    age = value;
                                  });
                                }
                                return null;
                              },
                            ),
                            // ignore: prefer_const_constructors
                            SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.name,
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
                                  labelText: "Qualification",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: "Enter Your Qualification",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 12, 12, 12)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This Field Cannot Be Empty";
                                } else {
                                  setState(() {
                                    qualification = value;
                                  });
                                }
                                return null;
                              },
                            ),
                            // ignore: prefer_const_constructors
                            SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(80, 40)),
                                onPressed: update,
                                child: Text("Edit"))
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
        drawer: teach_Drawer(),
      ),
    );
  }
}
