// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mainproject/student/assets/drawer.dart';

class chat_stud extends StatefulWidget {
  @override
  _chat_studState createState() => _chat_studState();
}

class _chat_studState extends State<chat_stud> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  List<String> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Box'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(_messages[index]);
              },
            ),
          ),
          TextFormField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Type a message',
            ),
            onFieldSubmitted: (String value) {
              setState(() {
                _messages.add(value);
              });
              _textController.clear();
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          ),
        ],
      ),
    );
  }
}
