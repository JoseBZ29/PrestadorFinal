import 'package:flutter/material.dart';
import 'package:prestador_final/src/widgets/cell_provider.dart';


class ListCell extends StatelessWidget{

  final Color mainColor = const Color(0xff3C3261);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _lista()
      ],
    );

  }

  Widget _lista() {

    // menuProvider.cargarData()
    return FutureBuilder(
      future: cell_provider.cargarData(),
      initialData: [],
      builder: ( context, AsyncSnapshot<List<dynamic>> snapshot ){
        return Column(
          children:  _listaItems( snapshot.data, context ),
        );
      },
    );
  }

  List<Widget> _listaItems( List<dynamic> data, BuildContext context ) {
    final List<Widget> opciones = [];
    data.forEach( (opt) {
      final widgetTemp =
         FlatButton(
           onPressed: (){},
         child: Row(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(0.0),
              child: new Container(
                margin: const EdgeInsets.all(16.0),
                child: new Container(
                  width: 70.0,
                  height: 70.0,
                ),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10.0),
                  color: Colors.grey,
                  image: new DecorationImage(
                      image: new NetworkImage(opt['imagen']),
                      fit: BoxFit.cover),
                  boxShadow: [
                    new BoxShadow(
                        color: mainColor,
                        blurRadius: 5.0,
                        offset: new Offset(2.0, 5.0))
                  ],
                ),
              ),
            ),
            new Expanded(
                child: new Container(
                  margin: const      EdgeInsets.fromLTRB(16.0,0.0,16.0,0.0),
                  child: new Column(children: [
                    new Text(opt['titulo'],
                      style: new TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Arvo',
                          fontWeight: FontWeight.bold,
                          color: mainColor),
                    ),
                    new Padding(padding: const EdgeInsets.all(2.0)),
                    new Text(opt['descripcion'],
                      maxLines: 3,
                      style: new TextStyle(
                          color: const Color(0xff8785A4),
                          fontFamily: 'Arvo'
                      ),)
                  ],
                    crossAxisAlignment: CrossAxisAlignment.start,),
                )
            ),
          ],
        )
         );
      opciones.add( widgetTemp ); 
      final container=new Container(
          width: 300.0,
          height: 0.5,
          color: const Color(0xD2D2E1ff),
          margin: const EdgeInsets.all(16.0),
        );
        opciones.add(container);  
    });
    return opciones;
  }
}