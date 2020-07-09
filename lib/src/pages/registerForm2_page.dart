import 'package:flutter/material.dart';
import 'package:prestador_final/src/usuario.dart' as globals;

class RegisterForm2Page extends StatefulWidget {
  RegisterForm2Page({Key key}) : super(key: key);

  @override
  _RegisterForm2PageState createState() => _RegisterForm2PageState();
}

class _RegisterForm2PageState extends State<RegisterForm2Page> {
  String _estudios;
  String _factura = "";
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isRegistering = false;
  String _cedula;
  String _rfc;
  String nose = '';

  Widget cedula() {
    if (nose == 'Universidad') {
      return Container(
        padding: EdgeInsets.only(top: 20),
        child: TextFormField(
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              labelText: 'Ingresa tu cédula profesional'),
          validator: (val) {
            if (val.isEmpty) {
              return 'Por favor teclee una cedula valida';
            } else {
              return null;
            }
          },
          onSaved: (val) {
            setState(() {
              _cedula = val;
            });
          },
        ),
      );
    } else {
      return Container();
    }
  }

  Widget rfc() {
    if (_factura == 'Si') {
      return Container(
        padding: EdgeInsets.only(top: 20),
        child: TextFormField(
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              labelText: 'Ingresa tu RFC'),
          validator: (val) {
            if (val.isEmpty) {
              return 'Por favor teclee un RFC valido';
            } else {
              return null;
            }
          },
          onSaved: (val) {
            setState(() {
              _rfc = val;
            });
          },
        ),
      );
    } else {
      return Container();
    }
  }

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

    if (_estudios != null) {
      if (_factura.length > 0) {
        globals.cedula = _cedula;
        globals.rfc = _rfc;
        globals.estudios = _estudios;
        globals.factura = _factura;

        Navigator.pushNamed(context, 'register3');
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
              'Se necesita saber si usted da factura. Favor de elegir una opcion.'),
          duration: Duration(seconds: 5),
        ));
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
            'Se necesita su ultimo nivel de estudios. Favor de elegir una opcion.'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(nose);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Configuración de perfil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(31, 56, 96, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
          child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 70,
                  left: MediaQuery.of(context).size.height / 25,
                  right: MediaQuery.of(context).size.height / 25),
              child: Form(
                  key: _formKey,
                  child: ListView(children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 70),
                            child: Text(
                              'Quiero ofrecer mis servicios',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 40),
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Image.asset(
                            'assets/images/Perfil.png',
                            scale: 4,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Text('Mi perfil profesional'),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Text('Selecciona tu último grado de estudios'),
                        ),
                        Container(child: _normalDown()),
                        cedula(),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Text('Selecciona si generas factura'),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              RadioListTile(
                                groupValue: _factura,
                                title: Text('Sí doy factura'),
                                value: 'Si',
                                onChanged: (val) {
                                  setState(() {
                                    _factura = val;
                                  });
                                },
                              ),
                              RadioListTile(
                                groupValue: _factura,
                                title: Text('No doy factura'),
                                value: 'No',
                                onChanged: (val) {
                                  setState(() {
                                    _factura = val;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        rfc(),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 30),
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width / 40,
                                  bottom:
                                      MediaQuery.of(context).size.width / 40,
                                  left: MediaQuery.of(context).size.height / 10,
                                  right:
                                      MediaQuery.of(context).size.height / 10),
                              color: Color.fromRGBO(31, 56, 96, 1),
                              onPressed: () {
                                _registro();
                              },
                              child: Text('Siguiente',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              35,
                                      color: Colors.white))),
                        )
                      ],
                    ),
                  ])))),
    );
  }

  DropdownButton _normalDown() => DropdownButton<String>(
        items: [
          DropdownMenuItem(
            value: "Primaria",
            child: Text(
              "Primaria",
            ),
          ),
          DropdownMenuItem(
            value: "Secundaria",
            child: Text(
              "Secundaria",
            ),
          ),
          DropdownMenuItem(
            value: "Preparatoria",
            child: Text(
              "Preparatoria",
            ),
          ),
          DropdownMenuItem(
            value: "Universidad",
            child: Text(
              "Universidad",
            ),
          ),
        ],
        icon: Icon(Icons.school),
        onChanged: (value) {
          setState(() {
            _estudios = value;
            nose = value;
          });
        },
        value: _estudios,
      );
}
