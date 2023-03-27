import 'package:dio/dio.dart';

class Updationservice {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";

  updateadmin(String user) async {
    final response = await dio.post(url + "adminupdate", data: user);
    return response;
  }

  adminunamepass(String user) async {
    final response = await dio.post(url + "adminupdateunamepass", data: user);
    return response;
  }

  updateteacher(String user) async {
    final response = await dio.post(url + "teacherupdate", data: user);
    return response;
  }

  teacherunamepass(String user) async {
    final response = await dio.post(url + "teacherupdateunamepass", data: user);
    return response;
  }

  updatestudent(String user) async {
    final response = await dio.post(url + "studentupdate", data: user);
    return response;
  }

  studentunamepass(String user) async {
    final response = await dio.post(url + "studentupdateunamepass", data: user);
    return response;
  }
}
