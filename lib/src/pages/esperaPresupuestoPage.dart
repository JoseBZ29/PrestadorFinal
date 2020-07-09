import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prestador_final/page.dart';
import 'package:prestador_final/pedido.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../argumentosUrgentes.dart';

class EsperaPresupuestoPage extends StatefulWidget {
  EsperaPresupuestoPage({Key key}) : super(key: key);

  @override
  _EsperaPresupuestoPageState createState() => _EsperaPresupuestoPageState();
}

class _EsperaPresupuestoPageState extends State<EsperaPresupuestoPage> {
  ubicacion(a, b) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
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
              .collection('PedidosPresupuesto')
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
                            child: Text(
                                'El usuario a aceptado el trabajo. Espera a que el usuario haga el pago. Este pago solo sera liberado hasta que el servicio finalice.'));
                      } else if (document['EstadoPago'] == 'aceptado') {
                        return Center(
                            child: Column(
                          children: <Widget>[
                            Text(
                                'El usuario a aceptado el trabajo y el pago ha sido aceptado. A continucación te daremos la ubicación del servicio.'),
                            FlatButton(
                                onPressed: () async {
                                  ubicacion(document['a'], document['b']);
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.setString(
                                      'peerID', document['Identificador']);
                                  pref.setString('pedido', document.documentID);
                                  String d = document.documentID;
                                  print('Identificador chat $d');
                                  String sdsd = pref.getString('pedido');
                                  print('Pref: $sdsd');
                                  pref.setString('qr', document['QR']);
                                  pref.setString(
                                      'Identificador', document.documentID);
                                  pref.setString(
                                      'peerID', document['Identificador']);
                                  pref.setString(
                                      'servicioEnCursoPresupuesto', 'true');
                                  Navigator.pushNamed(context, 'mapa',
                                      arguments:
                                          PageAr('servicioEnCursoPresupuesto'));
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
                              'El usuario revisará la propuesta. Nosotros te notificaremos si fue aceptada.'),
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
