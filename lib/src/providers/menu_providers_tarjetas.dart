import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';


class _MenuProviderTarjetas {

  List<dynamic> tarjetas = [];

  _MenuProviderTarjetas() {
    // cargarData();
  }

  Future<List<dynamic>> cargarData() async {

    final resp = await rootBundle.loadString('data/tarjetas.json');
    
    Map dataMap = json.decode( resp );
    tarjetas = dataMap['tarjetas'];
    
      
    return tarjetas;
  }

}


final menuProviderTarjetas = new _MenuProviderTarjetas(); 