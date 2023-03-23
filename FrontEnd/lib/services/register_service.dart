//registeration service
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dio/dio.dart';

class Registercheckservice {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";

  addteacher(String user) async {
    final response = await dio.post(url + "register", data: user);
    return response;
  }

  addstudent(String user) async {
    final response = await dio.post(url + "register", data: user);
    return response;
  }

  registercheck(String id) async {
    final response = await dio.post(url + "logincheck", data: id);
    return response;
  }

  registeradmin(String user) async {
    final response = await dio.post(url + "adminregister", data: user);
    return response;
  }

  registerteacher(String user) async {
    final response = await dio.post(url + "teacherregister", data: user);
    return response;
  }

  registerstudent(String user) async {
    final response = await dio.post(url + "studentregister", data: user);
    return response;
  }

  login(String user) async {
    final response = await dio.post(url + "login", data: user);
    return response;
  }
}
