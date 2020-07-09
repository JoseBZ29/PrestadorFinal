import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prestador_final/src/usuario.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterFormCelPage extends StatefulWidget {
  @override
  _RegisterFormCelPageState createState() => _RegisterFormCelPageState();
}

class _RegisterFormCelPageState extends State<RegisterFormCelPage> {
    Country _selected;
  String _celular;
  String _celular2;
    String codigo;
  final _phoneController = TextEditingController();
  bool _isLogin = false;

  final _codeController = TextEditingController();
  final _formKey=GlobalKey<FormState>();
  final _scaffoldKey=GlobalKey<ScaffoldState>();
  bool _isRegistering=false ;

  Future<bool> _registro(String phone, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;
      

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if(user != null){
            FirebaseAuth.instance.signOut();
            globals.celular=phone;
            Navigator.pushNamed(context, 'register2');
          }else{
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception){
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Introduce el codigo"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Confirmar"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async{
                      final code = _codeController.text.trim();
                      AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);
                      AuthResult result = await _auth.signInWithCredential(credential);
                      FirebaseUser user = result.user;
                      if(user != null){
                        FirebaseAuth.instance.signOut();
                        globals.celular=phone;
                        Navigator.pushNamed(context, 'register2');
                      }else{
                        print("Error");
                      }
                    },
                  )
                ],
              );
            }
          );
        },
        codeAutoRetrievalTimeout: null
    );
  }
  _registro2() async {
    codigo = _selected.dialingCode.toString();
    print(codigo);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final form = _formKey.currentState;
    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _isLogin = false;
      });
      return;
    }
    form.save();
    _celular2 = '+' + codigo + _celular;
    print('Celular: $_celular2');
    prefs.setString('celular', _celular);
    try{
          FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: _celular2,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          //Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            FirebaseAuth.instance.signOut();
            //globals.celular=phone;
            //Navigator.pushNamed(context, 'register2');
            Navigator.pushReplacementNamed(context, 'validacionExitosa');
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          globals.celular=_celular;
          prefs.setString('verificationId', verificationId);
          Navigator.pushNamed(context, 'validarCel');
        },
        codeAutoRetrievalTimeout: null);
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Validación de número celular',style: TextStyle(color:Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(31, 56, 96, 1),
      ),
      body: Center(
        child: ListView(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 30,
                    left: MediaQuery.of(context).size.width / 30,
                    right: MediaQuery.of(context).size.width / 30),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      icon: CountryPicker(
                        showDialingCode: true,
                        showName: false,
                        onChanged: (Country country) {
                          setState(() {
                            _selected = country;
                          });
                        },
                        selectedCountry: _selected,
                      ),
                      hintText: 'Escribe tu número',
                    ),
                    onSaved: (val) {
                      _celular = val;
                    },
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Ingrese un número de celular';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 20,
                      left: MediaQuery.of(context).size.width / 8,
                      right: MediaQuery.of(context).size.width / 8),
                  child: Text(
                    'Recibirás un mensaje con el código de validación',
                    maxLines: 3,
                    style: GoogleFonts.roboto(
                        fontSize: MediaQuery.of(context).size.height / 35,
                        color: Color.fromRGBO(31, 56, 96, 1),),
                    textAlign: TextAlign.center,
                  )),
              Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 15),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 35,
                          bottom: MediaQuery.of(context).size.width / 35,
                          left: MediaQuery.of(context).size.height / 15,
                          right: MediaQuery.of(context).size.height / 15),
                      color: Color.fromRGBO(31, 56, 96, 1),
                      onPressed: () {
                        _registro2();
                      },
                      child: Text(
                        'Enviar confirmación',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 35,
                            color: Colors.white),
                      ))),
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 6),
                  child: Image.asset(
                    'assets/images/logoMe.png',
                    scale: 1.5,
                  ))
            ],
          ),
        ]),
      ),
    );
  }
}