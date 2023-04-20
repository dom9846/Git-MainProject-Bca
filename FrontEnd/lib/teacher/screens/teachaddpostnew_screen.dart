// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:mainproject/services/getuser_service.dart';
import 'package:mainproject/services/post_service.dart';
import 'package:mainproject/teacher/assets/drawer.dart';

class TeachAddNew_Post extends StatefulWidget {
  const TeachAddNew_Post({super.key});

  @override
  State<TeachAddNew_Post> createState() => _TeachAddNew_PostState();
}

class _TeachAddNew_PostState extends State<TeachAddNew_Post> {
  final _formkey = GlobalKey<FormState>();
  String content = "";
  String email = "", mobile = "", age = "", qualification = "", image = "";
  String? propic = "", fname, sname;
  XFile? _imageFile;
  Uint8List? profilepic;
  DateTime currentDateTime = DateTime.now();
  final storage = new FlutterSecureStorage();
  String? jwt, userId;
  Future<void> getToken() async {
    Map<String, String> allValues = await storage.readAll();
    setState(() {
      userId = allValues["userid"];
    });
    print(userId);
    getteacher();
  }

  getuserservice getteacherservice = new getuserservice();
  Future<void> getteacher() async {
    try {
      var user = jsonEncode({
        "id": userId,
      });
      final Response? res = await getteacherservice.getteacher(user);
      if (res!.statusCode == 201) {
        setState(() {
          propic = res.data["propic"];
          fname = res.data["fname"];
          sname = res.data["sname"];
        });
      }
    } on DioError catch (err) {
      if (err.response != null) {}
    }
  }

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
                  if (title == "Click Ok") {
                    Navigator.pushNamed(context, '/teachdashboard');
                  } else
                    Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  PostService postservice = new PostService();
  Future<void> postupload() async {
    if (_formkey.currentState!.validate()) {
      if (image.length == 0) {
        showError("Select a profile picture", "Cannot Update");
      } else {
        var user = jsonEncode({
          "post": image,
          "comment": content,
          "userid": userId,
          "userpic": propic,
          "userfname": fname,
          "usersname": sname,
          "datetime": currentDateTime.toIso8601String()
        });
        print(user);
        try {
          final Response? res = await postservice.newpost(user);
          if (res!.statusCode == 201) {
            showError("Successfully Added New Post", "Click Ok");
          }
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
                      padding: EdgeInsets.all(20),
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
                      child: Center(
                        child: _imageFile == null
                            ? Text('No image selected.')
                            : Image.file(File(_imageFile!.path),
                                fit: BoxFit.contain),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton.icon(
                        onPressed: () {
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
                        icon: Icon(
                          Icons.arrow_upward,
                          color: Colors.black,
                        ),
                        label: Text(
                          "Upload",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                    postupload();
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
        drawer: teach_Drawer(),
      ),
    );
  }
}
