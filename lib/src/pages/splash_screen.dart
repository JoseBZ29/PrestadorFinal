import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:prestador_final/src/pages/inicio.dart';
import 'package:prestador_final/src/pages/inicio_page.dart';
import 'package:prestador_final/src/pages/registerForm2_page.dart';
import 'package:prestador_final/src/pages/registerForm3_page.dart';
import 'package:prestador_final/src/pages/registerForm5_page.dart';
import 'package:prestador_final/src/pages/registerFormCel_page.dart';
import 'package:prestador_final/src/pages/register_page.dart';
import 'package:prestador_final/src/pages/servicioEnCursoPage.dart';
import 'package:prestador_final/src/pages/servicioEnCursoPageCotizacion.dart';
import 'package:prestador_final/src/pages/servicioEnCursoPagePresupuesto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  Widget _rootPage = RegisterPage();
  Future<Widget> getRootPage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool sesion = pref.getBool('sesion');
    String servicio = pref.getString('servicioEnCursoUrgente');
    String servicioPresupuesto = pref.getString('servicioEnCursoPresupuesto');
    String servicioCotizacion = pref.getString('servicioEnCursoCotizacion');
    //String servicio='true';
    //Future.delayed(Duration(seconds: 10));
    if (sesion == true) {
      if (servicio == 'true') {
        return ServicioEnCursoPage();
      } else if (servicioPresupuesto == 'true') {
        return ServicioEncursoPresupuestoPage();
      } else if (servicioCotizacion == 'true') {
        return ServicioEnCursoCotizacionPage();
      } else {
        return MyHomePage();
      }
    } else {
      return InicioDPage();
    }
  }

  @override
  initState() {
    super.initState();
    getRootPage().then((Widget page) {
      setState(() {
        _rootPage = page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplash(
      imagePath: 'assets/logo_splash.png',
      home: _rootPage,
      duration: 2500,
      type: AnimatedSplashType.StaticDuration,
    );
  }
}
