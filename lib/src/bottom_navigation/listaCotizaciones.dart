import 'package:prestador_final/src/pages/Pedidos_Curso.dart' as encurso;
import 'package:prestador_final/src/pages/Pedidos_Terminados_Page.dart'
    as terminados;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaCotizaciones extends StatefulWidget {
  @override
  _ListaCotizacionesState createState() => _ListaCotizacionesState();
}

class _ListaCotizacionesState extends State<ListaCotizaciones>
    with SingleTickerProviderStateMixin {
  TabController controller;

  String iden = '';
  identificador() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      iden = pref.getString('identificadorUser');
    });
    print(iden);
  }

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
    identificador();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: TabBar(
        indicatorColor: Colors.indigoAccent,
        controller: controller,
        tabs: [
          Tab(
            child: Text(
              'Cotizaciones pendientes',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Tab(
            child: Text(
              'Cotizaciones aceptadas',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      body: new TabBarView(controller: controller, children: <Widget>[
        new terminados.Terminados(iden),
        new encurso.Curso(iden)
      ]),
    );
  }
}
