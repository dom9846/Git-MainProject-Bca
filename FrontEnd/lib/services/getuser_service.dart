//registeration service
// ignore_for_file: prefer_interpolation_to_compose_strings

// import 'dart:html';

import 'package:dio/dio.dart';

class getuserservice {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";

  getadmin(String user) async {
    final response = await dio.post(url + "getadmin", data: user);
    return response;
  }

  getstudent(String user) async {
    final response = await dio.post(url + "getstudent", data: user);
    return response;
  }

  getteacher(String user) async {
    final response = await dio.post(url + "getteacher", data: user);
    return response;
  }

  getlecturesall(String user) async {
    final response = await dio.post(url + "getlectures", data: user);
    return response;
  }

  getstudentssall(String user) async {
    print(user);
    final response = await dio.post(url + "getstudents", data: user);
    return response;
  }
}
