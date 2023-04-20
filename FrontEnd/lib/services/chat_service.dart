//registeration service
// ignore_for_file: prefer_interpolation_to_compose_strings

// import 'dart:html';

import 'package:dio/dio.dart';

class chatService {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";

  addchat(String info) async {
    final response = await dio.post(url + "getadmin", data: info);
    return response;
  }
}
