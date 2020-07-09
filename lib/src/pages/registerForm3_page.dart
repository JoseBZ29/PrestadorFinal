import 'package:flutter/material.dart';
import 'package:prestador_final/src/widgets/card_photo_widget.dart';
import 'package:prestador_final/src/usuario.dart' as globals;

class RegisterPage3Page extends StatefulWidget {
  RegisterPage3Page({Key key}) : super(key: key);

  @override
  _RegisterPage3PageState createState() => _RegisterPage3PageState();
}

class _RegisterPage3PageState extends State<RegisterPage3Page> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isRegistering = false;
  int i = 0;

  registro() async {
    final form = _formKey.currentState;

    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _isRegistering = false;
      });
      return;
    }
    form.save();
    var image = CardFotosState.galleryFile;
    var image2 = CardFotosState.galleryFile2;

    if (globals.imagen == 1) {
      if (globals.imagen2 == 1) {
        globals.identificacion = image;
        globals.antecedentes = image2;

        Navigator.pushNamed(context, 'register4');
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
              child: Column(
                children: <Widget>[
                  CardFotos(),
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
                          registro();
                        },
                        child: Text('Siguiente',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 35,
                                color: Colors.white))),
                  )
                ],
              ))
        ]));
  }
}
