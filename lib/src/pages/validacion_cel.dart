import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValidarCelPage extends StatefulWidget {
  ValidarCelPage({Key key}) : super(key: key);

  @override
  _ValidarCelPageState createState() => _ValidarCelPageState();
}

class _ValidarCelPageState extends State<ValidarCelPage> {
  String cel;
  String verificationId;
  int longitud;
  String ultimosDigitos = '';
  final _codeController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _nose() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      verificationId = prefs.getString('verificationId');
      print(cel);
      final code = _codeController.text.trim();
      FirebaseAuth _auth = FirebaseAuth.instance;
      AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: verificationId, smsCode: code);
      await Future.delayed(Duration(seconds: 3));
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;
      if (user != null) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, 'validacionExitosa');
      } else {
        _scaffoldKey.currentState.hideCurrentSnackBar();
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 10),
          content: Text('Hubo un error'),
        ));
        print("Error");
      }
    } catch (e) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        content: Text('Hubo un error, intentalo de nuevo.'),
      ));
      print(e.toString());
    }
  }

  _mostrarCel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String celular = prefs.getString('celular');
    longitud = celular.length;
    ultimosDigitos = celular.substring(longitud - 2, longitud);
    print(ultimosDigitos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(31, 56, 96, 1),
        title: Text(
          'Proceso de validación',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 30),
                  child: Image.asset(
                    'assets/images/iconoPer.png',
                    width: MediaQuery.of(context).size.height / 10,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 20,
                      left: MediaQuery.of(context).size.width / 20,
                      right: MediaQuery.of(context).size.width / 20),
                  child: Text(
                    'En breve recibirás un mensaje.',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 45,
                      color: Color.fromRGBO(31, 56, 96, 1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 40,
                      left: MediaQuery.of(context).size.width / 15,
                      right: MediaQuery.of(context).size.width / 15),
                  child: Text(
                      'Contiene el código de seguridad para validar tu número celular',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 45,
                        color: Color.fromRGBO(31, 56, 96, 1),
                      )),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 40,
                      left: MediaQuery.of(context).size.width / 15,
                      right: MediaQuery.of(context).size.width / 15),
                  child: Text('*********$ultimosDigitos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 45)),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 50,
                      left: MediaQuery.of(context).size.width / 30,
                      right: MediaQuery.of(context).size.width / 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Escribe el código de seguridad'),
                    controller: _codeController,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 30),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 40,
                          bottom: MediaQuery.of(context).size.width / 40,
                          left: MediaQuery.of(context).size.height / 7,
                          right: MediaQuery.of(context).size.height / 7),
                      color: Color.fromRGBO(31, 56, 96, 1),
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          duration: Duration(seconds: 10),
                          content: Text('Se esta validando el código.'),
                        ));
                        _nose();
                      },
                      child: Text('Validar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 35,
                              color: Colors.white))),
                )
              ],
            )
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
            onPressed: () {},
            child: Text(
              '¿No recibiste el mensaje? Intentar de nuevo',
              style: TextStyle(
                color: Color.fromRGBO(31, 56, 96, 1),
              ),
            ))
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mostrarCel();
  }
}
