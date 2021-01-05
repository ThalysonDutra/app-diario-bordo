import 'package:appdiario/utils/alertWidget.dart';
import 'package:appdiario/utils/userData.dart';
import 'package:appdiario/views/login_page.dart';
import 'package:flutter/material.dart';

Widget SideMenuWidget(BuildContext context){
  return Column(
    children: <Widget>[
      Expanded(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("${UserData().name}"),
              accountEmail: Text("${UserData().email}"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                    ? Color.fromRGBO(0, 99, 170, 1)
                    : Colors.white,
                child: Text(
                  "${UserData().name.substring(0,1).toUpperCase()}",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Dia'),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Semana'),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Mês'),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Sobre'),
              onTap: (){
                TemporaryDialog(context, "Diário de Bordo\nVersão 1.0.0\nAPI Versão 1.0.0");
              },
            ),
          ],
        ),
      ),
      Container(
        // This align moves the children to the bottom
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              // This container holds all the children that will be aligned
              // on the bottom and should not scroll with the above ListView
              child: Container(
                  child: Column(
                    children: <Widget>[
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.exit_to_app),
                        title: Text('Sair'),
                        onTap: (){
                          UserData().name="";
                          UserData().id = "";
                          UserData().email= "";
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                                  (Route<dynamic> route) => false);
                        },
                      )
                    ],
                  )
              )
          )
      )
    ],
  );
}