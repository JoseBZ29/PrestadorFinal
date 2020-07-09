import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prestador_final/identifiador.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pedido.dart';
import '../argumentosUrgentes.dart';

String cantidad = "w";
String material = '';
String precio = '';
String manoDeObra = '';
double iva = 0;
double subTotal = 0.0;
double totalFinal = 0;
double a;
double nose;
String b = "0";
int i = 1;
double pre = 0.0;
double parse;
double totalPrecios = 0.0;

Map<int, double> cantidades = {};
Map<int, double> priceFinal = {};
Map<int, double> price = {};
Map<int, String> materiales = {};
Map precios = {};
Map prueba = {};

int _count = 1;
final _formKey = GlobalKey<FormState>();
final _scaffoldKey = GlobalKey<ScaffoldState>();

class DetallesCotizacionPage extends StatefulWidget {
  DetallesCotizacionPage({Key key}) : super(key: key);

  @override
  _DetallesCotizacionPageState createState() => _DetallesCotizacionPageState();
}

class _DetallesCotizacionPageState extends State<DetallesCotizacionPage> {
  String total = '';
  String descServicio;
  String detallesMat;
  String detalleTra;
  String tiempo;
  String precioH = 'false';

  bool _isRegistering = false;

  void _addNewContactRow() {
    print(cantidad);
    if (cantidad.isNotEmpty) {
      setState(() {
        _count = _count + 1;
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('El renglon debe estar lleno'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  precios() {
    setState(() {
      try {
        print(_count);
        print(_count + 1);
        print(cantidades['1']);
        if (i >= _count + 1) {
          print('si');
        }
        for (int i = 1; i <= _count; i++) {
          print('entro for');
          print(i);
          double temp = cantidades[i] * price[i];
          totalPrecios = temp + totalPrecios;
          priceFinal[i] = temp;
          print(i);
          print('Temp: $temp');
        }
        print(priceFinal);
        print('despues');
        nose = double.parse(manoDeObra);
        subTotal = totalPrecios + subTotal;
        subTotal = double.parse(manoDeObra) + subTotal;
        b = subTotal.toString();
        iva = subTotal * 0.16;
        totalFinal = iva + subTotal + 25;
        nose = 0;
        subTotal = 0;
        print(price);
        print(materiales);
        print(cantidades);
        precioH = 'true';
      } catch (e) {
        print(e);
      }
    });
  }

  prueba() {
    print('Cantidades :$cantidades');
    print('Materiales :$materiales');
    print('Precios :$price');
    print('Count :$_count');
    print('totalPrecios :$totalPrecios');
    print('Parse :$parse');
    print('SubTotal :$subTotal');
    print('a :$nose');
    print('Mano :$manoDeObra');
    print(cantidades[1]);
  }

  cotizacion(identificador, iden2, pedido) async {
    if (precioH == 'true') {
      final form = _formKey.currentState;

      if (!form.validate()) {
        _scaffoldKey.currentState.hideCurrentSnackBar();
        setState(() {
          _isRegistering = false;
        });
        return;
      }
      form.save();

      SharedPreferences pref = await SharedPreferences.getInstance();
      String prestador = pref.getString('identificadorUser');
      String nombre = pref.getString('nombre');
      double ubicacionA = pref.getDouble('UbicacionA');
      double ubicacionB = pref.getDouble('UbicacionB');

      Random random = new Random();
      int randomNumber = random.nextInt(1474648) + 13797;
      pref.setString('IdenCot', '$randomNumber-$nombre');
      await Firestore.instance
          .collection('Pedidos')
          .document(identificador)
          .updateData({"Cotizaciones": "true"});
      await Firestore.instance
          .collection('PedidosCotizaciones')
          .document('$randomNumber-$nombre')
          .setData({
        "DetallesMateriales": detallesMat,
        "DetallesTrabajo": detalleTra,
        "tiempo": tiempo,
        "ManoDeObra": manoDeObra,
        "Subtotal": b,
        "IVA": iva,
        "Total": "$totalFinal",
        "CantidadDeMateriales": _count,
        "EstadoPedido": "penndiente",
        "EstadoPago": "pendiente",
        "Calificacion": 4,
        "Disponible": "false",
        "Nombre": "$nombre",
        "Identificador": "$iden2",
        "Pedido": "$pedido",
        "Aceptado": "pendiente",
        "IdentificadorCotizacion": "$randomNumber",
        "IdentificadorPrestador": "$prestador",
        "a": ubicacionA,
        "b": ubicacionB,
      });

      for (int x = 1; x < _count + 1; x++) {
        print('entro a subir');
        print('x:$x');
        print(_count);
        await Firestore.instance
            .collection('PedidosCotizaciones')
            .document('$randomNumber-$nombre')
            .updateData({
          "CantidadMaterial$x": cantidades[x],
          "Material$x": materiales[x],
          "PrecioMaterial$x": priceFinal[x]
        });
        print('sale una $x');
      }
      print(identificador);
      print(pedido);
      _count = 1;
      iva = 0;
      totalFinal = 0;
      b = "";
      AwesomeDialog(
          context: context,
          animType: AnimType.BOTTOMSLIDE,
          headerAnimationLoop: true,
          dialogType: DialogType.SUCCES,
          btnOkColor: Color.fromRGBO(59, 164, 171, 1),
          tittle: 'Listo',
          btnOkText: 'Entendido',
          dismissOnTouchOutside: false,
          desc:
              'La cotizacion se a mandado con exito. Espera a que el cliente la analice y acepte.',
          btnOkOnPress: () {
            debugPrint('OnClcik');
            Navigator.pop(context);
          },
          btnOkIcon: Icons.check_circle,
          onDissmissCallback: () {
            debugPrint('Dialog Dissmiss from callback');
          }).show();
      //Navigator.pushNamed(context, 'esperaPresupuesto',arguments: Pedido(iden2, pedido));
    } else {
      AwesomeDialog(
          context: context,
          animType: AnimType.BOTTOMSLIDE,
          headerAnimationLoop: true,
          dialogType: DialogType.WARNING,
          btnOkColor: Color.fromRGBO(59, 164, 171, 1),
          tittle: 'Espera',
          btnOkText: 'Entendido',
          dismissOnTouchOutside: false,
          desc: 'Debe calcular los precios',
          btnOkOnPress: () {
            debugPrint('OnClcik');
          },
          btnOkIcon: Icons.check_circle,
          onDissmissCallback: () {
            debugPrint('Dialog Dissmiss from callback');
          }).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _contatos =
        new List.generate(_count, (int i) => new ContactRow(_count, i));
    final Identificador args = ModalRoute.of(context).settings.arguments;
    int pedido = args.pedido;
    String identificador = args.identificador;
    String iden2 = args.iden2;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Revisión y Presupuesto'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 164, 171, 0.9),
      ),
      body: ListView(children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 30,
                    left: MediaQuery.of(context).size.width / 15,
                    right: MediaQuery.of(context).size.width / 15),
                alignment: Alignment.topCenter,
                child: Text(
                  'Solicitud de cotización de folio $pedido',
                  style: TextStyle(color: Color.fromRGBO(59, 164, 171, 1)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 30,
                    left: MediaQuery.of(context).size.width / 15,
                    right: MediaQuery.of(context).size.width / 15),
                alignment: Alignment.topCenter,
                child: Text(
                  'Formato de cotización',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 30),
                ),
              ),
              new Container(
                height: 50.0 + (_count * 100),
                child: new ListView(
                  children: _contatos,
                  scrollDirection: Axis.vertical,
                ),
              ),
              Container(
                child: new FlatButton(
                  onPressed: _addNewContactRow,
                  child: new Icon(Icons.add),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 30,
                    left: MediaQuery.of(context).size.width / 15,
                    right: MediaQuery.of(context).size.width / 15),
                child: Text('Describir los materiales'),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 6.5,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 100,
                    left: MediaQuery.of(context).size.width / 30,
                    right: MediaQuery.of(context).size.width / 30),
                child: TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Debe llenar la descripción';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        detallesMat = val;
                      });
                    },
                    scrollPadding: EdgeInsets.all(20),
                    maxLines: 5,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(192, 195, 196, .25),
                            width: 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, .25), width: 0),
                      ),
                      hintText: "Detalles materiales",
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
                child: Text('Describir el trabajo a realizar'),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 6.5,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 100,
                    left: MediaQuery.of(context).size.width / 30,
                    right: MediaQuery.of(context).size.width / 30),
                child: TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return ' Debe llenar la descripción del trabajo';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        detalleTra = val;
                      });
                    },
                    scrollPadding: EdgeInsets.all(20),
                    maxLines: 5,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(192, 195, 196, .25),
                            width: 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, .25), width: 0),
                      ),
                      hintText: "Describir",
                      fillColor: Colors.grey[200],
                      filled: true,
                    )),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 30,
                    left: MediaQuery.of(context).size.width / 15,
                    right: MediaQuery.of(context).size.width / 15),
                alignment: Alignment.topLeft,
                child: Text('Tiempo estimado'),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 100,
                    left: MediaQuery.of(context).size.width / 30,
                    right: MediaQuery.of(context).size.width / 30),
                child: TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Debe llenar el tiempo estimdado';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        tiempo = val;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(192, 195, 196, .25),
                            width: 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, .25), width: 0),
                      ),
                      hintText: "Describir",
                      fillColor: Colors.grey[200],
                      filled: true,
                    )),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 30,
                              left: MediaQuery.of(context).size.width / 15,
                              right: MediaQuery.of(context).size.width / 15),
                          child: Text('Mano de obra'),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 100,
                              left: MediaQuery.of(context).size.width / 30,
                              right: MediaQuery.of(context).size.width / 30),
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Debe llenar la mano de obra';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  manoDeObra = val;
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
                                hintText: "Mano de obra",
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
                          child: Text('IVA'),
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
                                hintText: "$iva",
                                fillColor: Colors.grey[200],
                                filled: true,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 30,
                              left: MediaQuery.of(context).size.width / 15,
                              right: MediaQuery.of(context).size.width / 15),
                          child: Text('Subtotal'),
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
                                hintText: b,
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
                          child: Text('Total'),
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
                                hintText: "$totalFinal",
                                fillColor: Colors.grey[200],
                                filled: true,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 30),
                child: Text(
                  'Al finalizar el trabajo se genera un cargo a su cuenta por Servicios de 25 pesos(M.N.)',
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 70),
                  child: FlatButton(
                      onPressed: () {
                        precios();
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
                        'Calcular precios',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 35,
                            color: Colors.white),
                      ))),
              Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 70),
                  child: FlatButton(
                      onPressed: () {
                        prueba();
                        cotizacion(identificador, iden2, pedido);
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
        ),
      ]),
    );
  }
}

class ContactRow extends StatefulWidget {
  int inc;
  ContactRow(int count, this.inc);
  @override
  State<StatefulWidget> createState() => new _ContactRow(inc);
}

class _ContactRow extends State<ContactRow> {
  int inc;
  _ContactRow(this.inc);
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
        child: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.height / 100,
              right: MediaQuery.of(context).size.height / 100),
          child: Form(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(child: Text('Cantidad')),
                      Container(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height / 40,
                            left: MediaQuery.of(context).size.height / 40,
                            top: MediaQuery.of(context).size.height / 60,
                            bottom: MediaQuery.of(context).size.height / 60),
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              setState(() {
                                print(inc + 1);
                                cantidades[inc + 1] = double.parse(val);
                                cantidad = val;
                              });
                            },
                            textAlign: TextAlign.center,
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
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 0, 0, .25),
                                    width: 0),
                              ),
                              hintText: "#",
                              fillColor: Colors.grey[200],
                              filled: true,
                            )),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text('Materiales'),
                      Container(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height / 200,
                            left: MediaQuery.of(context).size.height / 200,
                            top: MediaQuery.of(context).size.height / 60,
                            bottom: MediaQuery.of(context).size.height / 60),
                        child: TextField(
                            onChanged: (val) {
                              setState(() {
                                materiales[inc + 1] = val;
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
                              hintText: "Materiales",
                              fillColor: Colors.grey[200],
                              filled: true,
                            )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(children: <Widget>[
                    Text('Precio'),
                    Container(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.height / 70,
                          left: MediaQuery.of(context).size.height / 70,
                          top: MediaQuery.of(context).size.height / 60,
                          bottom: MediaQuery.of(context).size.height / 60),
                      child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            setState(() {
                              print(val);
                              price[inc + 1] = double.parse(val);
                              //prueba['$_count'] = val;
                              //totalPrecios = double.parse(val) + totalPrecios;
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
                            hintText: "Precio",
                            fillColor: Colors.grey[200],
                            filled: true,
                          )),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
