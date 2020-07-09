import 'package:flutter/material.dart';
import 'package:prestador_final/src/pages/pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RapidosPage extends StatefulWidget {
  RapidosPage({Key key}) : super(key: key);

  @override
  _RapidosPageState createState() => _RapidosPageState();
}

class _RapidosPageState extends State<RapidosPage> {
  final prefs = new Rapidos();
  bool q;
  bool w;
  bool e;
  bool r;
  bool t;
  bool y;
  bool u;
  bool i;
  bool o;
  bool p;
  bool a;
  bool s;
  bool d;

  @override
  void initState() {
    super.initState();
    q = prefs.getq();
    w = prefs.getw();
    e = prefs.gete();
    r = prefs.getr();
    t = prefs.gett();
    y = prefs.gety();
    u = prefs.getu();
    i = prefs.geti();
    o = prefs.geto();
    p = prefs.getp();
    a = prefs.geta();
    s = prefs.gets();
    d = prefs.getd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(31, 56, 96, 1),
        title: Text(
          'Servicios Rápidos',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            CheckboxListTile(
              title: Text("Veterinario"),
              value: q,
              onChanged: (valor) {
                setState(() {
                  q = valor;
                  prefs.setq(valor);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Enfermería"),
              value: w,
              onChanged: (valor) {
                setState(() {
                  w = valor;
                  prefs.setw(valor);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Inyecciones"),
              value: e,
              onChanged: (valor) {
                setState(() {
                  e = valor;
                  prefs.sete(valor);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Ambulancia"),
              value: r,
              onChanged: (valor) {
                setState(() {
                  r = valor;
                  prefs.setr(valor);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Cerrajero Auto"),
              value: y,
              onChanged: (valor) {
                setState(() {
                  y = valor;
                  prefs.sety(valor);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Cerrajero Casas"),
              value: u,
              onChanged: (valor) {
                setState(() {
                  u = valor;
                  prefs.setu(valor);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Fuga de Gas"),
              value: i,
              onChanged: (valor) {
                setState(() {
                  i = valor;
                  prefs.seti(valor);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Fontanero"),
              value: o,
              onChanged: (valor) {
                setState(() {
                  o = valor;
                  prefs.seto(valor);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Mecánica"),
              value: p,
              onChanged: (valor) {
                setState(() {
                  p = valor;
                  prefs.setp(valor);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Ponchadura"),
              value: a,
              onChanged: (valor) {
                setState(() {
                  a = valor;
                  prefs.seta(valor);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Gasolina"),
              value: s,
              onChanged: (valor) {
                setState(() {
                  s = valor;
                  prefs.sets(valor);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Batería"),
              value: d,
              onChanged: (valor) {
                setState(() {
                  d = valor;
                  prefs.setd(valor);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ]),
    );
  }
}
