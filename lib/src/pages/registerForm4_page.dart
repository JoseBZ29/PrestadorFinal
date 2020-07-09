import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prestador_final/src/usuario.dart' as globals;
import 'package:prestador_final/src/widgets/card2_photo_widget.dart';

class RegisterForm4Page extends StatefulWidget {
  RegisterForm4Page({Key key}) : super(key: key);

  @override
  _RegisterForm4PageState createState() => _RegisterForm4PageState();
}

class _RegisterForm4PageState extends State<RegisterForm4Page> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isRegistering = false;

  _registro() async {
    final form = _formKey.currentState;

    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _isRegistering = false;
      });
      return;
    }
    form.save();

    var domicilio = CardFotos2State.galleryFile;
    var constancia = CardFotos2State.galleryFile2;
    if (globals.imagen3 == 1) {
      if (globals.imagen4 == 1) {
        globals.domicilio = domicilio;
        globals.constancia = constancia;

        Navigator.pushNamed(context, 'register6');
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Las imagenes son necesarias'),
          duration: Duration(seconds: 10),
        ));
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Las imagenes son necesarias'),
        duration: Duration(seconds: 10),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Carga de documentos',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromRGBO(31, 56, 96, 1),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: ListView(children: <Widget>[
          Form(
              key: _formKey,
              child: Column(children: <Widget>[
                CardFotos2(),
                Container(
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 40,
                          bottom: MediaQuery.of(context).size.width / 40,
                          left: MediaQuery.of(context).size.height / 10,
                          right: MediaQuery.of(context).size.height / 10),
                      color: Color.fromRGBO(31, 56, 96, 1),
                      onPressed: () {
                        _registro();
                      },
                      child: Text('Siguiente',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 35,
                              color: Colors.white))),
                )
              ])),
        ]));
  }
}
