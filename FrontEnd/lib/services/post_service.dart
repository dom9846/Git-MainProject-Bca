//registeration service
// ignore_for_file: prefer_interpolation_to_compose_strings

// import 'dart:html';

import 'package:dio/dio.dart';

class PostService {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";

  newpost(String user) async {
    final response = await dio.post(url + "addnewpost", data: user);
    return response;
  }

  managepost(String user) async {
    final response = await dio.post(url + "getposts", data: user);
    return response;
  }

  getposts(String user) async {
    final response = await dio.post(url + "retrieveposts", data: user);
    return response;
  }

  deletepost(String post) async {
    final response = await dio.post(url + "deleteposts", data: post);
    return response;
  }
}
