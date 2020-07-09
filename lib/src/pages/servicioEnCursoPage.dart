import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicioEnCursoPage extends StatefulWidget {
  ServicioEnCursoPage({Key key}) : super(key: key);

  @override
  _ServicioEnCursoPageState createState() => _ServicioEnCursoPageState();
}

class _ServicioEnCursoPageState extends State<ServicioEnCursoPage> {
  finalizarQR(qr) async {
    String futureString = '';
    String groupChatId;

    //google.com
    //geo:40.70445566532265,-74.0155543371094

    try {
      futureString = await BarcodeScanner.scan();
      AlertDialog(title: Text('adiossss'));
    } catch (e) {
      futureString = e.toString();
    }
    print('Future String: $futureString');

    if (qr == futureString) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String identificador = pref.getString('identificador');
      await Firestore.instance
          .collection('PedidosUrgentes')
          .document(identificador)
          .updateData({"EstadoQRFinalizar": "validado"});
      String id = pref.getString('identificadorUser');
      String peerId = pref.getString('peerID');
      groupChatId = '$id-$peerId';
      print(groupChatId);
      await Firestore.instance
          .collection('messages')
          .document(groupChatId)
          .collection(groupChatId)
          .getDocuments()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.documents) {
          doc.reference.delete();
        }
      });
      AwesomeDialog(
          context: context,
          animType: AnimType.BOTTOMSLIDE,
          headerAnimationLoop: true,
          dialogType: DialogType.SUCCES,
          btnOkColor: Color.fromRGBO(59, 164, 171, 1),
          tittle: '¡Listo!',
          btnOkText: 'Entendido',
          dismissOnTouchOutside: false,
          desc: 'Se ha validado el codigo QR, el servicio ha finalizado',
          btnOkOnPress: () async {
            debugPrint('OnClcik');
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString('servicioEnCursoUrgente', 'false');
            Navigator.pushReplacementNamed(context, 'homePage');
          },
          btnOkIcon: Icons.check_circle,
          onDissmissCallback: () {
            debugPrint('Dialog Dissmiss from callback');
          }).show();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hubo un error en la validacion del codigo QR'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cerrar'))
              ],
            );
          });
    }
  }

  modal() {
    AwesomeDialog(
        context: context,
        animType: AnimType.BOTTOMSLIDE,
        headerAnimationLoop: true,
        dialogType: DialogType.WARNING,
        btnOkColor: Color.fromRGBO(59, 164, 171, 1),
        tittle: 'Finalizar servicio',
        btnOk: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          onPressed: () async {
            String qr;
            SharedPreferences pref = await SharedPreferences.getInstance();
            String identificador = pref.getString('identificador');
            await Firestore.instance
                .collection('PedidosUrgentes')
                .document(identificador)
                .get()
                .then((document) {
              qr = document['QRFinalizar'];
              print(qr);
              Navigator.pop(context);
              finalizarQR(qr);
            });
          },
          child: Text(
            'Entendido',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 50,
                color: Colors.white),
          ),
          color: Color.fromRGBO(59, 164, 171, 1),
        ),
        btnCancel: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancelar',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 45,
                color: Colors.white),
          ),
          color: Colors.red,
        ),
        dismissOnTouchOutside: false,
        desc:
            '¿Esta usted seguro que quiere finalizar el servicio?, para finalizarlo le pediremos que nuevamente escanee el codigo QR',
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        }).show();
  }

  _scanQR() async {
    String futureString = '';

    //google.com
    //geo:40.70445566532265,-74.0155543371094

    try {
      futureString = await BarcodeScanner.scan();
      AlertDialog(title: Text('adiossss'));
    } catch (e) {
      futureString = e.toString();
    }
    print('Future String: $futureString');
    SharedPreferences pref = await SharedPreferences.getInstance();
    String qr = pref.getString('qr');

    if (qr == futureString) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String identificador = pref.getString('identificador');
      await Firestore.instance
          .collection('PedidosUrgentes')
          .document(identificador)
          .updateData({"EstadoQR": "validado"});
      AwesomeDialog(
          context: context,
          animType: AnimType.BOTTOMSLIDE,
          headerAnimationLoop: true,
          dialogType: DialogType.SUCCES,
          btnOkColor: Color.fromRGBO(59, 164, 171, 1),
          tittle: '¡Listo!',
          btnOkText: 'Entendido',
          dismissOnTouchOutside: false,
          desc: 'Se ha validado el codigo QR',
          btnOkOnPress: () async {
            debugPrint('OnClcik');
            Navigator.of(context).pop();
          },
          btnOkIcon: Icons.check_circle,
          onDissmissCallback: () {
            debugPrint('Dialog Dissmiss from callback');
          }).show();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hubo un error en la validacion del codigo QR'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cerrar'))
              ],
            );
          });
    }

    // if(futureString !=null){
    //   print('Tenemos informacion');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(59, 164, 171, 1),
          title: Text('Servicio en curso'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[upperHalf(context), list(context)],
            ),
          ),
        ));
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/Back.png',
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget list(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
              child: FlatButton(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 80,
                      bottom: MediaQuery.of(context).size.height / 80,
                      left: MediaQuery.of(context).size.height / 5.5,
                      right: MediaQuery.of(context).size.height / 5.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  color: Color.fromRGBO(173, 49, 56, 1),
                  onPressed: () async {
                    Email email = Email(
                        to: ['merecomiendanmx@gmail.com'],
                        subject: 'Queja',
                        body: 'Explica tú situación');
                    await EmailLauncher.launch(email);
                  },
                  child: Text(
                    'Queja',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        color: Colors.white),
                  )),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
              child: FlatButton(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 80,
                      bottom: MediaQuery.of(context).size.height / 80,
                      left: MediaQuery.of(context).size.height / 14,
                      right: MediaQuery.of(context).size.height / 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  color: Colors.orange,
                  onPressed: () {
                    AwesomeDialog(
                        context: context,
                        animType: AnimType.BOTTOMSLIDE,
                        headerAnimationLoop: true,
                        dialogType: DialogType.INFO,
                        btnOkColor: Color.fromRGBO(59, 164, 171, 1),
                        tittle: 'Espera',
                        btnOkText: 'Entendido',
                        dismissOnTouchOutside: false,
                        desc:
                            'Los ajustes de presupuesto seran en efectivo y serán acordados físicamente.',
                        btnOkOnPress: () {
                          debugPrint('OnClcik');
                        },
                        btnOkIcon: Icons.check_circle,
                        onDissmissCallback: () {
                          debugPrint('Dialog Dissmiss from callback');
                        }).show();
                  },
                  child: Text(
                    'Ajustar presupuesto',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        color: Colors.white),
                  )),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
              child: FlatButton(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 80,
                      bottom: MediaQuery.of(context).size.height / 80,
                      left: MediaQuery.of(context).size.height / 14,
                      right: MediaQuery.of(context).size.height / 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  color: Color.fromRGBO(54, 77, 108, 1),
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    String identificador = pref.getString('identificadorUser');
                    String peerID = pref.getString('peerID');
                    String pedido = pref.getString('pedido');
                    print('Pedido antes con: $pedido');
                    print(identificador);
                    //enUuNyY91Defw5YmrXAfSQyjFtX2
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Chat(
                                peerId: peerID,
                                currentUserId: identificador,
                                peerName: 'Chat',
                                peerAvatar:
                                    'assets/home/servicios_urgente/albanil.jpg',
                              )),
                    );
                  },
                  child: Text(
                    'Iniciar conversación',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        color: Colors.white),
                  )),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
              child: FlatButton(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 80,
                      bottom: MediaQuery.of(context).size.height / 80,
                      left: MediaQuery.of(context).size.height / 14,
                      right: MediaQuery.of(context).size.height / 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  color: Colors.orange,
                  onPressed: () {
                    _scanQR();
                  },
                  child: Text(
                    'Leer QR',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        color: Colors.white),
                  )),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
              child: FlatButton(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 80,
                      bottom: MediaQuery.of(context).size.height / 80,
                      left: MediaQuery.of(context).size.height / 11,
                      right: MediaQuery.of(context).size.height / 11),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  color: Color.fromRGBO(59, 164, 171, 1),
                  onPressed: () {
                    modal();
                  },
                  child: Text(
                    'Finalizar servicio',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
