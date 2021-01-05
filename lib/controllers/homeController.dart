import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:appdiario/utils/userData.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomeController {
  static final HomeController instance = HomeController._();

  HomeController._();

  ValueNotifier<List<String>> status = new ValueNotifier([]);
  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  final String URL_API = "https://api-diario-de-bordo.herokuapp.com";
  List tasks = [];

  Future<List> myTasks({DateTime date})async{
    String url = "$URL_API/tasks/${UserData().id}";
    var answer;
    try {
      await http.get(url, headers: {
        "Content-Type": "application/json"
      })
          .timeout(Duration(seconds: 5))
          .then((response) {
        print("code: ${response.statusCode}");
        answer = response;
        print(jsonDecode(answer.body));
      });
    } on TimeoutException catch (_) {
      return [400];
    } on SocketException catch (_) {
      return [400];
    }

    tasks = jsonDecode(answer.body);
    status.value.clear();
    tasks.sort((a, b) => a['data'].compareTo(b['data']));
    tasks.forEach((element) {
      print(element['title']);
      status.value.add(element['frequency']);
    });


    return jsonDecode(answer.body);
  }
}