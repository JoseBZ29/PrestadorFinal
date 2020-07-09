import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prestador_final/src/usuario.dart' as globals;
import 'package:prestador_final/src/widgets/card3_photo_widget.dart';
import 'package:prestador_final/src/widgets/card5_photo_widget.dart';

class RegisterForm5Page extends StatefulWidget {
  RegisterForm5Page({Key key}) : super(key: key);

  @override
  _RegisterForm5PageState createState() => _RegisterForm5PageState();
}

class _RegisterForm5PageState extends State<RegisterForm5Page> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isRegistering = false;
  String searchString;
  String profesion1 = "";
  String profesion2 = "";
  String profesion3 = "";
  String profesion1F;
  String profesion2F = "";
  String profesion3F = "";
  int _curretStep = 0;
  List<String> profesiones = List<String>();

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
    profesion1F = profesion1;
    profesion2F = profesion2;
    profesion3F = profesion3;
    var fotoPerfil = CardFotos5State.galleryFile;
    if (globals.imagen10 == 1) {
      if (profesion1F.length > 0) {
        globals.profesion1 = profesion1F;
        globals.profesion2 = profesion2F;
        globals.profesion3 = profesion3F;
        globals.fotoPerfil = fotoPerfil;
        Navigator.pushNamed(context, 'register2');
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
              'Se necesita por lo menos una profesión. Por favor selecciona una profesión'),
          duration: Duration(seconds: 5),
        ));
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Se necesita tu foto de perfil'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  String name = "";
  String name2 = "";
  String name3 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Selección de mi Perfil',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromRGBO(31, 56, 96, 1),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _registro();
          },
          child: Icon(Icons.navigate_next),
        ),
        body: ListView(children: <Widget>[
          Form(
              key: _formKey,
              child: Stepper(
                steps: _mySteps(),
                currentStep: this._curretStep,
                onStepTapped: (step) {
                  setState(() {
                    this._curretStep = step;
                  });
                },
                onStepContinue: () {
                  setState(() {
                    if (this._curretStep < this._mySteps().length - 1) {
                      this._curretStep = this._curretStep + 1;
                    } else {
                      print('completed');
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (this._curretStep > 0) {
                      this._curretStep = this._curretStep - 1;
                    } else {
                      this._curretStep = 0;
                    }
                  });
                },
                controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Row(
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      Container(
                        height: 40,
                        color: Color.fromRGBO(31, 56, 96, 1),
                        child: FlatButton(
                          onPressed: onStepContinue,
                          child: const Text(
                            'Continuar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: FlatButton(
                          onPressed: onStepCancel,
                          child: const Text('Atrás'),
                        ),
                      ),
                    ],
                  );
                },
              ))
        ]));
  }

  void initiateSearch(String val) {
    setState(() {
      name = val;
    });
  }

  void initiateSearch2(String val2) {
    setState(() {
      name2 = val2;
    });
  }

  void initiateSearch3(String val3) {
    setState(() {
      name3 = val3;
    });
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(title: Text('Mi foto'), content: CardFotos5()),
      Step(
        title: Text('Profesión 1'),
        content: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20),
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.person_outline),
                    labelText: 'Mi Profesión 1',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onChanged: (val) => initiateSearch(val),
                onSaved: (val) {
                  setState(() {
                    profesion1F = val;
                  });
                },
              ),
            ),
            Container(
              height: 100,
              width: 200,
              child: StreamBuilder<QuerySnapshot>(
                stream: name != "" && name != null
                    ? Firestore.instance
                        .collection('Profesiones')
                        .where("Profecion", isGreaterThanOrEqualTo: name)
                        .snapshots()
                    : Firestore.instance.collection("Profesiones").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return Column(
                            children: <Widget>[
                              new FlatButton(
                                onPressed: () {
                                  setState(() {
                                    profesion1 = document['Profecion'];
                                  });
                                },
                                child: new Text(document['Profecion']),
                              ),
                            ],
                          );
                        }).toList(),
                      );
                  }
                },
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                    child: FlatButton(
                        onPressed: () {
                          setState(() {
                            profesion1 = "";
                          });
                        },
                        child: Icon(Icons.delete))),
                Text('Mi profesión 1: $profesion1'),
              ],
            ),
          ],
        ),
        isActive: _curretStep >= 0,
      ),
      Step(
        title: Text('Profesión 2'),
        isActive: _curretStep >= 1,
        content: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20),
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.person_outline),
                    labelText: 'Mi Profesión 2',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onChanged: (val2) => initiateSearch2(val2),
                onSaved: (val2) {
                  setState(() {
                    profesion2F = val2;
                  });
                },
              ),
            ),
            Container(
              height: 100,
              width: 200,
              child: StreamBuilder<QuerySnapshot>(
                stream: name2 != "" && name2 != null
                    ? Firestore.instance
                        .collection('Profesiones')
                        .where("Profecion", isGreaterThanOrEqualTo: name2)
                        .snapshots()
                    : Firestore.instance.collection("Profesiones").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return Column(
                            children: <Widget>[
                              new FlatButton(
                                onPressed: () {
                                  setState(() {
                                    profesion2 = document['Profecion'];
                                  });
                                },
                                child: new Text(document['Profecion']),
                              ),
                            ],
                          );
                        }).toList(),
                      );
                  }
                },
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                    child: FlatButton(
                        onPressed: () {
                          setState(() {
                            profesion2 = "";
                          });
                        },
                        child: Icon(Icons.delete))),
                Text('Mi profesión 2: $profesion2'),
              ],
            ),
          ],
        ),
      ),
      Step(
          title: Text('Profesión 3'),
          content: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.person_outline),
                      labelText: 'Mi Profesión 3',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  onChanged: (val3) => initiateSearch3(val3),
                  onSaved: (val3) {
                    setState(() {
                      profesion3F = val3;
                    });
                  },
                ),
              ),
              Container(
                height: 100,
                width: 200,
                child: StreamBuilder<QuerySnapshot>(
                  stream: name3 != "" && name3 != null
                      ? Firestore.instance
                          .collection('Profesiones')
                          .where("Profecion", isGreaterThanOrEqualTo: name3)
                          .snapshots()
                      : Firestore.instance
                          .collection("Profesiones")
                          .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text('Loading...');
                      default:
                        return new ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            return Column(
                              children: <Widget>[
                                new FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      profesion3 = document['Profecion'];
                                    });
                                  },
                                  child: new Text(document['Profecion']),
                                ),
                              ],
                            );
                          }).toList(),
                        );
                    }
                  },
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                      child: FlatButton(
                          onPressed: () {
                            setState(() {
                              profesion3 = "";
                            });
                          },
                          child: Icon(Icons.delete))),
                  Text('Mi profesión 3: $profesion3'),
                ],
              ),
            ],
          ),
          isActive: _curretStep >= 2),
      Step(
          title: Text('¡Listo!'),
          content: Text('Verifica que la información es correcta'),
          isActive: _curretStep >= 3)
    ];
    return _steps;
  }
}
