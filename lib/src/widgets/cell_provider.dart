import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';


class _ListProvider {

  List<dynamic> opciones = [];

  _ListProvider() {
    // cargarData();
  }

  Future<List<dynamic>> cargarData() async {

    final resp = await rootBundle.loadString('data/call.json');
    
    Map dataMap = json.decode( resp );
    opciones = dataMap['cell'];
    
      
    return opciones;
  }

}


final cell_provider = new _ListProvider(); 