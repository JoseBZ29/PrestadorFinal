import 'dart:io';
import 'package:prestador_final/src/usuario.dart' as globals;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CardFotos5 extends StatefulWidget {
  CardFotos5({Key key}) : super(key: key);

  @override
  CardFotos5State createState() => CardFotos5State();
}

class CardFotos5State extends State<CardFotos5> {
  static File galleryFile;
  static Future<File> imageFile;

  @override
  void initState() {
    imageFile = null;
    super.initState();
  }

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          galleryFile = snapshot.data;
          print(galleryFile);
          globals.imagen10 = 1;
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          globals.imagen10 = 0;
          return const Text(
            'Error al seleccionar la imagen',
            textAlign: TextAlign.center,
          );
        } else {
          globals.imagen10 = 0;
          return Image.asset("assets/images/CargaMR.png");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Es importante conocerte. ¡Tómate la foto! o selecciona una imagen',
              textAlign: TextAlign.center,
            ),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                onTap: () => pickImageFromGallery(ImageSource.gallery),
                onDoubleTap: () => pickImageFromGallery(ImageSource.camera),
                child: Container(
                  width: 200,
                  height: 200,
                  child: showImage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
