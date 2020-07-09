

import 'dart:io';
import 'package:prestador_final/src/usuario.dart' as globals;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CardFotos extends StatefulWidget {
  CardFotos({Key key}) : super(key: key);

  @override
  CardFotosState createState() => CardFotosState();
}

class CardFotosState extends State<CardFotos> {
   static File galleryFile;
   static Future<File> imageFile;
   static File galleryFile2;
   static Future<File> imageFile2;

  @override
  void initState(){
    imageFile=null;
    imageFile2=null;
    super.initState();
  }

  pickImageFromGallery(ImageSource source){
    setState(() {
      imageFile=ImagePicker.pickImage(source: source);      
    });
  }

  Widget showImage(){
    return FutureBuilder<File>(
      future:imageFile,
      builder: (BuildContext context,AsyncSnapshot<File> snapshot){
        if(snapshot.connectionState==ConnectionState.done && snapshot.data!=null){
          galleryFile=snapshot.data;
          print(galleryFile);
          globals.imagen=1;
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        }else if(snapshot.error!=null){
          globals.imagen=0;
          return const Text(
            'Error al seleccionar la imagen',
            textAlign: TextAlign.center,
            );
        }else{
          globals.imagen=0;
          return Image.asset("assets/images/CargaMR.png");
        }
      },
    );
  }
  pickImageFromGallery2(ImageSource source){
    setState(() {
      imageFile2=ImagePicker.pickImage(source: source);      
    });
  }

  Widget showImage2(){
    return FutureBuilder<File>(
      future:imageFile2,
      builder: (BuildContext context,AsyncSnapshot<File> snapshot2){
        if(snapshot2.connectionState==ConnectionState.done && snapshot2.data!=null){
          galleryFile2=snapshot2.data;
          print(galleryFile2);
          globals.imagen2=1;
          return Image.file(
            snapshot2.data,
            width: 300,
            height: 300,
          );
        }else if(snapshot2.error!=null){
          globals.imagen2=0;
          return const Text(
            'Error al seleccionar la imagen',
            textAlign: TextAlign.center,
            );
        }else{
          globals.imagen2=0;
          return Image.asset("assets/images/CargaMR.png");
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height/25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                
                child: Text('Mi identificación oficial')),
              Container(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/60),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10.0),
                  child: InkWell(
                    onTap: ()=>pickImageFromGallery(ImageSource.gallery),
                    onDoubleTap:()=>pickImageFromGallery(ImageSource.camera) ,
                    child:Container(
                      width:200,
                      height:200,
                      child: showImage(),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/60),
                child: Text('Por seguridad se requiere la imagen de su identificación',style: TextStyle(fontSize: MediaQuery.of(context).size.height/65),)),
              Container(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/60),
                child: Text('Carta de antecedentes no penales',)),
              Container(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/60),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10.0),
                  child: InkWell(
                    onTap: ()=>pickImageFromGallery2(ImageSource.gallery),
                    onDoubleTap:()=>pickImageFromGallery2(ImageSource.camera) ,
                    child:Container(
                      width:200,
                      height:200,
                      child: showImage2(),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/60),
                child: Text('Por su seguridad se requiere la imagen de su carta',style: TextStyle(fontSize: MediaQuery.of(context).size.height/60),)),
            ],
          ),
        ),
      );
    
    
    
    
  }
}