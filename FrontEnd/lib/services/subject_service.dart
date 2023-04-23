//registeration service
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dio/dio.dart';

class subjectservice {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";

  subjectadd(String subject) async {
    final response = await dio.post(url + "subjectadd", data: subject);
    return response;
  }

  subjectretrieve(String subject) async {
    // print(subject);
    final response = await dio.post(url + "subassretrieve", data: subject);
    // print(response);
    return response;
  }

  lectureretrieve(String lectures) async {
    // print(lectures);
    final response = await dio.post(url + "lectureretrieve", data: lectures);
    return response;
  }

  subjectassign(String subject) async {
    final response = await dio.post(url + "subjectassign", data: subject);
    return response;
  }

  retrievesubject(String subwork) async {
    final response = await dio.post(url + "retrievesubject", data: subwork);
    return response;
  }

  showsubdetails(String subject) async {
    // print(subject);
    final response = await dio.post(url + "showsubjectdetails", data: subject);
    // print(response);
    return response;
  }

  retrieveassignedsubjects(String subject) async {
    final response =
        await dio.post(url + "retrieveassignedsubjects", data: subject);
    return response;
  }

  assignsubwork(String subwork) async {
    final response = await dio.post(url + "assignsubjectwork", data: subwork);
    return response;
  }

  retrievesubwork(String subwork) async {
    final response = await dio.post(url + "retrievesubjectwork", data: subwork);
    return response;
  }

  retrievesubworksemways(String subwork) async {
    final response =
        await dio.post(url + "retrievesubjectworksemways", data: subwork);
    return response;
  }

  submitsubwork(String subwork) async {
    final response = await dio.post(url + "submitsubjectwork", data: subwork);
    return response;
  }

  retrievesubmittedwork(String work) async {
    final response = await dio.post(url + "retrievesubmittedwork", data: work);
    return response;
  }
}
