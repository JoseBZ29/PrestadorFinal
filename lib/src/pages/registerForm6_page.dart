import 'package:flutter/material.dart';
import 'package:prestador_final/src/usuario.dart' as globals;
import 'package:prestador_final/src/widgets/card4_photo_widget.dart';

class RegisterForm6Page extends StatefulWidget {
  RegisterForm6Page({Key key}) : super(key: key);

  @override
  _RegisterForm6PageState createState() => _RegisterForm6PageState();
}

class _RegisterForm6PageState extends State<RegisterForm6Page> {
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
    var trab1 = CardFotos4State.galleryFile;
    var trab2 = CardFotos4State.galleryFile2;
    var trab3 = CardFotos4State.galleryFile3;
    var trab4 = CardFotos4State.galleryFile4;
    var trab5 = CardFotos4State.galleryFile5;
    if (globals.imagen5 == 1) {
      if (globals.imagen6 == 1) {
        if (globals.imagen7 == 1) {
          if (globals.imagen8 == 1) {
            if (globals.imagen9 == 1) {
              globals.trabajo1 = trab1;
              globals.trabajo2 = trab2;
              globals.trabajo3 = trab3;
              globals.trabajo4 = trab4;
              globals.trabajo5 = trab5;

              Navigator.popAndPushNamed(context, 'registerLoc');
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
          'Galería de trabajos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(31, 56, 96, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.all(30.0),
            child: ListView(children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Text('Subir 5 imagenes ilustrativas sobre tus trabajos'),
                    CardFotos4(),
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 5),
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
                                  fontSize:
                                      MediaQuery.of(context).size.height / 35,
                                  color: Colors.white))),
                    )
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
