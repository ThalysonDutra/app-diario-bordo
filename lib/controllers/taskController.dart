import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:appdiario/utils/userData.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TaskController {
  static final TaskController instance = TaskController._();

  TaskController._();

  final String URL_API = "https://api-diario-de-bordo.herokuapp.com";
  final GlobalKey<State> keyLoader = new GlobalKey<State>();
  final taskformkey = GlobalKey<FormState>();


  Future<int> createTask(Map<String, dynamic> data) async{
    var answ;
    int code = 0;
    try {
      await http
          .post("${URL_API}/tasks/",
          headers: {
            "Content-Type": "application/json"
          },
          body: json.encode(data))
          .timeout(Duration(seconds: 10))
          .then((response) {
        code = response.statusCode;
        answ = response.body;
      });
    } on TimeoutException catch (_) {
      print("time out");
      return 0;
    }

    return code;
  }

  Future<int> deleteTask(String id)async{
    var answ = await http.delete("${URL_API}/tasks/id/$id", headers: {
      "Content-Type": "application/json",
    });

    print(answ.statusCode);

    return answ.statusCode;

  }
}