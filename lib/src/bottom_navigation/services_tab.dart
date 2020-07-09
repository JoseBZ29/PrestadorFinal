import 'package:prestador_final/src/pages/Pedidos_Curso.dart' as encurso;
import 'package:prestador_final/src/pages/Pedidos_Terminados_Page.dart'
    as terminados;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesTab extends StatefulWidget {
  @override
  _ServicesTabState createState() => _ServicesTabState();
}

class _ServicesTabState extends State<ServicesTab> {
  var profesiones = [];
  int prof;
  String prof1, prof2, prof3;
  _shared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prof = prefs.getInt('profesiones');
    prof1 = prefs.getString('profesion_1');
    prof2 = prefs.getString('profesion_2');
    prof3 = prefs.getString('profesion_3');
    profesiones = [prof1, prof2, prof3];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((_) {
      setState(() {
        _shared();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
          child: ListView(
        children: _listaItems(context),
      )),
    );
  }

  List<Widget> _listaItems(BuildContext context) {
    List<Widget> opciones = [];
    if (prof == null) {
      final widgetC = Text('cargando');
      opciones.add(widgetC);
      return opciones;
    } else {
      opciones = [];

      for (int i = 0; i <= prof - 1; i++) {
        final widgetTemp = FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, 'listaTrabajo',
                  arguments: profesiones[i]);
            },
            child: Text(profesiones[i]));

        opciones..add(widgetTemp)..add(Divider());
      }

      final widgetOtro = FlatButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'pedidosPresupuesto');
          },
          child: Text('Otros'));
      opciones.add(widgetOtro);
      return opciones;
    }
  }
}
