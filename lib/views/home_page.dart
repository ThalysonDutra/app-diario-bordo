import 'package:appdiario/controllers/homeController.dart';
import 'package:appdiario/controllers/taskController.dart';
import 'package:appdiario/utils/alertWidget.dart';
import 'package:appdiario/utils/dialogWidget.dart';
import 'package:appdiario/utils/sideMenuWidget.dart';
import 'package:appdiario/utils/userData.dart';
import 'package:appdiario/views/new_task_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

ScrollController _scrollViewController;
String _searchText = "";
Widget _title = Text(
  "Diário de Bordo",
  style: TextStyle(color: Colors.white),
);
Icon _searchIcon = new Icon(Icons.search);
Icon _filterIcon = new Icon(
  Icons.filter_list,
  size: 16.0,
);
bool pend_filter = false;
final f = new DateFormat('dd/MM/yyyy HH:mm');

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SideMenuWidget(context),
      ),
      body: new NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
                title: Text(
                  "Diário de Bordo",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Color.fromRGBO(0, 99, 170, 1),
                centerTitle: true,
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: ListView.builder(
                  itemCount: HomeController.instance.tasks.length,
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  itemBuilder: _buildList)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => NewTask()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(0, 99, 170, 1),
        tooltip: 'Nova Atividade',
      ),
    );
  }

  Widget _buildList(context, index) {
    return Dismissible(
      key: Key(DateTime
          .now()
          .millisecondsSinceEpoch
          .toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: Container(
        margin: const EdgeInsets.only(
            left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
        child: new Material(
          borderRadius: new BorderRadius.circular(10.0),
          elevation: 2.0,
          child: new Container(
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(10.0),
                color: Colors.white),
            height: 80.0,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  child: Container(
                    width: 5.0,
                    height: 80,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: HomeController.instance.tasks[index]
                                        ['status'] ==
                                    0
                                ? [Colors.blueGrey, Colors.grey]
                                : HomeController.instance.tasks[index]
                                            ['status'] ==
                                        1
                                    ? [Colors.greenAccent, Colors.green]
                                    : [Colors.red, Colors.redAccent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            tileMode: TileMode.clamp)),
                  ),
                  padding: EdgeInsets.all(9.0),
                ),
                getColumText(HomeController.instance.tasks[index]['title'],
                    HomeController.instance.tasks[index]['data']),
               Padding(
                 padding: EdgeInsets.all(18.0),
                 child:  CircleAvatar(
                   backgroundColor: Color.fromRGBO(0, 109, 197, 1),
                   child: IconButton(
                     icon: ValueListenableBuilder(
                       valueListenable: HomeController.instance.status,
                       builder: (context, value, child) {
                         return Text(
                             value[index] == "DIÁRIO" ? "D" : value[index]=="SEMANAL"?"S":value[index]=="MENSAL"?"M":"A", style: TextStyle(color: Colors.white),);
                       },
                     ),
                     onPressed: (){

                     },
                   ),
                 ),
               )
              ],
            ),
          ),
        ),
      ),
      confirmDismiss: (DismissDirection direction) async {
        final bool res = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Atenção"),
              content: const Text("Deseja remover esta atividade?"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () async {
                      Dialogs.showLoadingDialog(context, HomeController.instance.keyLoader, "Removendo...");
                      int code = await TaskController.instance.deleteTask(HomeController.instance.tasks[index]['_id']);
                      Navigator.of(context).pop(true);
                      Navigator.of(context).pop(true);
                      if(code==204){
                        setState(() {
                          HomeController.instance.tasks.removeAt(index);
                        });
                      }
                      else{
                        TemporaryDialog(context,"Erro ao deletar atividade.");
                      }
                    },
                    child: const Text("Sim")),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancelar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget getColumText(String title, date) {
    return new Expanded(
        child: new Container(
      margin: new EdgeInsets.all(10.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            child: _getTitleWidget(title),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            child: _getDateWidget(date),
          )
        ],
      ),
    ));
  }

  Widget _getTitleWidget(String title) {
    return Row(children: <Widget>[
      new Flexible(
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: new TextStyle(
              fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      )
    ]);
  }

  Widget _getDateWidget(String date) {
    return Row(
      children: <Widget>[
        Text(
          'Data: ',
          style: new TextStyle(color: Colors.black, fontSize: 15.0),
        ),
        new Text(
          f.format(DateTime.parse(date)),
          style: new TextStyle(color: Colors.black, fontSize: 15.0),
        ),
      ],
    );
  }
}
