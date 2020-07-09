import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PermissionHandler _permissionHandler = PermissionHandler();
  String _celular;
  String _contrasena;
  String prof1;
  String prof2;
  String prof3;
  int numProf;
  String pass;
  String identificador;
  String nombre;
  String activo;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLogin = false;
  double screenHeight;

  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> requestContactsPermission() async {
    return _requestPermission(PermissionGroup.location);
  }

  _login() async {
    if (_isLogin) return;
    setState(() {
      _isLogin = true;
    });

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Iniciando Sesión....'),
    ));

    final form = _formKey.currentState;

    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _isLogin = false;
      });
      return;
    }
    form.save();

    try {
      Firestore.instance
          .collection('Usuarios')
          .where("Celular", isEqualTo: _celular)
          .snapshots()
          .listen((data) {
        data.documents.forEach((doc) {
          pass = doc["Password"];
          identificador = doc.documentID;
        });
      });
      await Future.delayed(Duration(seconds: 3));
      print(_celular);
      print(pass);
      print(_contrasena);
      if (pass == _contrasena) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('identificador', identificador);
        pref.setString('identificadorUser', identificador);
        print('Usuario :$identificador');
        await Firestore.instance
            .collection('Usuarios')
            .document(identificador)
            .get()
            .then((document) {
          prof1 = document['Profesion1'];
          prof2 = document['Profesion2'];
          prof3 = document['Profesion3'];
          nombre = document['Nombre'];
          activo = document['Activo'];
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prof2.length > 0) {
          numProf = 2;
          if (prof3.length > 0) {
            numProf = 3;
          } else {
            numProf = 2;
          }
        } else {
          numProf = 1;
        }
        prefs.setInt('profesiones', numProf);
        prefs.setString('profesion_1', prof1);
        prefs.setString('profesion_2', prof2);
        prefs.setString('profesion_3', prof3);
        prefs.setString('nombre', nombre);

        requestContactsPermission();
        prefs.setBool('sesion', true);
        if (activo == '1') {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, 'homePage');
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Su cuenta aún no esta activada.'),
          ));
        }
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Error, la información es incorrecta.'),
        ));
      }
    } catch (e) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.message),
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: 'Cerrar',
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
        ),
      ));
    } finally {
      setState(() {
        _isLogin = false;
      });
    }
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'assets/images/Back.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight / 2,
        color: Color(0xFFECF0F3),
      ),
    );
  }

  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: screenHeight / 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/logoMe2.png',
            scale: 4,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    upperHalf(context),
                    loginCard(context),
                    pageTitle()
                  ],
                ),
              )),
        ));
  }

  Widget loginCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 3),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Ingresa tus datos",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(59, 164, 171, 1),
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Número de celular",
                        hasFloatingPlaceholder: true),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Por favor teclee un correo valido';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _celular = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Contraseña", hasFloatingPlaceholder: true),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Por favor teclee un contraseña valida ';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _contrasena = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {},
                        child: Text(
                          "¿Olvidaste tu contraseña?",
                          style: TextStyle(
                              color: Color.fromRGBO(59, 164, 171, 0.9)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          "Ingresar",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 50),
                        ),
                        color: Color.fromRGBO(59, 164, 171, 0.9),
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height / 8,
                            right: MediaQuery.of(context).size.height / 8,
                            top: MediaQuery.of(context).size.height / 45,
                            bottom: MediaQuery.of(context).size.height / 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () async {
                          _login();
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
