import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
     String _correo;
  final _formKey=GlobalKey<FormState>();
  final _scaffoldKey=GlobalKey<ScaffoldState>();

bool _isSendingForgotPassword=false ;

_forgotPassword() async{
  if(_isSendingForgotPassword) return;
  setState(() {
    _isSendingForgotPassword=true;
  });
  final form=_formKey.currentState;

      if(!form.validate()){
        _scaffoldKey.currentState.hideCurrentSnackBar();
        setState(() {
          _isSendingForgotPassword=false;
        });
        return;
      }

      form.save();

      try {
       await FirebaseAuth.instance.sendPasswordResetEmail(email: _correo);
       
       _scaffoldKey.currentState.hideCurrentSnackBar();
       _scaffoldKey.currentState.showSnackBar(SnackBar(
         content:Text('Se ha enviado un correo electronico a su bandeja con las instrucciones'),
         duration: Duration(seconds:10),
       ));
      } catch(e){
        _scaffoldKey.currentState.hideCurrentSnackBar();
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(e.message),
          duration: Duration(seconds:10),
          action: SnackBarAction(
            label: 'Cerrar',
            onPressed: (){
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
          ),
        ));
      } finally{
        setState(() {
          _isSendingForgotPassword=false;
        });
      }

}







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title:Text('Olvide mi contraseña') ,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
        child: ListView(
          children: <Widget>[
            FlutterLogo(
              style:FlutterLogoStyle.markOnly,
              size: 100.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical:20.0),
              child: Text('Introduce tu correo electronico para resetar tu contraseña'),
            ),
            TextFormField(
              decoration:InputDecoration(labelText: 'Email',icon: Icon(Icons.alternate_email,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              )
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (val){
                if(val.isEmpty){
                  return 'Por favor teclee un correo valido';
                }else{
                  return null;
                }
                
              },
              onSaved: (val){
                setState(() {
                  _correo=val;
                });
              },
            )
          ],
        ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _forgotPassword();
        },
        child: Icon(Icons.restore),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, 'register');
          },
          child: Text('No tengo una cuenta'),
        ),
      ],
    );
  }
}