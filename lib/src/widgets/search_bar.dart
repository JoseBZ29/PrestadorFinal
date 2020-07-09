import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:prestador_final/src/search/search_delegate.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          child: TextField(
            readOnly: true,
            onTap: () {
              showSearch(context: context, delegate: DataSearch()) ;
            },
            autocorrect: true,
            decoration: InputDecoration(
              contentPadding:
                  new EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
              hintText: 'Buscar servicio...',
              prefixIcon: Icon(
                LineIcons.search,
                color: Colors.grey,
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              alignLabelWithHint: true,
              filled: true,
              fillColor: Color.fromRGBO(192, 195, 196, .25),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(192, 195, 196, .25), width: 0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(192, 195, 196, .25), width: 0),
              ),
            ),
          )),
    );
  }
}
