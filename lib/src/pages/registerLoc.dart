import 'package:flutter/material.dart';
import 'package:prestador_final/src/pages/select_location.dart';
import 'package:prestador_final/src/usuario.dart' as globals;

class RegisterLoc extends StatefulWidget {
  RegisterLoc({Key key}) : super(key: key);

  @override
  _RegisterLocState createState() => _RegisterLocState();
}

class _RegisterLocState extends State<RegisterLoc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _registro() {
    if (globals.direccion != null) {
      Navigator.pushNamed(context, 'registerCuentaBan');
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('La dirección es necesria'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Mi domicilio/ Oficina',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromRGBO(31, 56, 96, 1),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10),
                child: SelectLocation()),
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
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
          ],
        )));
  }
}
