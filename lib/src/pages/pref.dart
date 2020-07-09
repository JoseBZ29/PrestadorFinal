import 'package:shared_preferences/shared_preferences.dart';

class Rapidos{

  static final Rapidos _instancia = new Rapidos._internal();
  factory Rapidos(){
    return _instancia;
  }
  Rapidos._internal();

  SharedPreferences _prefs;

  initPrefs() async{
    this._prefs = await SharedPreferences.getInstance();
  }

  getq(){
    return _prefs.getBool('q') ?? false;
  }
  setq(bool valor){
    _prefs.setBool('q', valor);
  }
  getw(){
    return _prefs.getBool('w') ?? false;
  }
  setw(bool valor){
     _prefs.setBool('w', valor);
  }
  gete(){
    return _prefs.getBool('e') ?? false;
  }
  sete(bool valor){
     _prefs.setBool('e', valor);
  }
  getr(){
    return _prefs.getBool('r') ?? false;
  }
  setr(bool valor){
     _prefs.setBool('r', valor);
  }
  gett(){
    return _prefs.getBool('t') ?? false;
  }
  sett(bool valor){
     _prefs.setBool('t', valor);
  }
  gety(){
    return _prefs.getBool('y') ?? false;
  }
  sety(bool valor){
     _prefs.setBool('y', valor);
  }
  getu(){
    return _prefs.getBool('u') ?? false;
  }
  setu(bool valor){
     _prefs.setBool('u', valor);
  }
  geti(){
    return _prefs.getBool('i') ?? false;
  }
  seti(bool valor){
     _prefs.setBool('i', valor);
  }
  geto(){
    return _prefs.getBool('o') ?? false;
  }
  seto(bool valor){
    _prefs.setBool('o', valor);
  }
  getp(){
    return _prefs.getBool('p') ?? false;
  }
  setp(bool valor){
    _prefs.setBool('p', valor);
  }
  geta(){
    return _prefs.getBool('af') ?? false;
  }
  seta(bool valor){
    _prefs.setBool('af', valor);
  }
  gets(){
    return _prefs.getBool('s') ?? false;
  }
  sets(bool valor){
    _prefs.setBool('s', valor);
  }
  getd(){
    return _prefs.getBool('d') ?? false;
  }
  setd(bool valor){
    
  }

}