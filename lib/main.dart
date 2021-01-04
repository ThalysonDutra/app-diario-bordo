import 'package:diariobordoapp/views/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Diário de Bordo',
      theme: Theme.of(context).copyWith(
        primaryColor: Color.fromRGBO(0, 109, 197, 1)
      ),
      home: new LoginPage(),
    );
  }
}