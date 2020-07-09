import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pedido.dart';
import '../argumentosUrgentes.dart';

class DetallesUrgentePage extends StatefulWidget {
  DetallesUrgentePage({Key key}) : super(key: key);

  @override
  _DetallesUrgentePageState createState() => _DetallesUrgentePageState();
}

class _DetallesUrgentePageState extends State<DetallesUrgentePage> {
  double total = 0.0;
  double alv = 0.0;
  String descServicio;

  cotizacion(identificador, pedido, iden2) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String nombre = pref.getString('nombre');
    double cal = 3;
    pref.setString('identificador', identificador);
    String idPrestador = pref.getString('identificadorUser');
    await Firestore.instance
        .collection('PedidosUrgentes')
        .document(identificador)
        .updateData({
      "Precio": alv.toString(),
      "Cotizacion": "true",
      "Disponible": "false",
      "Nombre": nombre,
      "DetallesServicio": descServicio,
      "EstadoPedido": "pendiente",
      "Calificacion": cal,
      "Prestador": "$idPrestador"
    });
    print(identificador);
    print(pedido);
    Navigator.pushReplacementNamed(context, 'esperaPage',
        arguments: Pedido(iden2, pedido));
  }

  @override
  Widget build(BuildContext context) {
    final ArgumentosmUrgentes args = ModalRoute.of(context).settings.arguments;
    int pedido = args.pedido;
    String titulo = args.titulo;
    String desc = args.desc;
    String identificador = args.identificador;
    String iden2 = args.iden2;
    return Scaffold(
      appBar: AppBar(
        title: Text('Revisión y Presupuesto'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 164, 171, 0.9),
      ),
      body: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 30,
                  left: MediaQuery.of(context).size.width / 15,
                  right: MediaQuery.of(context).size.width / 15),
              alignment: Alignment.topLeft,
              child: Text('Hola Oscar verifica tu información'),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 100,
                  left: MediaQuery.of(context).size.width / 30,
                  right: MediaQuery.of(context).size.width / 30),
              child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(192, 195, 196, .25), width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, .25), width: 0),
                    ),
                    hintText: "$titulo",
                    fillColor: Colors.grey[200],
                    filled: true,
                  )),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 30,
                  left: MediaQuery.of(context).size.width / 15,
                  right: MediaQuery.of(context).size.width / 15),
              child: Text('Lee los detalles del pedido'),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 6.5,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 100,
                  left: MediaQuery.of(context).size.width / 30,
                  right: MediaQuery.of(context).size.width / 30),
              child: TextField(
                  readOnly: true,
                  scrollPadding: EdgeInsets.all(20),
                  maxLines: 5,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(192, 195, 196, .25), width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, .25), width: 0),
                    ),
                    hintText: "$desc",
                    fillColor: Colors.grey[200],
                    filled: true,
                  )),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 60,
                  left: MediaQuery.of(context).size.width / 15,
                  right: MediaQuery.of(context).size.width / 15),
              child: Text('Envía la información del costo del servicio'),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 100,
                  left: MediaQuery.of(context).size.width / 30,
                  right: MediaQuery.of(context).size.width / 30),
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Flexible(
                      child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            setState(() {
                              total = double.parse(val);
                              alv = (total * .16) + total +50 ;
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(192, 195, 196, .25),
                                  width: 0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, .25),
                                  width: 0),
                            ),
                            hintText: "ej. 1,000.00",
                            fillColor: Colors.grey[200],
                            filled: true,
                          )),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 20),
                      child: Text(
                        'Precios + IVA',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 40),
                      ))
                ],
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
              child: Text(
                'Se le cobrara 25 pesos de comisión de servicio al Profesional y al Usuario',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 50,
                  left: MediaQuery.of(context).size.width / 15,
                  right: MediaQuery.of(context).size.width / 15),
              child: Text(
                'Total:',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 40),
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 100,
                    left: MediaQuery.of(context).size.width / 30,
                    right: MediaQuery.of(context).size.width / 30),
                child: Text(
                  alv.toString(),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 30,
                      color: Color.fromRGBO(59, 164, 171, 0.9)),
                )),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 70,
                  left: MediaQuery.of(context).size.width / 15,
                  right: MediaQuery.of(context).size.width / 15),
              child: Text('Describe lo que incluye tu servicio'),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 100,
                  left: MediaQuery.of(context).size.width / 30,
                  right: MediaQuery.of(context).size.width / 30),
              child: TextField(
                  onChanged: (val) {
                    descServicio = val;
                  },
                  scrollPadding: EdgeInsets.all(20),
                  maxLines: 5,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(192, 195, 196, .25), width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, .25), width: 0),
                    ),
                    hintText: "Descripción del servicio",
                    fillColor: Colors.grey[200],
                    filled: true,
                  )),
            ),
            Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 70),
                child: FlatButton(
                    onPressed: () {
                      cotizacion(identificador, pedido, iden2);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 35,
                        bottom: MediaQuery.of(context).size.width / 35,
                        left: MediaQuery.of(context).size.height / 10,
                        right: MediaQuery.of(context).size.height / 10),
                    color: Color.fromRGBO(59, 164, 171, 0.9),
                    child: Text(
                      'Enviar cotización',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 35,
                          color: Colors.white),
                    )))
          ],
        ),
      ]),
    );
  }
}
