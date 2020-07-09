import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';


class _ProviderServicios {

  List<dynamic> opciones = [];

  _ProviderServicios() {
    // cargarData();
  }

  Future<List<dynamic>> cargarData() async {

    final resp = await rootBundle.loadString('data/servicios.json');
    
    Map dataMap = json.decode( resp );
    opciones = dataMap['estados'];
    
      
    return opciones;
  }

}

final providerServicios = new _ProviderServicios(); 