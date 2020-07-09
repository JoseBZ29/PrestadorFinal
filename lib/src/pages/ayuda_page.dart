
import 'package:flutter/material.dart';
import 'package:prestador_final/src/providers/menu_providers_ayuda.dart';

class AyudaPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Ayuda', style:  TextStyle(color: Colors.black),),
      ),
      body: _listaAyuda(),
    );
  }
}

 Widget _listaAyuda() {

    // menuProvider.cargarData()
    return FutureBuilder(
      future: menuProviderAyuda.cargarData(),
      initialData: [],
      builder: ( context, AsyncSnapshot<List<dynamic>> snapshot ){

        return ListView(
          children: _listaItems( snapshot.data, context ),
        );

      },
    );

  

    

  }

  List<Widget> _listaItems( List<dynamic> data, BuildContext context ) {

    final List<Widget> opciones = [];

    data.forEach( (opt) {

      final widgetTemp = ListTile(
        title: Text( opt['texto'] ),

        
        onTap: () {

        }
      );

      
      opciones..add( widgetTemp )
              
              ..add( Divider() );

    });

    return opciones;

  }