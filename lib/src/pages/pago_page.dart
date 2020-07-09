import 'package:flutter/material.dart';
import 'package:prestador_final/src/providers/menu_providers_tarjetas.dart';
import 'package:prestador_final/src/utils/icono_string_util.dart';


class PagoPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PagoPageState();
  }
}


class _PagoPageState extends State<PagoPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        
        title: Text('Pago',style: TextStyle(color: Colors.black),),
      ),
      body: _listaTarjetas(),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

 Widget _listaTarjetas() {

    // menuProvider.cargarData()
    return FutureBuilder(
      future: menuProviderTarjetas.cargarData(),
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
        leading:  getIcon('tarjeta') ,

        
        onTap: () {

        }
      );

      
      opciones..add( widgetTemp )
              
              ..add( Divider() );

    });
    return opciones;

  }