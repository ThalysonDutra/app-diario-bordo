import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:appdiario/utils/userData.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class LoginController {
  static final LoginController instance = LoginController._();

  LoginController._();

  final loginformkey = GlobalKey<FormState>();
  final signupformkey = GlobalKey<FormState>();
  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  final String URL_API = "https://api-diario-de-bordo.herokuapp.com";

  Future<int> login(String email, String password) async {
    Map<String, dynamic> data = Map();
    data["email"] = email;
    data["password"] = password;
    var answ;
    int code = 0;

    print("${URL_API}/users/login");
    print(data.toString());
    try {
      await http
          .post("${URL_API}/users/login",
          headers: {
            "Content-Type": "application/json"
          },
          body: json.encode(data))
          .timeout(Duration(seconds: 10))
          .then((response) {
        code = response.statusCode;
        answ = response.body;

        UserData().name = jsonDecode(answ)['name'];
        UserData().id = jsonDecode(answ)['_id'];
        UserData().email = jsonDecode(answ)['email'];

      });
    } on TimeoutException catch (_) {
      print("time out");
      return 0;
    } on SocketException catch (error) {
      return 0;
    }

    return code;
  }

  Future<int> signUp(Map<String, dynamic> data) async{
    var answ;
    int code = 0;
    try {
      await http
          .post("${URL_API}/users/",
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

}