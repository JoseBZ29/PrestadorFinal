import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';


class PDFPage extends StatefulWidget {
  PDFPage({Key key}) : super(key: key);

  @override
  _PDFPageState createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  
  final String url='http://www.africau.edu/images/default/sample.pdf';
  PDFDocument _doc;
  bool _loading;

  @override
  void initState() { 
    super.initState();
    pdf();
  }

  pdf() async {
    setState(() {
      _loading=true;
    });
    final doc = await PDFDocument.fromURL(url);
    setState(() {
      _doc=doc;
    });
  }


  @override
  Widget build(BuildContext context) {
    print(url);
    return Scaffold(
      appBar: AppBar(
        title:Text('Hola')
      ),
      body: _loading?Center(child:CircularProgressIndicator(),):
      PDFViewer(document: _doc,)
    );
  }
}
