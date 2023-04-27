// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dio/dio.dart';

class chatService {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";

  addchat(String info) async {
    final response = await dio.post(url + "addchatroom", data: info);
    return response;
  }

  getallchatroom(String info) async {
    final response = await dio.post(url + "getallchatroom", data: info);
    return response;
  }

  getstudchatroom(String sem) async {
    print("object");
    print(sem);
    final response = await dio.post(url + "getstudchatroom", data: sem);
    return response;
  }

  sendmessage(String msg) async {
    final response = await dio.post(url + "sendmessage", data: msg);
    return response;
  }

  getmessage(String chid) async {
    final response = await dio.post(url + "getmessage", data: chid);
    return response;
  }

  deletechatroom(String chid) async {
    final response = await dio.post(url + "deletechatroom", data: chid);
    return response;
  }
}
