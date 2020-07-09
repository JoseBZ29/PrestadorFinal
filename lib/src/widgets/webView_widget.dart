import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetCurrentURLWebView extends StatefulWidget {
  @override
  GetCurrentURLWebViewState createState() {
    return new GetCurrentURLWebViewState();
  }
}

class GetCurrentURLWebViewState extends State<GetCurrentURLWebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  StreamSubscription<String> _onUrlChanged;

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      key: scaffoldKey,
      url: 'http://solaci.org/_files/pdfs/es/html11.pdf',
      hidden: true,
      appBar: AppBar(
        title: Text("Terminos y Condiciones"),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
