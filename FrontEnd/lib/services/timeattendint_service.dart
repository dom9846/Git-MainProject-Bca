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

  // subjectassign(String subject) async {
  //   final response = await dio.post(url + "subjectadd", data: subject);
  //   return response;
  // }
}
