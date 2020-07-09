import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prestador_final/identifiador.dart';
import 'package:prestador_final/pedido.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaTrabajosPage extends StatefulWidget {
  ListaTrabajosPage({Key key}) : super(key: key);

  @override
  _ListaTrabajosPageState createState() => _ListaTrabajosPageState();
}

class _ListaTrabajosPageState extends State<ListaTrabajosPage> {
  final dbRef = Firestore.instance.collection('Pedidos');
  var lists;
  final Color mainColor = const Color(0xff3C3261);
  @override
  Widget build(BuildContext context) {
    final String profesion = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('Pedidos')
            .where("Profesion", isEqualTo: profesion)
            .where('Disponible',isEqualTo: 'true')
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
                          onPressed: () async {
                            SharedPreferences pref=await SharedPreferences.getInstance();
                            pref.setDouble('UbicacionA', document['a']);
                            pref.setDouble('UbicacionB', document['b']);
                            Navigator.pushNamed(context, 'detallesCotizacion',arguments: Identificador(document.documentID,document['Identificador'],document['Pedido']));
                            
                          },
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
                                    color: Colors.grey,
                                    image: new DecorationImage(
                                        image: new NetworkImage(
                                            document['Imagen']),
                                        fit: BoxFit.cover),
                                    boxShadow: [
                                      new BoxShadow(
                                          color: mainColor,
                                          blurRadius: 5.0,
                                          offset: new Offset(2.0, 5.0))
                                    ],
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
                                    new Text(
                                      document['Descripcion'],
                                      maxLines: 3,
                                      style: new TextStyle(
                                          color: const Color(0xff8785A4),
                                          fontFamily: 'Arvo'),
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              )),
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
}
