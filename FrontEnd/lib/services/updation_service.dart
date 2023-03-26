import 'package:dio/dio.dart';

class Updationservice {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";

  updateadmin(String user) async {
    final response = await dio.post(url + "adminupdate", data: user);
    return response;
  }
}
