import 'package:appdiario/controllers/taskController.dart';
import 'package:appdiario/utils/datePicker.dart';
import 'package:appdiario/utils/dialogWidget.dart';
import 'package:appdiario/utils/optionalalertWidget.dart';
import 'package:appdiario/utils/temporaryWidget.dart';
import 'package:appdiario/utils/userData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

TextEditingController titleController = new TextEditingController();
TextEditingController frequencyController = new TextEditingController();
TextEditingController durationController = new TextEditingController();
TextEditingController descriptionController = new TextEditingController();
TextEditingController dateController = new TextEditingController();
TextEditingController deadlineController = new TextEditingController();

List<String> _frequencyOptions = ['DIÁRIO', 'SEMANAL', 'MENSAL', 'ANUAL']; // Option 2
String _frequency;

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {

  @override
  void initState() {
    _frequency = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:(){},
        child: Scaffold(
            appBar: AppBar(
              title: Text("Nova Atividade", style: TextStyle(fontFamily: 'Caecilia', color: Colors.white),),
              backgroundColor: Color.fromRGBO(0, 99, 170, 1),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  OptionalAlertDialog(context, "Deseja cancelar a criação da Atividade?",
                      backAction);
                },
              ),
            ),
            body:SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Color.fromRGBO(90, 171, 236, 1),
                child: Form(
                  key: TaskController.instance.taskformkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25.0),
                        child: new Image(
                            width: 182.0,
                            height: 145.0,
                            fit: BoxFit.fill,
                            image: new AssetImage('assets/Logo.png')),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 5.0),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              controller: titleController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Digite um título válido.";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.chat,
                                  color: Colors.grey,
                                  size: 22.0,
                                ),
                                hintText: "Título",
                                contentPadding: EdgeInsets.fromLTRB(10.0,0,0,0),
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 17.0, color: Colors.grey),
                              ),
                            ),
                          )
                        )
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 5.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child:  DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                        Icons.cached,
                                        color: Colors.grey,
                                        size: 22.0,
                                      ),
                                      hintText: "Definir Frequência",
                                      contentPadding: EdgeInsets.fromLTRB(10.0,0,0,0),
                                      hintStyle: TextStyle(
                                          fontFamily: "WorkSansSemiBold",
                                          fontSize: 17.0, color: Colors.grey),
                                    ),
                                    value: _frequency,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _frequency = newValue;
                                      });
                                    },
                                    items: _frequencyOptions.map((frequency) {
                                      return DropdownMenuItem(
                                        child: new Text(frequency),
                                        value: frequency,
                                      );
                                    }).toList(),
                                )
                              )
                          )
                      ),

                      Padding(
                          padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 5.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: DatePick(dateController, "Data Prevista"),
                              )
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(40.0, 15.0, 40.0, 5.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: TextFormField(
                                  controller: durationController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Digite um título válido.";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.timer,
                                      color: Colors.grey,
                                      size: 22.0,
                                    ),
                                    hintText: "Duração (em horas)",
                                    contentPadding: EdgeInsets.fromLTRB(10.0,0,0,0),
                                    hintStyle: TextStyle(
                                        fontFamily: "WorkSansSemiBold",
                                        fontSize: 17.0, color: Colors.grey),
                                  ),
                                ),
                              )
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 5.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child:  DatePick(deadlineController, "Prazo"),
                              )
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 5.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: TextFormField(
                                  controller: descriptionController,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Digite um título válido.";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.chat,
                                      color: Colors.grey,
                                      size: 22.0,
                                    ),
                                    hintText: "Descrição",
                                    contentPadding: EdgeInsets.fromLTRB(10.0,0,0,0),
                                    hintStyle: TextStyle(
                                        fontFamily: "WorkSansSemiBold",
                                        fontSize: 17.0, color: Colors.grey),
                                  ),
                                ),
                              )
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 5.0),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: RaisedButton(
                                  color: Color.fromRGBO(0, 109, 197, 1),
                                    splashColor: Color.fromRGBO(0, 109, 197, 1),
                                    onPressed: () async {
                                      if (TaskController.instance.taskformkey
                                          .currentState.validate()) {
                                        Map<String, dynamic> data = Map();
                                        data['title'] = titleController.text;
                                        data['data'] = dateController.text;
                                        data['description'] =
                                            descriptionController.text;
                                        data['duration'] = double.parse(durationController.text);
                                        data['frequency'] = _frequency;
                                        data['deadline'] = deadlineController.text;
                                        data['idUser'] = UserData().id;

                                        print(data.toString());

                                        Dialogs.showLoadingDialog(
                                            context, TaskController.instance.keyLoader,
                                            "Salvando...");
                                        int code = await TaskController.instance.createTask(data);
                                        Navigator.of(context, rootNavigator: true).pop();
                                        if (code == 201) {
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                              builder: (context) => HomePage()));
                                        } else if (code == 500) {
                                          TemporaryDialog(context,
                                              "Erro ao realizar o login. \nE-mail ou senha incorretos.");
                                        } else {

                                        }
                                      }

                                    },
                                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 42.0),
                                      child: Text(
                                        "ENTRAR",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontFamily: "WorkSansBold"),
                                      ),),
                                   ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            )
        )
    );
  }

  Future<bool> _onBackPressed() {
    return OptionalAlertDialog(
        context, "Deseja cancelar a criação da Atividade?", backAction) ??
        false;
  }
}


void backAction(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
}