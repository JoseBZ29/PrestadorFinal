import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:prestador_final/src/widgets/webView_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class InicioDPage extends StatefulWidget {
  InicioDPage({Key key}) : super(key: key);

  @override
  _InicioPageDState createState() => _InicioPageDState();
}

class _InicioPageDState extends State<InicioDPage> {
  _launchURL() async {
    const url = 'https://testemmacrzpflutter.000webhostapp.com/Aviso.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL2() async {
    const url = 'https://testemmacrzpflutter.000webhostapp.com/Aviso.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(31, 56, 96, 1),
        title: Text(
          '!Bienvenido!',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(children: <Widget>[
        Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Back.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 10),
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        color: Color.fromRGBO(31, 56, 96, 1),
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 50,
                            bottom: MediaQuery.of(context).size.height / 50,
                            left: MediaQuery.of(context).size.width / 4,
                            right: MediaQuery.of(context).size.width / 4),
                        onPressed: () {
                          AwesomeDialog(
                              context: context,
                              animType: AnimType.BOTTOMSLIDE,
                              headerAnimationLoop: true,
                              dialogType: DialogType.INFO,
                              btnOkColor: Color.fromRGBO(59, 164, 171, 1),
                              tittle: 'Espera',
                              btnOkText: 'Entendido',
                              dismissOnTouchOutside: true,
                              btnCancel: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)),
                                  color: Colors.red,
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          50,
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              50,
                                      left: MediaQuery.of(context).size.width /
                                          35,
                                      right: MediaQuery.of(context).size.width /
                                          35),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancelar',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                35,
                                        color: Colors.white,
                                      ))),
                              btnOk: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)),
                                  color: Colors.green,
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          50,
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              50,
                                      left:
                                          MediaQuery.of(context).size.width / 35,
                                      right: MediaQuery.of(context).size.width / 35),
                                  onPressed: () {
                                    debugPrint('OnClcik');
                                    Navigator.pushNamed(context, 'register');
                                  },
                                  child: Text('Aceptar',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                35,
                                        color: Colors.white,
                                      ))),
                              btnOkIcon: Icons.check_circle,
                              body: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Al continuar con el proceso de registro aceptas nuestro Términos y Condiciones así como nuestro Aviso de Privacidad.',
                                    textAlign: TextAlign.center,
                                  ),
                                  FlatButton(
                                      onPressed: () {
                                        _launchURL();
                                      },
                                      child:
                                          Text('Ver Términos y Condiciones')),
                                  FlatButton(
                                      onPressed: () {
                                        _launchURL2();
                                      },
                                      child: Text('Ver Aviso de Privacidad'))
                                ],
                              ),
                              onDissmissCallback: () {
                                debugPrint('Dialog Dissmiss from callback');
                              }).show();
                        },
                        child: Text('Registrarme',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 35,
                              color: Colors.white,
                            ))),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 5),
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        color: Color.fromRGBO(31, 56, 96, 1),
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 50,
                            bottom: MediaQuery.of(context).size.height / 50,
                            left: MediaQuery.of(context).size.width / 5,
                            right: MediaQuery.of(context).size.width / 5),
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: Text('Ya tengo cuenta',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 35,
                              color: Colors.white,
                            ))),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 30),
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        color: Color.fromRGBO(59, 164, 171, 1),
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 50,
                            bottom: MediaQuery.of(context).size.height / 50,
                            left: MediaQuery.of(context).size.width / 2.8,
                            right: MediaQuery.of(context).size.width / 2.8),
                        onPressed: () {
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
                        },
                        child: Text('Salir',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 35,
                              color: Colors.white,
                            ))),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 20),
                      child: Image.asset(
                        'assets/logo_splash.png',
                        scale: 1.5,
                      )),
                ],
              ),
            )),
      ]),
    );
  }
}
