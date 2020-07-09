import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prestador_final/page.dart';
import 'package:prestador_final/pedido.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../argumentosUrgentes.dart';

class EsperaPage extends StatefulWidget {
  EsperaPage({Key key}) : super(key: key);

  @override
  _EsperaPageState createState() => _EsperaPageState();
}

class _EsperaPageState extends State<EsperaPage> {
  String id;

  ubicacion(a, b, qr) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('qr', qr);
    pref.setDouble('a', a);
    pref.setDouble('b', b);
  }

  @override
  Widget build(BuildContext context) {
    final Pedido args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('En espera'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 164, 171, 0.9),
      ),
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('PedidosUrgentes')
              .where("Identificador", isEqualTo: args.identificador)
              .where('Pedido', isEqualTo: args.pedido)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data == null) return new Text('saasas');
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    if (document['EstadoPedido'] == 'aceptado') {
                      if (document['EstadoPago'] == 'pendiente') {
                        return Center(
                            child: Column(
                          children: <Widget>[
                            Text(
                                'El usuario a aceptado el trabajo. Espera a que el usuario haga el pago. Este pago solo sera liberado hasta que el servicio finalice.'),
                          ],
                        ));
                      } else if (document['EstadoPago'] == 'aceptado') {
                        return Center(
                            child: Column(
                          children: <Widget>[
                            Text(
                                'El usuario a aceptado el trabajo y el pago ha sido aceptado. A continucación te daremos la ubicación del servicio.'),
                            FlatButton(
                                onPressed: () async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.setString(
                                      'peerID', document['Identificador']);
                                  ubicacion(document['a'], document['b'],
                                      document['QR']);
                                  pref.setString(
                                      'servicioEnCursoUrgente', 'true');
                                  Navigator.pushNamed(context, 'mapa',
                                      arguments: PageAr('servicioEnCurso'));
                                },
                                child: Text('Entendido'))
                          ],
                        ));
                      }
                    } else if (document['EstadoPedido'] == 'denegado') {
                      return Center(
                          child: Text(
                              'El usuario no acepto el trabajo, puede regresar y mander una nueva cotización'));
                    } else {
                      return Center(
                          child: Column(
                        children: <Widget>[
                          Text(
                              'Esperando a que el usuario acepte o decline la cotizaciòn'),
                          Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 10),
                              child: Image.asset(
                                'assets/Espera.gif',
                              ))
                        ],
                      ));
                    }
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }
}
