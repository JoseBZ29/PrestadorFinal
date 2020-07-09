import 'package:flutter/material.dart';
import 'package:prestador_final/src/usuario.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterForm7Page extends StatefulWidget {
  RegisterForm7Page({Key key}) : super(key: key);

  @override
  _RegisterForm7PageState createState() => _RegisterForm7PageState();
}

class _RegisterForm7PageState extends State<RegisterForm7Page> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isRegistering = false;
  String _nomRef1;
  String _parenRef1;
  String _celRef1;
  String _nomRef2;
  String _parenRef2;
  String _celRef2;
  int numProf;
  _registro() async {
    if (_isRegistering) return;
    setState(() {
      _isRegistering = true;
    });

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Registrando....'),
    ));

    final form = _formKey.currentState;

    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _isRegistering = false;
      });
      return;
    }
    form.save();
    try {
      String correo = globals.correo;
      String _contrasena = globals.password;
      String nombre = globals.nombre;
      String apellidos = globals.apellidos;
      String _rfc = globals.rfc;
      String _estudios = globals.estudios;
      String _factura = globals.factura;
      String _cedula = globals.cedula;
      var image = globals.identificacion;
      var image2 = globals.antecedentes;
      var domicilio = globals.domicilio;
      var constancia = globals.constancia;
      var tarjeta = globals.tarjeta;
      String numtarjeta = globals.numtarjeta;
      String expiracionMes = globals.expiracionMes;
      String expiracionAnno = globals.expiracionAnno;
      String codigo = globals.codigo;
      var trab1 = globals.trabajo1;
      var trab2 = globals.trabajo2;
      var trab3 = globals.trabajo3;
      var trab4 = globals.trabajo4;
      var trab5 = globals.trabajo5;
      String profesion1 = globals.profesion1;
      String profesion2 = globals.profesion2;
      String profesion3 = globals.profesion3;
      String celular = globals.celular;
      var fotoPerfil = globals.fotoPerfil;
      String banco1 = globals.banco1;
      String banco2 = globals.banco2;

      String numTarjeta1 = globals.numTarjeta1;
      String numTarjeta2 = globals.numTarjeta2;

      String clabe1 = globals.clabe1;
      String clabe2 = globals.clabe2;
      String oficina = globals.direccion;

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: correo, password: _contrasena);
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final userid = user.uid;
      print(userid);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
            'El registro puede demorar 10 minutos. Por favor sea paciente.'),
        duration: Duration(minutes: 15),
      ));
      final StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child('Usuarios')
          .child('$userid')
          .child('identificacion')
          .putFile(image);
      if (await task.onComplete != null) {
        StorageTaskSnapshot storageTaskSnapshot = await task.onComplete;
        String imgUrl = await storageTaskSnapshot.ref.getDownloadURL();
        print(imgUrl);
        final StorageUploadTask task2 = FirebaseStorage.instance
            .ref()
            .child('Usuarios')
            .child('$userid')
            .child('CartaNoAntecedentes')
            .putFile(image2);
        if (await task2.onComplete != null) {
          StorageTaskSnapshot storageTaskSnapshot = await task2.onComplete;
          String imgUrl2 = await storageTaskSnapshot.ref.getDownloadURL();
          print(imgUrl2);
          final StorageUploadTask task3 = FirebaseStorage.instance
              .ref()
              .child('Usuarios')
              .child('$userid')
              .child('ComprobanteDomicilio')
              .putFile(domicilio);
          if (await task3.onComplete != null) {
            StorageTaskSnapshot storageTaskSnapshot = await task3.onComplete;
            String imgUrlDom = await storageTaskSnapshot.ref.getDownloadURL();
            print(imgUrlDom);
            final StorageUploadTask task4 = FirebaseStorage.instance
                .ref()
                .child('Usuarios')
                .child('$userid')
                .child('ConstanciaSat')
                .putFile(constancia);
            if (await task4.onComplete != null) {
              StorageTaskSnapshot storageTaskSnapshot = await task4.onComplete;
              String imgUrlConst =
                  await storageTaskSnapshot.ref.getDownloadURL();
              print(imgUrlConst);
              final StorageUploadTask task6 = FirebaseStorage.instance
                  .ref()
                  .child('Usuarios')
                  .child('$userid')
                  .child('Trebajo1')
                  .putFile(trab1);
              if (await task6.onComplete != null) {
                StorageTaskSnapshot storageTaskSnapshot =
                    await task6.onComplete;
                String imgUrlTrab1 =
                    await storageTaskSnapshot.ref.getDownloadURL();
                print(imgUrlTrab1);
                final StorageUploadTask task7 = FirebaseStorage.instance
                    .ref()
                    .child('Usuarios')
                    .child('$userid')
                    .child('Trebajo2')
                    .putFile(trab2);
                if (await task7.onComplete != null) {
                  StorageTaskSnapshot storageTaskSnapshot =
                      await task7.onComplete;
                  String imgUrlTrab2 =
                      await storageTaskSnapshot.ref.getDownloadURL();
                  print(imgUrlTrab2);
                  final StorageUploadTask task8 = FirebaseStorage.instance
                      .ref()
                      .child('Usuarios')
                      .child('$userid')
                      .child('Trabajo3')
                      .putFile(trab3);
                  if (await task8.onComplete != null) {
                    StorageTaskSnapshot storageTaskSnapshot =
                        await task8.onComplete;
                    String imgUrlTrab3 =
                        await storageTaskSnapshot.ref.getDownloadURL();
                    print(imgUrlTrab3);
                    final StorageUploadTask task9 = FirebaseStorage.instance
                        .ref()
                        .child('Usuarios')
                        .child('$userid')
                        .child('Trabajo4')
                        .putFile(trab4);
                    if (await task9.onComplete != null) {
                      StorageTaskSnapshot storageTaskSnapshot =
                          await task9.onComplete;
                      String imgUrlTrab4 =
                          await storageTaskSnapshot.ref.getDownloadURL();
                      print(imgUrlTrab4);
                      final StorageUploadTask task10 = FirebaseStorage.instance
                          .ref()
                          .child('Usuarios')
                          .child('$userid')
                          .child('Trabajo5')
                          .putFile(trab5);
                      if (await task10.onComplete != null) {
                        StorageTaskSnapshot storageTaskSnapshot =
                            await task10.onComplete;
                        String imgUrlTrab5 =
                            await storageTaskSnapshot.ref.getDownloadURL();
                        print(imgUrlTrab5);
                        final StorageUploadTask task11 = FirebaseStorage
                            .instance
                            .ref()
                            .child('Usuarios')
                            .child('$userid')
                            .child('FotoPerfil')
                            .putFile(fotoPerfil);
                        if (await task11.onComplete != null) {
                          StorageTaskSnapshot storageTaskSnapshot =
                              await task11.onComplete;
                          String imgURLFotoPerfil =
                              await storageTaskSnapshot.ref.getDownloadURL();
                          print(imgURLFotoPerfil);

                          await Firestore.instance
                              .collection('Usuarios')
                              .document(userid)
                              .setData({
                            "Nombre": '$nombre',
                            "Apellido": '$apellidos',
                            "RFC": "$_rfc",
                            "Grado Estudios": "$_estudios",
                            "Factura": "$_factura",
                            "Cedula": "$_cedula",
                            "Identificacion": "$imgUrl",
                            "CartaNoAntecedentes": "$imgUrl2",
                            "ComprobanteDomicilio": "$imgUrlDom",
                            "ConstanciaSAT": "$imgUrlConst",
                            "Trabajo1": "$imgUrlTrab1",
                            "Trabajo2": "$imgUrlTrab2",
                            "Trabajo3": "$imgUrlTrab3",
                            "Trabajo4": "$imgUrlTrab4",
                            "Trabajo5": "$imgUrlTrab5",
                            "NombreReferencia1": "$_nomRef1",
                            "ParentescoReferencia1": "$_parenRef1",
                            "CelularReferencia1": "$_celRef1",
                            "NombreReferencia2": "$_nomRef2",
                            "ParentescoReferencia2": "$_parenRef2",
                            "CelularReferencia2": "$_celRef2",
                            "Profesion1": "$profesion1",
                            "Profesion2": "$profesion2",
                            "Profesion3": "$profesion3",
                            "Celular": "$celular",
                            "FotoPerfil": "$imgURLFotoPerfil",
                            "Banco1": "$banco1",
                            "Banco2": "$banco2",
                            "NumTarjeta1": "$numTarjeta1",
                            "NumTarjeta2": "$numTarjeta2",
                            "Clabe1": "$clabe1",
                            "Clabe2": "$clabe2",
                            "Oficina": "$oficina",
                            "Password": "$_contrasena",
                            "UserID": "$userid",
                            "Tipo": "profesional",
                            "Activo": "0"
                          });
                          String idProfesion;
                          String idProfesion2;
                          String idProfesion3;
                          if (profesion1.length > 3) {
                            print(profesion1);
                            await Firestore.instance
                                .collection('Profesiones')
                                .where('Profecion', isEqualTo: profesion1)
                                .getDocuments()
                                .then((value) =>
                                    value.documents.forEach((element) {
                                      idProfesion = element.documentID;
                                    }));
                            await Firestore.instance
                                .collection('Profesiones')
                                .document(idProfesion)
                                .updateData({'Activo': '1'});
                          }
                          if (profesion2.length > 3) {
                            print(profesion2);
                            await Firestore.instance
                                .collection('Profesiones')
                                .where('Profecion', isEqualTo: profesion2)
                                .getDocuments()
                                .then((value) =>
                                    value.documents.forEach((element) {
                                      idProfesion2 = element.documentID;
                                    }));
                            await Firestore.instance
                                .collection('Profesiones')
                                .document(idProfesion2)
                                .updateData({'Activo': '1'});
                          }
                          if (profesion3.length > 3) {
                            print(profesion3);
                            await Firestore.instance
                                .collection('Profesiones')
                                .where('Profecion', isEqualTo: profesion3)
                                .getDocuments()
                                .then((value) =>
                                    value.documents.forEach((element) {
                                      idProfesion3 = element.documentID;
                                    }));
                            await Firestore.instance
                                .collection('Profesiones')
                                .document(idProfesion3)
                                .updateData({'Activo': '1'});
                          }
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          if (profesion2.length > 0) {
                            numProf = 2;
                            if (profesion3.length > 0) {
                              numProf = 3;
                            } else {
                              numProf = 2;
                            }
                          } else {
                            numProf = 1;
                          }
                          prefs.setString('nombre', nombre);
                          prefs.setInt('profesiones', numProf);
                          prefs.setString('profesion_1', profesion1);
                          prefs.setString('profesion_2', profesion2);
                          prefs.setString('profesion_3', profesion3);
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }

      //Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);

      Navigator.pushReplacementNamed(context, 'inicio');
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
        _isRegistering = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Referencias personales',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(31, 56, 96, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
          child: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 60),
              child: Form(
                  key: _formKey,
                  child: ListView(children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 30),
                            child: Text(
                                'Registra 2 referencias de preferencia clientes')),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 30),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Nombre de tu referencia',
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
                                _nomRef1 = val;
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 30),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Parentesco',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            validator: (val) {
                              String pattern = r'(^[a-zA-Z ]*$)';
                              RegExp regExp = new RegExp(pattern);
                              if (val.isEmpty) {
                                return 'Por favor teclee un parentesco valido';
                              } else if (val.length < 2) {
                                return 'Por favor ingrese un parentesco de mas de 2 caracteres';
                              } else if (!regExp.hasMatch(val)) {
                                return 'El parentesco solo puede contener letras';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {
                              setState(() {
                                _parenRef1 = val;
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
                                labelText: 'Número de Teléfono',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Por favor teclee un numero valido';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {
                              setState(() {
                                _celRef1 = val;
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Nombre de tu referencia',
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
                                _nomRef2 = val;
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 30),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Parentesco',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            validator: (val) {
                              String pattern = r'(^[a-zA-Z ]*$)';
                              RegExp regExp = new RegExp(pattern);
                              if (val.isEmpty) {
                                return 'Por favor teclee un parentesco valido';
                              } else if (val.length < 2) {
                                return 'Por favor ingrese un parentesco de mas de 2 caracteres';
                              } else if (!regExp.hasMatch(val)) {
                                return 'El parentesco solo puede contener letras';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {
                              setState(() {
                                _parenRef2 = val;
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
                                labelText: 'Número de Teléfono',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Por favor teclee un numero valido';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {
                              setState(() {
                                _celRef2 = val;
                              });
                            },
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
}
