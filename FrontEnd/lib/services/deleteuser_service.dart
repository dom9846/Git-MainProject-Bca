//registeration service
// ignore_for_file: prefer_interpolation_to_compose_strings

// import 'dart:html';

import 'package:dio/dio.dart';

class deleteuserservice {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";

  deletelecture(String user) async {
    final response = await dio.post(url + "deletelecture", data: user);
    return response;
  }

  deletestudent(String user) async {
    print(user);
    final response = await dio.post(url + "deletestudent", data: user);
    return response;
  }
}
