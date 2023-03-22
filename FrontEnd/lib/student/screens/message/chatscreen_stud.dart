// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:mainproject/student/assets/drawer.dart';

class ChatScreen_Stud extends StatefulWidget {
  const ChatScreen_Stud({super.key});

  @override
  State<ChatScreen_Stud> createState() => _ChatScreen_StudState();
}

class _ChatScreen_StudState extends State<ChatScreen_Stud> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final _formkey = GlobalKey<FormState>();
  String? message = "";

  // List<String> _messages = [];
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
            "Messages",
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
        body: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  // controller: _scrollController,
                  // itemCount: _messages.length,
                  // itemBuilder: (BuildContext context, int index) {
                  //   return Text(_messages[index]);
                  // },
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            constraints: BoxConstraints(
                              minWidth: 100,
                              maxWidth: 350,
                              minHeight: 30,
                              maxHeight: 800,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Hello,How Are You?",
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            constraints: BoxConstraints(
                              minWidth: 100,
                              maxWidth: 350,
                              minHeight: 30,
                              maxHeight: 800,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Hai,I am Fine",
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formkey,
                child: Row(
                  children: [
                    SizedBox(
                      width: 280,
                      child: TextFormField(
                        controller: _textController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
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
                            hintText: "Type Your Message",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 12, 12, 12)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onFieldSubmitted: (String value) {
                          // setState(() {
                          //   _messages.add(value);
                          // });
                          _textController.clear();
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This Field Cannot Be Empty";
                          } else {
                            setState(() {
                              message = value;
                            });
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(fixedSize: Size(50, 40)),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            print(message);
                            // print(usertype);
                          }
                        },
                        child: Text("Send"))
                  ],
                ),
              ),
            ],
          ),
        ),
        drawer: studDrawer(),
      ),
    );
  }
}
