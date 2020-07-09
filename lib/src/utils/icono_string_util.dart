import 'package:flutter/material.dart';

final _icons = <String, IconData>{

  'tarjeta'       :Icons.credit_card,
  'cuenta'        :Icons.account_circle,
  'ayuda'         :Icons.help,
  'quienesSomos'  :Icons.live_help,
  'tarjeta'       :Icons.credit_card,
  'efectivo'      :Icons.attach_money
};




Icon getIcon( String nombreIcono ) {

  return Icon( _icons[nombreIcono], color: Colors.grey );
  
}