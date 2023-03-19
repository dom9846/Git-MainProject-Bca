// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import '../../../assets/drawer.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';

class Subject_Add extends StatefulWidget {
  const Subject_Add({super.key});

  @override
  State<Subject_Add> createState() => _Subject_AddState();
}

final _formkey = GlobalKey<FormState>();
String? subjectname, subtype, year, semester;
final List<String> items1 = ['Core', 'External'];
final List<String> items2 = ['1', '2', '3', '4', '5', '6'];

class _Subject_AddState extends State<Subject_Add> {
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
                    icon: Icon(Icons.message_sharp)))
          ],
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 55, top: 60),
              child: Text(
                'Add New Subject',
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
                            TextFormField(
                              keyboardType: TextInputType.name,
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
                                  labelText: "Subject Name",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: "Enter The Subject Name",
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
                                    subjectname = value;
                                  });
                                }
                                return null;
                              },
                            ),
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
                                        'Subject Type',
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
                                value: subtype,
                                onChanged: (value) {
                                  setState(() {
                                    subtype = value as String;
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
                            SizedBox(
                              height: 30,
                            ),
                            // ),
                            // DropdownButtonHideUnderline(
                            //   child: DropdownButton2(
                            //     isExpanded: true,
                            //     hint: Row(
                            //       children: const [
                            //         Icon(
                            //           Icons.list,
                            //           size: 16,
                            //           color: Colors.black,
                            //         ),
                            //         SizedBox(
                            //           width: 4,
                            //         ),
                            //         Expanded(
                            //           child: Text(
                            //             'Year',
                            //             style: TextStyle(
                            //               fontSize: 14,
                            //               color: Colors.black,
                            //             ),
                            //             overflow: TextOverflow.ellipsis,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     items: items2
                            //         .map((item) => DropdownMenuItem<String>(
                            //               value: item,
                            //               child: Text(
                            //                 item,
                            //                 style: const TextStyle(
                            //                   fontSize: 14,
                            //                   fontWeight: FontWeight.bold,
                            //                   color: Colors.black,
                            //                 ),
                            //                 overflow: TextOverflow.ellipsis,
                            //               ),
                            //             ))
                            //         .toList(),
                            //     value: year,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         year = value as String;
                            //       });
                            //     },
                            //     buttonStyleData: ButtonStyleData(
                            //       height: 60,
                            //       width: 300,
                            //       padding: const EdgeInsets.only(
                            //           left: 14, right: 14),
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(14),
                            //         border: Border.all(
                            //           color: Colors.black26,
                            //         ),
                            //         color: Colors.white,
                            //       ),
                            //       elevation: 2,
                            //     ),
                            //     iconStyleData: const IconStyleData(
                            //       icon: Icon(
                            //         Icons.arrow_forward_ios_outlined,
                            //       ),
                            //       iconSize: 14,
                            //       iconEnabledColor: Colors.white,
                            //       iconDisabledColor: Colors.grey,
                            //     ),
                            //     dropdownStyleData: DropdownStyleData(
                            //       maxHeight: 200,
                            //       width: 200,
                            //       padding: null,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(14),
                            //         color: Colors.white,
                            //       ),
                            //       elevation: 8,
                            //       offset: const Offset(-20, 0),
                            //       scrollbarTheme: ScrollbarThemeData(
                            //         radius: const Radius.circular(40),
                            //         thickness:
                            //             MaterialStateProperty.all<double>(6),
                            //         thumbVisibility:
                            //             MaterialStateProperty.all<bool>(true),
                            //       ),
                            //     ),
                            //     menuItemStyleData: const MenuItemStyleData(
                            //       height: 40,
                            //       padding: EdgeInsets.only(left: 14, right: 14),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 30,
                            // ),
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
                                        'Semester',
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
                            SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(80, 40)),
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    print(subjectname);
                                    print(subtype);
                                    print(year);
                                    print(semester);
                                  }
                                },
                                child: Text("Add"))
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
        drawer: cldrawer(),
      ),
    );
  }
}
