import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prestador_final/src/pages/quienesSomos_page.dart';
import 'package:prestador_final/src/providers/menu_provider.dart';
import 'package:prestador_final/src/utils/icono_string_util.dart';
import 'package:prestador_final/src/widgets/my_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String nombre;
  _launchURL() async {
    const url = 'https://testemmacrzpflutter.000webhostapp.com/Aviso.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        MyAppBar('$nombre'),
        Expanded(
          child: _lista(),
        )
      ],
    ));
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nombre = prefs.getString('nombre') ?? 'Nombre';
    setState(() {});
  }

  void salir() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('registrado');
  }

  Widget _lista() {
    // menuProvider.cargarData()
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _listaItems(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    data.forEach((opt) {
      final widgetTemp = ListTile(
          title: Text(opt['texto']),
          leading: getIcon(opt['icon']),
          onTap: () {
            Navigator.pushNamed(context, opt['ruta']);

            // final route=MaterialPageRoute(
            //   builder: (context){
            //     return PagoPage();
            //   }
            // );
            // Navigator.push(context, route);
          });

      opciones..add(widgetTemp)..add(Divider());
    });
    //final imagen =
    //Container(
    //margin: EdgeInsets.all(1),
    //padding: EdgeInsets.all(1),
    //child: Image.network('http://via.placeholder.com/150x150'),
    //);
    //opciones.add(imagen);
    final rapidos = ListTile(
      title: Text('Servicios Rápidos'),
      leading: Icon(Icons.flash_on),
      onTap: () {
        //FirebaseAuth.instance.signOut();
        Navigator.pushNamed(context, 'serviciosRapidos');
      },
    );
    opciones.add(rapidos);
    final terminos = ListTile(
      title: Text('Términos y Condiciones'),
      leading: Icon(Icons.find_in_page),
      onTap: () {
        _launchURL();
      },
    );
    opciones.add(terminos);
    final salir = ListTile(
      title: Text('Salir'),
      leading: Icon(Icons.settings_power),
      onTap: () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool('sesion', false);
        //FirebaseAuth.instance.signOut();
        Navigator.pushReplacementNamed(context, 'inicio');
      },
    );
    opciones.add(salir);
    return opciones;
  }
}
