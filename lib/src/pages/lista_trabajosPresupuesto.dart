import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:prestador_final/src/argumentosUrgentes.dart';
import 'package:prestador_final/src/direccion.dart';
import 'package:prestador_final/src/usuario.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class ListaTrabajosPresupuestoPage extends StatefulWidget {
  ListaTrabajosPresupuestoPage({Key key}) : super(key: key);

  @override
  _ListaTrabajosPresupuestoPageState createState() =>
      _ListaTrabajosPresupuestoPageState();
}

class _ListaTrabajosPresupuestoPageState extends State<ListaTrabajosPresupuestoPage> {
  final Color mainColor = const Color(0xff3C3261);
  bool isSwitched = true;
  Location location;
  LocationData currentLocation;
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
              'Apagar pedidos presupuesto:',
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
            .collection('PedidosPresupuesto')
            .where("Disponible", isEqualTo: 'true')
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
                                    new Text(
                                      "Fecha: "+document["Fecha"]+" Hora: "+document['Hora'],
                                      maxLines: 3,
                                      style: new TextStyle(
                                          color: const Color(0xff8785A4),
                                          fontFamily: 'Arvo'),
                                    ),
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
                                          context, 'detallesPresupuesto',
                                          arguments: ArgumentosmUrgentes(document['Titulo'],document['Descripcion'],document.documentID,document['Pedido'],document['Identificador']));
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
