import 'package:flutter/material.dart';
import 'package:prestador_final/identifiador.dart';
import 'package:prestador_final/pedido.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PruebasPage extends StatefulWidget {
  PruebasPage({Key key}) : super(key: key);

  @override
  _PruebasPageState createState() => _PruebasPageState();
}

class _PruebasPageState extends State<PruebasPage> {
  String id;
  modalOriginal(BuildContext context) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(
              "Orden de servicio generada",
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: MediaQuery.of(context).size.height / 5.5,
              child: Column(
                children: <Widget>[
                  Text(
                    'Se ha generado la orden de pago con el número de folio x8620 el 15/02/2020 por la cantidad de:',
                    style: TextStyle(color: Color.fromRGBO(59, 164, 171, 1)),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 40),
                      child: Text('1,000.00 IVA incluido',
                          style: TextStyle(
                              color: Color.fromRGBO(59, 164, 171, 1))))
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: RaisedButton(
                  color: Color.fromRGBO(59, 164, 171, 1),
                  child: Text(
                    "Entendido",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        FlatButton(
            onPressed: () {
              modalOriginal(context);
            },
            child: Text('Modal original')),
        FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, 'servicioEnCurso');
            },
            child: Text('Botones Page')),
        FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, 'ajustePresupuesto');
            },
            child: Text('Ajuste presupuesto')),
        FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, 'aceptarPresupuesto');
            },
            child: Text('Aceptar presupuesto')),
        FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, 'finalizarServicio');
            },
            child: Text('Finalizar servicio')),
        FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, 'servicePresupuesto',
                  arguments: 'Servicio con presupuesto');
            },
            child: Text('Servicio con presupuesto')),
        FlatButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              id = prefs.getString('identificadorUser') ?? '';
              print(id);
            },
            child: Text('asas')),
        FlatButton(
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setDouble('a', 20.559260);
              pref.setDouble('b', -100.434535);
              Navigator.pushNamed(context, 'esperaPage', arguments: Pedido('asas', 1212));
            },
            child: Text('Mapa'))
      ],
    ));
  }
}
