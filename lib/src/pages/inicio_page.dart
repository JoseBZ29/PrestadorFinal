import 'package:flutter/material.dart';

class InicioPage extends StatefulWidget {
  InicioPage({Key key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Text('Proximamente!!!'),
      ),
    );
  }
}