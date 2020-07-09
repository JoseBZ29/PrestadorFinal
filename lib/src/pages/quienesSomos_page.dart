import 'package:flutter/material.dart';

class QuienesSomosPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Quienes Somos', style: TextStyle(color: Colors.black),),
      ),
    );
  }
}