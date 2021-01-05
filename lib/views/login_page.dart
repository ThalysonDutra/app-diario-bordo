import 'package:appdiario/controllers/loginController.dart';
import 'package:appdiario/utils/alertWidget.dart';
import 'package:appdiario/utils/dialogWidget.dart';
import 'package:appdiario/utils/tab_indicator.dart';
import 'package:appdiario/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  PageController _pageController;

  Color left = Color.fromRGBO(0, 109, 197, 1);
  Color right = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 775.0,
            decoration:
                new BoxDecoration(color: Color.fromRGBO(90, 171, 236, 1)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 75.0),
                  child: new Image(
                      width: 250.0,
                      height: 191.0,
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/Logo.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) {
                      if (i == 0) {
                        setState(() {
                          right = Colors.white;
                          left = Color.fromRGBO(0, 109, 197, 1);
                        });
                      } else if (i == 1) {
                        setState(() {
                          right = Color.fromRGBO(0, 109, 197, 1);
                          left = Colors.white;
                        });
                      }
                    },
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignIn(context),
                      ),
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignUp(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 109, 197, 1),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: left,
                      fontSize: 16.0),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "Novo Usuário",
                  style: TextStyle(
                      color: right,
                      fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Container(
                    width: 300.0,
                    height: 200.0,
                    child: Form(
                      key: LoginController.instance.loginformkey,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 0.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                controller: loginEmailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value.length < 4 ||
                                      !(value.contains("@"))) {
                                    return "Digite um e-mail válido.";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.black,
                                    size: 22.0,
                                  ),
                                  hintText: "E-mail",
                                  hintStyle: TextStyle(
                                      fontSize: 17.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 0.0,
                                  bottom: 0.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                controller: loginPasswordController,
                                obscureText: _obscureTextLogin,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.lock_outline,
                                    size: 22.0,
                                    color: Colors.black,
                                  ),
                                  hintText: "Senha",
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 17.0),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleLogin,
                                    child: Icon(
                                      _obscureTextLogin
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      size: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Digite uma senha válida.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 180.0),
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Color.fromRGBO(0, 109, 197, 1)),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Color.fromRGBO(0, 109, 197, 1),
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
                      ),
                    ),
                    onPressed: () async{
                      if (LoginController.instance.loginformkey.currentState
                          .validate()) {
                        Dialogs.showLoadingDialog(
                            context, LoginController.instance.keyLoader,
                            "Carregando...");
                        int code = await LoginController.instance.login(
                            loginEmailController.text,
                            loginPasswordController.text);
                        Navigator.of(context, rootNavigator: true).pop();
                        if (code == 200) {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => HomePage()));
                        } else if (code == 403) {
                          TemporaryDialog(context,
                              "Erro ao realizar o login. \nE-mail ou senha incorretos.");
                        } else {

                        }
                      }
                    }),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed: () {},
                child: Text(
                  "Esqueceu a senha?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color.fromRGBO(0, 109, 197, 1),
                      fontSize: 16.0,
                      fontFamily: "WorkSansMedium"),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 360.0,
                  child: Form(
                    key: LoginController.instance.signupformkey,
                    child: Column(
                      children: <Widget>[
                       Expanded(
                         child:  Padding(
                           padding: EdgeInsets.only(
                               top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                           child: TextFormField(
                             controller: signupNameController,
                             keyboardType: TextInputType.text,
                             textCapitalization: TextCapitalization.words,
                             style: TextStyle(
                                 fontFamily: "WorkSansSemiBold",
                                 fontSize: 16.0,
                                 color: Colors.black),
                             decoration: InputDecoration(
                               border: InputBorder.none,
                               icon: Icon(
                                 Icons.person_outline,
                                 color: Colors.black,
                               ),
                               hintText: "Nome",
                               hintStyle: TextStyle(
                                   fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                             ),
                             validator: (value){
                               if(value.length<4){
                                 return "Insira um nome válido.";
                               }
                               else{
                                 return null;
                               }
                             },
                           ),
                         ),
                       ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                            child: TextFormField(
                              controller: signupEmailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                hintText: "E-mail",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                              ),
                              validator: (value) {
                                if (value.isEmpty ||
                                    value.length < 4 ||
                                    !(value.contains("@"))) {
                                  return "Insira um e-mail válido.";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                            child: TextFormField(
                              controller: signupPasswordController,
                              obscureText: _obscureTextSignup,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.black,
                                ),
                                hintText: "Senha",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                                suffixIcon: GestureDetector(
                                  onTap: _toggleSignup,
                                  child: Icon(
                                    _obscureTextSignup
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Digite uma senha.";
                                } else if(value.length<4 && value.isNotEmpty){
                                  return "Senha muito pequena";
                                } else{
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                       Expanded(
                         child:  Padding(
                           padding: EdgeInsets.only(
                               top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                           child: TextFormField(
                             controller: signupConfirmPasswordController,
                             obscureText: _obscureTextSignupConfirm,
                             style: TextStyle(
                                 fontFamily: "WorkSansSemiBold",
                                 fontSize: 16.0,
                                 color: Colors.black),
                             decoration: InputDecoration(
                               border: InputBorder.none,
                               icon: Icon(
                                 Icons.lock_outline,
                                 color: Colors.black,
                               ),
                               hintText: "Confirmar Senha",
                               hintStyle: TextStyle(
                                   fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                               suffixIcon: GestureDetector(
                                 onTap: _toggleSignupConfirm,
                                 child: Icon(
                                   _obscureTextSignupConfirm
                                       ? Icons.visibility_off
                                       : Icons.visibility,
                                   size: 15.0,
                                   color: Colors.black,
                                 ),
                               ),
                             ),
                             validator: (value) {
                               if (value.isEmpty) {
                                 return "Digite uma senha.";
                               } else if(value != signupPasswordController.text){
                                 return "Senhas não coincidem.";
                               } else{
                                 return null;
                               }
                             },
                           ),
                         ),
                       )
                      ],
                    ),
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 340.0),
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Color.fromRGBO(0, 109, 197, 1)),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Color.fromRGBO(0, 109, 197, 1),
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () async {
                      if(LoginController.instance.signupformkey.currentState.validate()){
                        Map<String, dynamic> newUser = Map();
                        newUser["email"] = signupEmailController.text;
                        newUser["name"] = signupNameController.text;
                        newUser["password"] = signupConfirmPasswordController.text;
                        Dialogs.showLoadingDialog(
                            context, LoginController.instance.keyLoader,
                            "Cadastrando...");
                        int code = await LoginController.instance.signUp(newUser);
                        Navigator.of(context, rootNavigator: true).pop();
                        if(code == 201){
                          TemporaryDialog(context,
                              "Cadastro realizado. \nDirecione-se para a tela de login.");
                          initForms();

                        }
                        else{
                          TemporaryDialog(context,
                              "Cadastro não realizado. \nVerifique seus dados ou sua conexão.");
                        }
                      }
                    },
              ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }

  void initForms(){
    setState(() {
      signupPasswordController.clear();
      signupConfirmPasswordController.clear();
      signupNameController.clear();
      signupEmailController.clear();
      loginPasswordController.clear();
      loginEmailController.clear();
    });
  }
}
