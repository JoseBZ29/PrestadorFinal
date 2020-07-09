import 'package:flutter/material.dart';
import 'package:prestador_final/src/usuario.dart' as globals;

class RegisterCuentaBan extends StatefulWidget {
  RegisterCuentaBan({Key key}) : super(key: key);

  @override
  _RegisterCuentaBanState createState() => _RegisterCuentaBanState();
}

class _RegisterCuentaBanState extends State<RegisterCuentaBan> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isRegistering = false;
  String banco1;
  String banco2;

  String numTarjeta1;
  String numTarjeta2;

  String clabe1;
  String clabe2;

  _registro() {
    final form = _formKey.currentState;

    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _isRegistering = false;
      });
      return;
    }
    form.save();
    print(banco1);
    print(numTarjeta1);
    print(clabe1);
    globals.banco1 = banco1;
    print(globals.banco1);
    globals.banco2 = banco2;
    globals.numTarjeta1 = numTarjeta1;
    globals.numTarjeta2 = numTarjeta2;
    globals.clabe1 = clabe1;
    globals.clabe2 = clabe2;
    Navigator.pushNamed(context, 'register7');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Cuenta Bancaria',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(31, 56, 96, 1),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(children: <Widget>[
        Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height / 60),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 60),
                    child: Text(
                      'Registra hasta 2 cuentas bancarias',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 40),
                    )),
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 30),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Banco',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Es necesario el Banco';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {
                              setState(() {
                                banco1 = val;
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 30),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Número de tarjeta',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                            onSaved: (val) {
                              setState(() {
                                numTarjeta1 = val;
                              });
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Es necesario el número de tarjeta';
                              } else if (val.length < 16) {
                                return 'Número de tarjeta inválido (16 caracteres mínimos).';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 30),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Clabe interbancaria',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                            onSaved: (val) {
                              setState(() {
                                clabe1 = val;
                              });
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Es necesario la clabe interbancaria';
                              } else if (val.length < 18) {
                                return 'CLABE inválida (18 caracteres mínimos).';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 15),
                          child: TextFormField(
                            onSaved: (val) {
                              setState(() {
                                banco2 = val;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Banco',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 30),
                          child: TextFormField(
                            onSaved: (val) {
                              setState(() {
                                numTarjeta2 = val;
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Número de tarjeta',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 30),
                          child: TextFormField(
                            onSaved: (val) {
                              setState(() {
                                clabe2 = val;
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Clabe interbancaria',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 20),
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
                    ))
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
