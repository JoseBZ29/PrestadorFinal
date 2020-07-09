import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';


class _MenuProviderAyuda {

  List<dynamic> ayuda = [];

  _MenuProviderAyuda() {
    // cargarData();
  }

  Future<List<dynamic>> cargarData() async {

    final resp = await rootBundle.loadString('data/ayuda.json');
    
    Map dataMap = json.decode( resp );
    ayuda = dataMap['tarjetas'];
    
      
    return ayuda;
  }

}


final menuProviderAyuda = new _MenuProviderAyuda(); 