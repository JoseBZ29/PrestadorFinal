import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_icons/line_icons.dart';
import 'package:prestador_final/src/bottom_navigation/home_tab.dart';
import 'package:prestador_final/src/bottom_navigation/listaCotizaciones.dart';
import 'package:prestador_final/src/bottom_navigation/profile_tab.dart';
import 'package:prestador_final/src/bottom_navigation/search_tab.dart';
import 'package:prestador_final/src/bottom_navigation/services_tab.dart';
import 'package:prestador_final/src/pages/pruebas.dart';
import 'package:prestador_final/src/widgets/bottom_menu.dart';
import 'package:prestador_final/src/widgets/my_page_view.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;

  //PageController _pageViewController;
  final _menu = [
    BottomMenuItem(icon: LineIcons.home, label: "Inicio", content: HomeTab()),
    BottomMenuItem(
        icon: LineIcons.search, label: "Buscar", content: ServicesTab()),
    BottomMenuItem(
        icon: LineIcons.user, label: "Perfil", content: ProfileTab()),
    BottomMenuItem(
        icon: Icons.work, label: 'Servicios', content: ListaCotizaciones()),
  ];

  @override
  void initState() {
    super.initState();
    //_pageViewController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: MyPageView(
          children: _menu.map<Widget>((item) => item.content).toList(),
          currentPage: _currentPage,
        )),
      ),
      bottomNavigationBar: BottomMenu(
        items: _menu,
        currentPage: _currentPage,
        onChange: (int newCurrentPage) {
          setState(() {
            _currentPage = newCurrentPage;
          });
        },
      ),
    );
  }
}
