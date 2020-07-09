import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ValidacionExitosa extends StatefulWidget {
  ValidacionExitosa({Key key}) : super(key: key);

  @override
  _ValidacionExitosaState createState() => _ValidacionExitosaState();
}

class _ValidacionExitosaState extends State<ValidacionExitosa> {
  double screenHeight;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //register2

  Widget upperHalf(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'assets/images/Back.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget loginCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 2.5),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Gracias por validar tu número",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height / 35,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Ya puedes configurar tu perfil para ofrecer tus servicios",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height / 35,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget loginCard2(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 1.4),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Tienes un mensaje de bienvenida en tu correo",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height / 50,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: screenHeight / 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/logoMe2.png',
            scale: 4,
          )
        ],
      ),
    );
  }

  Widget boton() {
    return Container(
      padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.22),
      child: Center(
        child: FlatButton(
          child: Text("Aceptar",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.height / 45)),
          color: Color.fromRGBO(31, 56, 96, 1),
          textColor: Colors.white,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width / 32,
              bottom: MediaQuery.of(context).size.width / 32,
              left: MediaQuery.of(context).size.height / 8,
              right: MediaQuery.of(context).size.height / 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, 'register5');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title:Text('¡Validación exitosa!',style: TextStyle(color:Color.fromRGBO(31, 56, 96, 1),),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color:Colors.white),
        elevation: 0,
      ),
        key: _scaffoldKey,
        body: Container(
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    upperHalf(context),
                    loginCard2(context),
                    boton(),
                    loginCard(context),
                    pageTitle()
                  ],
                ),
              )),
        ));
  }
}
