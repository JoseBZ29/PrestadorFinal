import 'package:flutter/material.dart';
import 'package:prestador_final/src/pages/pref.dart';
import 'package:prestador_final/src/pages/splash_screen.dart';
import 'package:prestador_final/src/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new Rapidos();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Me Recomiendan Profesionales',
      home: Splash(),
      theme: ThemeData(primaryColor: Colors.lightBlue),
      routes: getAplicationRoute(),
    );
  }
}
