import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppBar extends StatelessWidget {

  String nombre;

  MyAppBar(String nombre){
    this.nombre = nombre;
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .02),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.height * 0.10,
            height: MediaQuery.of(context).size.width * 0.20,
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/2.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
          Container(
            child: Wrap(
              direction: Axis.vertical,
              children: <Widget>[
                Text(
                  'Hola $nombre',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
                Text('¿En qué podemos ayudarte?',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035),
                    textAlign: TextAlign.start)
              ],
            ),
          )
        ],
      ),
    );
  }
}
