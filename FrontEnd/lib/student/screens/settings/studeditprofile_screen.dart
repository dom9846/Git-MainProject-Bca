// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mainproject/student/assets/drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mainproject/services/updation_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';

class StudentEdit_Profile extends StatefulWidget {
  const StudentEdit_Profile({super.key});

  @override
  State<StudentEdit_Profile> createState() => _StudentEdit_ProfileState();
}

class _StudentEdit_ProfileState extends State<StudentEdit_Profile> {
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
  String email = "",
      mobile = "",
      age = "",
      parent = "",
      parentcontact = "",
      image="";
  String? year, semester;
  final List<String> items1 = ['1', '2', '3'];
  final List<String> items2 = ['1', '2', '3', '4', '5', '6'];
  Updationservice studupdate = Updationservice();
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
        "parent": parent,
        "parentcontact": parentcontact,
        "year": year,
        "semester": semester,
      });
      print(user);
      try {
        final Response? res = await studupdate.updatestudent(user);
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
                      Navigator.pushNamed(context, "/studaddnewpost");
                    },
                    // ignore: prefer_const_constructors
                    icon: Icon(Icons.add_card_sharp))),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/studmessage");
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //   height: 150,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //   ),
                    //   child: Center(
                    //     child: _imageFile == null
                    //         ? Text('No image selected.')
                    //         : Image.file(File(_imageFile!.path),
                    //             fit: BoxFit.contain),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     showModalBottomSheet(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return SafeArea(
                    //           child: Column(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: <Widget>[
                    //               ListTile(
                    //                 leading: Icon(Icons.camera_alt),
                    //                 title: Text('Take a photo'),
                    //                 onTap: () {
                    //                   _pickImage(ImageSource.camera);
                    //                   Navigator.of(context).pop();
                    //                 },
                    //               ),
                    //               ListTile(
                    //                 leading: Icon(Icons.image),
                    //                 title: Text('Choose from gallery'),
                    //                 onTap: () {
                    //                   _pickImage(ImageSource.gallery);
                    //                   Navigator.of(context).pop();
                    //                 },
                    //               ),
                    //             ],
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   },
                    //   child: Container(child: Icon(Icons.camera)),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  labelText: "Parent name",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: "Enter Your Parent Name",
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
                                    parent = value;
                                  });
                                }
                                return null;
                              },
                            ),
                            // ignore: prefer_const_constructors
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.phone,
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
                                  labelText: "Parent Contact",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: "Enter Your Parent Contact",
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
                                    parentcontact = value;
                                  });
                                }
                                return null;
                              },
                            ),
                            // ignore: prefer_const_constructors
                            SizedBox(
                              height: 30,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    Icon(
                                      Icons.list,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Select Year',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: items1
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: year,
                                onChanged: (value) {
                                  setState(() {
                                    year = value as String;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 60,
                                  width: 300,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: Colors.white,
                                  ),
                                  elevation: 2,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: Colors.white,
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 200,
                                  padding: null,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                  ),
                                  elevation: 8,
                                  offset: const Offset(-20, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness:
                                        MaterialStateProperty.all<double>(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                            // TextFormField(
                            //   style: TextStyle(color: Colors.black),
                            //   keyboardType: TextInputType.number,
                            //   decoration: InputDecoration(
                            //       enabledBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //         borderSide: BorderSide(
                            //           color: Colors.black,
                            //         ),
                            //       ),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //         borderSide: BorderSide(
                            //           color: Color.fromARGB(255, 22, 47, 230),
                            //         ),
                            //       ),
                            //       labelText: "Year",
                            //       labelStyle: TextStyle(color: Colors.black),
                            //       hintText: "Enter Your Year Of Study",
                            //       hintStyle: TextStyle(
                            //           color: Color.fromARGB(255, 12, 12, 12)),
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //       )),
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return "This Field Cannot Be Empty";
                            //     } else {
                            //       setState(() {
                            //         year = value;
                            //       });
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // ignore: prefer_const_constructors
                            SizedBox(
                              height: 30,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    Icon(
                                      Icons.list,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Select Semester',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: items2
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: semester,
                                onChanged: (value) {
                                  setState(() {
                                    semester = value as String;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 60,
                                  width: 300,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: Colors.white,
                                  ),
                                  elevation: 2,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: Colors.white,
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 200,
                                  padding: null,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                  ),
                                  elevation: 8,
                                  offset: const Offset(-20, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness:
                                        MaterialStateProperty.all<double>(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                            // TextFormField(
                            //   style: TextStyle(color: Colors.black),
                            //   keyboardType: TextInputType.number,
                            //   decoration: InputDecoration(
                            //       enabledBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //         // ignore: prefer_const_constructors
                            //         borderSide: BorderSide(
                            //           color: Colors.black,
                            //         ),
                            //       ),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //         borderSide: BorderSide(
                            //           color: Color.fromARGB(255, 22, 47, 230),
                            //         ),
                            //       ),
                            //       labelText: "Semester",
                            //       labelStyle: TextStyle(color: Colors.black),
                            //       hintText: "Enter Your Semester",
                            //       hintStyle: TextStyle(
                            //           color: Color.fromARGB(255, 12, 12, 12)),
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //       )),
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return "This Field Cannot Be Empty";
                            //     } else {
                            //       setState(() {
                            //         semester = value;
                            //       });
                            //     }
                            //     return null;
                            //   },
                            // ),
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
        drawer: studDrawer(),
      ),
    );
  }
}
