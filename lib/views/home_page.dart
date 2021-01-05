import 'package:appdiario/utils/sideMenuWidget.dart';
import 'package:appdiario/utils/userData.dart';
import 'package:appdiario/views/new_task_page.dart';
import 'package:flutter/material.dart';

ScrollController _scrollViewController;
String _searchText = "";
Widget _title = Text("Diário de Bordo", style: TextStyle(color: Colors.white),);
Icon _searchIcon = new Icon(Icons.search);
Icon _filterIcon = new Icon(Icons.filter_list, size: 16.0,);
bool pend_filter =false;

final TextEditingController _filter = new TextEditingController();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  _HomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          print(_filter.text);
          _searchText = _filter.text;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SideMenuWidget(context),
      ),
     body: new NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                title:  Text("Diário de Bordo", style: TextStyle(color:Colors.white),),
                backgroundColor: Color.fromRGBO(0, 99, 170, 1),
                centerTitle: true,
                pinned: true,
                floating: true,
                actions: <Widget>[
                  IconButton(
                    icon: _filterIcon,
                    onPressed: (){
                      setState(() {
                        _filterIcon = pend_filter ? Icon(Icons.filter_list, size: 16.0,):Icon(Icons.backspace, size: 19.0,);
                        pend_filter = !pend_filter;
                      });
                    },

                  ),
                  IconButton(
                    icon: _searchIcon,
                    onPressed: () {
                      setState(() {
                        if (_searchIcon.icon == Icons.search) {
                          _searchIcon = Icon(Icons.close);
                          _title = new TextField(
                            controller: _filter,
                            style: TextStyle(color: Colors.white),
                            decoration: new InputDecoration(
                              prefixIcon: new Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else {
                          _searchIcon = new Icon(Icons.search);
                          _title = new Text('Atividades');
                          _filter.clear();
                        }
                      });
                    },
                  ),
                ],
                forceElevated: innerBoxIsScrolled
              ),
            ];
          },
          body:Container(
            child: Text(UserData().name),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => NewTask()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(0, 99, 170, 1),
        tooltip: 'Nova Atividade',
      ),
    );
  }
}
