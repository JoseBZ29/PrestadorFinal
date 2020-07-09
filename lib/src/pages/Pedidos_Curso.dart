import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prestador_final/page.dart';
import 'package:prestador_final/src/widgets/listCell_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pedido.dart';

class Curso extends StatefulWidget {
  String iden;
  Curso(this.iden);
  @override
  _CursoState createState() => _CursoState(iden);
}

class _CursoState extends State<Curso> {
  String iden;
  _CursoState(this.iden);
  final Color mainColor = const Color(0xff3C3261);

  @override
  Widget build(BuildContext context) {
    print(iden);
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('PedidosCotizaciones')
          .where("IdentificadorPrestador", isEqualTo: iden)
          .where('Aceptado', isEqualTo: 'aceptado')
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
                          if (document['EstadoPago'] == 'pendiente') {
                            AwesomeDialog(
                                context: context,
                                animType: AnimType.BOTTOMSLIDE,
                                headerAnimationLoop: true,
                                dialogType: DialogType.ERROR,
                                btnOkColor: Color.fromRGBO(59, 164, 171, 1),
                                tittle: 'Espera',
                                btnOkText: 'Entendido',
                                dismissOnTouchOutside: false,
                                desc: 'El usuario aun no ha realizado el pago.',
                                btnOkOnPress: () {
                                  debugPrint('OnClcik');
                                },
                                btnOkIcon: Icons.check_circle,
                                onDissmissCallback: () {
                                  debugPrint('Dialog Dissmiss from callback');
                                }).show();
                          } else if (document['EstadoPago'] == 'aceptado') {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.setDouble('a', document['a']);
                            pref.setDouble('b', document['b']);
                            pref.setString('qr', document['QR']);
                            pref.setString('servicioEnCursoCotizacion', 'true');
                            Navigator.pushNamed(context, 'mapa',
                                arguments: PageAr('servicioEnCursoCot'));
                          }
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
                              ),
                            ),
                            new Expanded(
                                child: new Container(
                              margin: const EdgeInsets.fromLTRB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: new Column(
                                children: [
                                  new Text(
                                    '#' + document['Pedido'],
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Arvo',
                                        fontWeight: FontWeight.bold,
                                        color: mainColor),
                                  ),
                                  new Padding(
                                      padding: const EdgeInsets.all(2.0)),
                                  new Text(
                                    document['Total'],
                                    maxLines: 3,
                                    style: new TextStyle(
                                        color: const Color(0xff8785A4),
                                        fontFamily: 'Arvo'),
                                  ),
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
    );
  }
}
