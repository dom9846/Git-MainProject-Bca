// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dio/dio.dart';

class ratingService {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";

  ratestudents(String timetable) async {
    final response = await dio.post(url + "ratestudent", data: timetable);
    return response;
  }

  rateteacher(String rate) async {
    final response = await dio.post(url + "rateteacher", data: rate);
    return response;
  }

  assignratetask(String assigntask) async {
    final response =
        await dio.post(url + "assignrateteacher", data: assigntask);
    return response;
  }

  retrieveassignedtasks(String user) async {
    print(user);
    final response = await dio.post(url + "retrieveratetask", data: user);
    return response;
  }

  retrieveratetaskbyyear(String yearofstud) async {
    print(yearofstud);
    final response =
        await dio.post(url + "retrieveratetaskbyyear", data: yearofstud);
    return response;
  }

  retrieverates(String rate) async {
    // print(yearofstud);
    final response = await dio.post(url + "retrieveratings", data: rate);
    return response;
  }

  retrieveratesstud(String user) async {
    // print(yearofstud);
    final response = await dio.post(url + "retrieveratingsofstud", data: user);
    return response;
  }
}
