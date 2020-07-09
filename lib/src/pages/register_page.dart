import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:prestador_final/src/usuario.dart' as globals;

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String correo;
  String prueba;
  String nombre;
  String apellidos;
  String _contrasena;
  String _comparador;
  String current;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _registro() async {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();

      return;
    }

    form.save();
    globals.correo = correo;
    globals.nombre = nombre;
    globals.password = _contrasena;
    globals.apellidos = apellidos;

    Navigator.pushNamed(context, 'registerCel');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Registrarme',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(31, 56, 96, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  child: Center(
                      child: Text(
                    'Te vamos a guiar en el proceso',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(31, 56, 96, 1),
                        fontSize: MediaQuery.of(context).size.height / 35),
                  )),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 30),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: false,
                    decoration: InputDecoration(
                        labelText: 'Ingresa tu nombre(s)',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    validator: (val) {
                      String pattern = r'(^[a-zA-Z ]*$)';
                      RegExp regExp = new RegExp(pattern);
                      if (val.isEmpty) {
                        return 'Por favor teclee un nombre valido';
                      } else if (val.length < 2) {
                        return 'Por favor ingrese un nombre de mas de 2 caracteres';
                      } else if (!regExp.hasMatch(val)) {
                        return 'El nombre solo puede contener letras';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        nombre = val;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    autocorrect: false,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        labelText: 'Ingresa tus apellidos'),
                    validator: (val) {
                      String pattern = r'(^[a-zA-Z ]*$)';
                      RegExp regExp = new RegExp(pattern);
                      if (val.isEmpty) {
                        return 'Por favor teclee un apellido valido';
                      } else if (val.length < 2) {
                        return 'Por favor ingrese un apellido de mas de 2 caracteres';
                      } else if (!regExp.hasMatch(val)) {
                        return 'El apellido solo puede contener letras';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        apellidos = val;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        labelText: 'Escribe tu dirección de correo'),
                    validator: (val) => !EmailValidator.Validate(val, true)
                        ? 'No es un correo valido'
                        : null,
                    onSaved: (val) {
                      setState(() {
                        correo = val;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        labelText: 'Escribe tu contraseña'),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Por favor teclee un contraseña valida ';
                      } else if (6 > val.length) {
                        return 'Por favor ingrese un password de 6 caracteres';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _contrasena = val;
                      });
                    },
                    onChanged: (val) {
                      setState(() {
                        _comparador = val;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        labelText: 'Confirma tu contraseña'),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Por favor teclee una contraseña valida ';
                      } else if (val != _comparador) {
                        return 'Las contraseñas no coinciden';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 30),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      color: Color.fromRGBO(31, 56, 96, 1),
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 50,
                          bottom: MediaQuery.of(context).size.height / 50,
                          left: MediaQuery.of(context).size.width / 2.8,
                          right: MediaQuery.of(context).size.width / 2.8),
                      onPressed: () {
                        _registro();
                      },
                      child: Text('Enviar',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 35,
                            color: Colors.white,
                          ))),
                ),
                Image.asset(
                  'assets/logo_splash.png',
                  scale: 1.5,
                ),
              ],
            ),
          )),
    );
  }
}
