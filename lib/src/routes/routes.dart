import 'package:flutter/material.dart';
import 'package:prestador_final/src/pages/ayuda_page.dart';
import 'package:prestador_final/src/pages/detallesCotizacion.dart';
import 'package:prestador_final/src/pages/detallesPresupuesto.dart';
import 'package:prestador_final/src/pages/detallesUrgente.dart';
import 'package:prestador_final/src/pages/esperaPage.dart';
import 'package:prestador_final/src/pages/esperaPresupuestoPage.dart';
import 'package:prestador_final/src/pages/forgotPassword_page.dart';
import 'package:prestador_final/src/pages/home_page.dart';
import 'package:prestador_final/src/pages/inicio.dart';
import 'package:prestador_final/src/pages/lista_trabajos.dart';
import 'package:prestador_final/src/pages/lista_trabajosPresupuesto.dart';
import 'package:prestador_final/src/pages/lista_trabajosUrgentes.dart';
import 'package:prestador_final/src/pages/login_page.dart';
import 'package:prestador_final/src/pages/map_page.dart';
import 'package:prestador_final/src/pages/micuenta_page.dart';
import 'package:prestador_final/src/pages/pago_page.dart';
import 'package:prestador_final/src/pages/quienesSomos_page.dart';
import 'package:prestador_final/src/pages/rapidos.dart';
import 'package:prestador_final/src/pages/registerCuentaBan.dart';
import 'package:prestador_final/src/pages/registerForm2_page.dart';
import 'package:prestador_final/src/pages/registerForm3_page.dart';
import 'package:prestador_final/src/pages/registerForm4_page.dart';
import 'package:prestador_final/src/pages/registerForm5_page.dart';
import 'package:prestador_final/src/pages/registerForm6_page.dart';
import 'package:prestador_final/src/pages/registerForm7_page.dart';
import 'package:prestador_final/src/pages/registerFormCel_page.dart';
import 'package:prestador_final/src/pages/registerLoc.dart';
import 'package:prestador_final/src/pages/register_page.dart';
import 'package:prestador_final/src/pages/servicioEnCursoPage.dart';
import 'package:prestador_final/src/pages/servicioEnCursoPageCotizacion.dart';
import 'package:prestador_final/src/pages/servicioEnCursoPagePresupuesto.dart';
import 'package:prestador_final/src/pages/validacionEx.dart';
import 'package:prestador_final/src/pages/validacion_cel.dart';
import 'package:prestador_final/src/widgets/pdf.dart';
import 'package:prestador_final/src/widgets/webView_widget.dart';

Map<String,WidgetBuilder> getAplicationRoute(){


  return <String, WidgetBuilder>{
        'register'      :(BuildContext context)=> RegisterPage(),
        'registerCel'    :(BuildContext context)=>RegisterFormCelPage(),
        'register2'     :(BuildContext context)=>RegisterForm2Page(),
        'register3'     :(BuildContext context)=>RegisterPage3Page(),
        'register4'     :(BuildContext context)=>RegisterForm4Page(),
        'register5'     :(BuildContext context)=>RegisterForm5Page(),
        'register6'     :(BuildContext context)=>RegisterForm6Page(),
        'register7'     :(BuildContext context)=>RegisterForm7Page(),
        'login'         :(BuildContext context)=> LoginPage(),
        'homePage'      :(BuildContext context)=>MyHomePage(),
        'forgotPassword' :(BuildContext context)=>ForgotPasswordPage(),
        'cuenta'         :(BuildContext context) => MiCuentaPage(),
        'pagos'          :(BuildContext context) => PagoPage(),
        'ayuda'          :(BuildContext context) => AyudaPage(),
        'quinesSomos'    :(BuildContext context) => QuienesSomosPage(),
        'listaTrabajo'   :(BuildContext context)=>ListaTrabajosPage(),
        'listaTrabajosUrgentes' :(BuildContext context)=>ListaTrabajosUrgentesPage(),
        'mapa'           :(BuildContext context)=>MapPage(),
        'detallesUrgente'   :(BuildContext context)=>DetallesUrgentePage(),
        'esperaPage'        :(BuildContext context)=>EsperaPage(),
        'servicioEnCurso'   :(BuildContext context)=>ServicioEnCursoPage(),
        'pedidosPresupuesto'    :(BuildContext context)=>ListaTrabajosPresupuestoPage(),
        'detallesPresupuesto'     :(BuildContext context)=>DetallesPresupuestoPage(),
        'esperaPresupuesto'     :(BuildContext context)=>EsperaPresupuestoPage(),
        'detallesCotizacion'    :(BuildContext context)=>DetallesCotizacionPage(),
        'servicioEnCursoCot'    :(BuildContext context)=>ServicioEnCursoCotizacionPage(),
        'validarCel'        :(BuildContext context)=>ValidarCelPage(),
        'validacionExitosa'   :(BuildContext context)=>ValidacionExitosa(),
        'registerLoc'         :(BuildContext context)=>RegisterLoc(),
        'registerCuentaBan'   :(BuildContext context)=>RegisterCuentaBan(),
        'inicio'      :(BuildContext context)=>InicioDPage(),
        'servicioEnCursoPresupuesto'    :(BuildContext context)=>ServicioEncursoPresupuestoPage(),
        'pdf'     :(BuildContext context)=>PDFPage(),
        'serviciosRapidos' :(BuildContext context)=>RapidosPage()
        
};

}