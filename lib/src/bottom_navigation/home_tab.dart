import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String nombre;
  int profesiones;
  Timer _timer;
  bool isSwitched = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Si quieres ver los trabajos en vivo, pulsa este boton.'),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  Navigator.pushReplacementNamed(
                      context, 'listaTrabajosUrgentes');
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
            // Text('Si quieres ver los trabajos de presupuestos, pulsa este boton.'),
            // Switch(
            //   value: isSwitched,
            //   onChanged: (value){
            //     setState(() {
            //       isSwitched=value;
            //       Navigator.pushReplacementNamed(context, 'pedidosPresupuesto');
            //     });
            //   },
            //   activeTrackColor: Colors.lightGreenAccent,
            //   activeColor: Colors.green,
            // ),
          ],
        ),
      ),
    );
  }
}
