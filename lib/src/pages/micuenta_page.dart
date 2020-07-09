import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:prestador_final/src/widgets/picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MiCuentaPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MiCuentaPageState();
  }
}

class _MiCuentaPageState extends State<MiCuentaPage>{


  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  
 
  String nameUser,mailUser,phoneUser,perfurl;
  String prefname,prefmail,prefnum,prefpass,prefurl;

  @override
  void initState() {
    super.initState();
    _init();
    print("Uno");
  }
  
   _init() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefname = prefs.getString('nombre') ?? 'Nombre';
      print(prefname);
      prefmail = prefs.getString('correo') ?? 'Nombre';
      prefpass = prefs.getString('pass') ?? 'Nombre';
      prefnum = prefs.getString('telefono') ?? 'Nombre';
      prefurl = prefs.getString('url') ?? 'https://ecommercev2.000webhostapp.com/2.png';
      setState(() {
        
      });
  }

  Widget _crearNombre(){


    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: 'Nombre',
        labelText: 'Nombre',
        icon: Icon(Icons.account_box),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))
      ),
      controller: TextEditingController()..text = '$prefname',
      onChanged: (text){
        nameUser=text;
      },

    );
  }

  Widget _crearEmail(){


    return TextField(
      // autofocus: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        labelText: 'Email',
        icon: Icon(Icons.email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))
      ),
      controller: TextEditingController()..text = '$prefmail',
      onChanged: (text){
        mailUser=text;
      },
    );
  }

  Widget _crearCel(){


    return TextField(
      // autofocus: true,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Telefono',
        labelText: 'Telefono',
        icon: Icon(Icons.phone),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))
      ),
      controller: TextEditingController()..text = '$prefnum',
      onChanged: (text){
        phoneUser=text;
      },
    );
  }

  Widget _crearAvatar(BuildContext contexto){
    return Builder(
      builder: (contexto)=>Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: SizedBox(
                    width: 180.0,
                    height: 180.0,
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/2.png'), 
                      image: NetworkImage(prefurl),
                      fit: BoxFit.fitWidth,
                      fadeInDuration: Duration( milliseconds: 200),
                      ),
                    ) 
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: 60.0),
              //child: Pick()
            )
          ],
        ),
      )
    );
  }

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
        _btnController.success();
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Mi cuenta', style: TextStyle(color: Colors.black),),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical:20.0),
        children: <Widget>[
          _crearAvatar(context),
          
          Padding(child: _crearNombre(),
          padding: EdgeInsets.only(top: 20.0)
          ),
          Divider(),
          _crearEmail(),
          Divider(),
          _crearCel(),
          Divider(),
          RoundedLoadingButton(
            child: Text('Actualizar Datos', style: TextStyle(color: Colors.white)),
            controller: _btnController,
            onPressed: _doSomething,
          )
      // _crearPersona()
        ]
      ),
    );
  }

}