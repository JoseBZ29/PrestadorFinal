

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CardFotos3 extends StatefulWidget {
  CardFotos3({Key key}) : super(key: key);

  @override
  CardFotos3State createState() => CardFotos3State();
}

class CardFotos3State extends State<CardFotos3> {
   static File galleryFile;
   static Future<File> imageFile;

  @override
  void initState(){
    imageFile=null;
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
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        }else if(snapshot.error!=null){
          return const Text(
            'Error al seleccionar la imagen',
            textAlign: TextAlign.center,
            );
        }else{
          return Image.asset("assets/logo_splash.png");
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Material(
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
              );
    
    
    
    
  }
}