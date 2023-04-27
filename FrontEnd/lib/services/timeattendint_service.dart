//registeration service
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dio/dio.dart';

class timeattendintservice {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";

  timetable(String timetable) async {
    final response = await dio.post(url + "timetableupdate", data: timetable);
    return response;
  }

  retrievetimetable(String tt) async {
    final response = await dio.post(url + "gettimetables", data: tt);
    return response;
  }

  putattendance(String attendance) async {
    final response = await dio.post(url + "attendancemark", data: attendance);
    return response;
  }

  deleteattendance(String sem) async {
    final response = await dio.post(url + "deleteattendance", data: sem);
    return response;
  }

  getstudattendances(String user) async {
    // print(user);
    final response = await dio.post(url + "getstudattendances", data: user);
    // print(response);
    return response;
  }

  getallattendances(String sem) async {
    // print(sem);
    final response = await dio.post(url + "getallattendances", data: sem);
    // print(response);
    return response;
  }

  putinternal(String internalmark) async {
    final response =
        await dio.post(url + "putinternalmark", data: internalmark);
    return response;
  }

  getinternal(String internalmark) async {
    final response =
        await dio.post(url + "getinternalmark", data: internalmark);
    return response;
  }

  // subjectassign(String subject) async {
  //   final response = await dio.post(url + "subjectadd", data: subject);
  //   return response;
  // }
}
