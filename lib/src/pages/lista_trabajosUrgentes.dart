import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:prestador_final/src/argumentosUrgentes.dart';
import 'package:prestador_final/src/direccion.dart';
import 'package:prestador_final/src/usuario.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prestador_final/src/pages/pref.dart';

class ListaTrabajosUrgentesPage extends StatefulWidget {
  ListaTrabajosUrgentesPage({Key key}) : super(key: key);

  @override
  _ListaTrabajosUrgentesPageState createState() =>
      _ListaTrabajosUrgentesPageState();
}

class _ListaTrabajosUrgentesPageState extends State<ListaTrabajosUrgentesPage> {
  final Color mainColor = const Color(0xff3C3261);
  bool isSwitched = true;
  String prof1, prof2, prof3;
  int prof;
  Location location;
  LocationData currentLocation;
  final prefs = new Rapidos();
  bool q;
  bool w;
  bool e;
  bool r;
  bool t;
  bool y;
  bool u;
  bool i;
  bool o;
  bool p;
  bool a;
  bool s;
  bool d;
  List profesiones = [];
  @override
  void initState() {
    super.initState();
    _shared();
    profesionesGet();
  }

  _shared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prof = prefs.getInt('profesiones');
    prof1 = prefs.getString('profesion_1');
    prof2 = prefs.getString('profesion_2');
    prof3 = prefs.getString('profesion_3');
    print(prof1);
    //profesiones=[prof1,prof2,prof3];
  }

  profesionesGet() {
    q = prefs.getq();
    w = prefs.getw();
    e = prefs.gete();
    r = prefs.getr();
    t = prefs.gett();
    y = prefs.gety();
    u = prefs.getu();
    i = prefs.geti();
    o = prefs.geto();
    p = prefs.getp();
    a = prefs.geta();
    s = prefs.gets();
    d = prefs.getd();
    if (q == true) {
      profesiones.add('Veterinario');
    }
    if (w == true) {
      profesiones.add('Enfermería');
    }
    if (e == true) {
      profesiones.add('Inyecciones');
    }
    if (r == true) {
      profesiones.add('Ambulancia');
    }
    if (t == true) {
      profesiones.add('Cerrajero Auto');
    }
    if (y == true) {
      profesiones.add('Cerrajero Auto');
    }
    if (u == true) {
      profesiones.add('Cerrajero');
    }
    if (i == true) {
      profesiones.add('Fuga de Gas');
    }
    if (o == true) {
      profesiones.add('Fontanero');
    }
    if (p == true) {
      profesiones.add('Mecanica');
    }
    if (a == true) {
      profesiones.add('Ponchadura');
    }
    if (s == true) {
      profesiones.add('Gasolina');
    }
    if (d == true) {
      profesiones.add('Bateria');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: <Widget>[
            Text(
              'Apagar pedidos en vivo:',
              maxLines: 2,
              style: TextStyle(fontSize: 13),
            ),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  Navigator.pushReplacementNamed(context, 'homePage');
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('PedidosUrgentes')
            .where("Disponible", isEqualTo: 'true')
            .where('Titulo', whereIn: profesiones)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return new ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Column(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {},
                          child: Row(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: new Container(
                                  margin: const EdgeInsets.all(16.0),
                                  child: new Container(
                                    width: 70.0,
                                    height: 70.0,
                                  ),
                                  decoration: new BoxDecoration(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    image: new DecorationImage(
                                        image: AssetImage(document['Imagen']),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              new Expanded(
                                  child: new Container(
                                margin: const EdgeInsets.fromLTRB(
                                    16.0, 0.0, 16.0, 0.0),
                                child: new Column(
                                  children: [
                                    new Text(
                                      document['Titulo'],
                                      style: new TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'Arvo',
                                          fontWeight: FontWeight.bold,
                                          color: mainColor),
                                    ),
                                    new Padding(
                                        padding: const EdgeInsets.all(2.0)),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              )),
                              FlatButton(
                                  onPressed: () {
                                    setState(() async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setDouble('a', document['a']);
                                      prefs.setDouble('b', document['b']);

                                      //Navigator.pushNamed(context, 'mapa');
                                      Navigator.pushNamed(
                                          context, 'detallesUrgente',
                                          arguments: ArgumentosmUrgentes(
                                              document['Titulo'],
                                              document['Descripcion'],
                                              document.documentID,
                                              document['Pedido'],
                                              document['Identificador']));
                                    });
                                  },
                                  child: Text('Aceptar'))
                            ],
                          )),
                    ],
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }

  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    currentLocation = await location.getLocation();
  }
}
