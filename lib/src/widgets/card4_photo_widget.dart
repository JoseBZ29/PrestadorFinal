import 'dart:io';
import 'package:prestador_final/src/usuario.dart' as globals;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CardFotos4 extends StatefulWidget {
  CardFotos4({Key key}) : super(key: key);

  @override
  CardFotos4State createState() => CardFotos4State();
}

class CardFotos4State extends State<CardFotos4> {
  static File galleryFile;
  static Future<File> imageFile;
  static File galleryFile2;
  static Future<File> imageFile2;
  static File galleryFile3;
  static Future<File> imageFile3;
  static File galleryFile4;
  static Future<File> imageFile4;
  static File galleryFile5;
  static Future<File> imageFile5;

  @override
  void initState() {
    imageFile = null;
    imageFile2 = null;
    imageFile3 = null;
    imageFile4 = null;
    imageFile5 = null;
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
          globals.imagen5 = 1;
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          globals.imagen5 = 0;
          return const Text(
            'Error al seleccionar la imagen',
            textAlign: TextAlign.center,
          );
        } else {
          globals.imagen5 = 0;
          return Image.asset("assets/images/CargaMR.png");
        }
      },
    );
  }

  pickImageFromGallery2(ImageSource source) {
    setState(() {
      imageFile2 = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage2() {
    return FutureBuilder<File>(
      future: imageFile2,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot2) {
        if (snapshot2.connectionState == ConnectionState.done &&
            snapshot2.data != null) {
          galleryFile2 = snapshot2.data;
          print(galleryFile);
          globals.imagen6 = 1;
          return Image.file(
            snapshot2.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot2.error != null) {
          globals.imagen6 = 0;
          return const Text(
            'Error al seleccionar la imagen',
            textAlign: TextAlign.center,
          );
        } else {
          globals.imagen6 = 0;
          return Image.asset("assets/images/CargaMR.png");
        }
      },
    );
  }

  pickImageFromGallery3(ImageSource source) {
    setState(() {
      imageFile3 = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage3() {
    return FutureBuilder<File>(
      future: imageFile3,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot3) {
        if (snapshot3.connectionState == ConnectionState.done &&
            snapshot3.data != null) {
          galleryFile3 = snapshot3.data;
          print(galleryFile);
          globals.imagen7 = 1;
          return Image.file(
            snapshot3.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot3.error != null) {
          globals.imagen7 = 0;
          return const Text(
            'Error al seleccionar la imagen',
            textAlign: TextAlign.center,
          );
        } else {
          globals.imagen7 = 0;
          return Image.asset("assets/images/CargaMR.png");
        }
      },
    );
  }

  pickImageFromGallery4(ImageSource source) {
    setState(() {
      imageFile4 = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage4() {
    return FutureBuilder<File>(
      future: imageFile4,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot4) {
        if (snapshot4.connectionState == ConnectionState.done &&
            snapshot4.data != null) {
          galleryFile4 = snapshot4.data;
          print(galleryFile);
          globals.imagen8 = 1;
          return Image.file(
            snapshot4.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot4.error != null) {
          globals.imagen8 = 0;
          return const Text(
            'Error al seleccionar la imagen',
            textAlign: TextAlign.center,
          );
        } else {
          globals.imagen8 = 0;
          return Image.asset("assets/images/CargaMR.png");
        }
      },
    );
  }

  pickImageFromGallery5(ImageSource source) {
    setState(() {
      imageFile5 = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage5() {
    return FutureBuilder<File>(
      future: imageFile5,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot5) {
        if (snapshot5.connectionState == ConnectionState.done &&
            snapshot5.data != null) {
          galleryFile5 = snapshot5.data;
          print(galleryFile);
          globals.imagen9 = 1;
          return Image.file(
            snapshot5.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot5.error != null) {
          globals.imagen9 = 0;
          return const Text(
            'Error al seleccionar la imagen',
            textAlign: TextAlign.center,
          );
        } else {
          globals.imagen9 = 0;
          return Image.asset("assets/images/CargaMR.png");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 30.0, left: MediaQuery.of(context).size.width / 4),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                onTap: () => pickImageFromGallery(ImageSource.gallery),
                onDoubleTap: () => pickImageFromGallery(ImageSource.camera),
                child: Container(
                  width: 100,
                  height: 100,
                  child: showImage(),
                ),
              ),
            ),
          ),
        ]),
        Row(children: <Widget>[
          Row(children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 30.0, right: MediaQuery.of(context).size.width / 6),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10.0),
                child: InkWell(
                  onTap: () => pickImageFromGallery2(ImageSource.gallery),
                  onDoubleTap: () => pickImageFromGallery2(ImageSource.camera),
                  child: Container(
                    width: 100,
                    height: 100,
                    child: showImage2(),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10.0),
                child: InkWell(
                  onTap: () => pickImageFromGallery3(ImageSource.gallery),
                  onDoubleTap: () => pickImageFromGallery3(ImageSource.camera),
                  child: Container(
                    width: 100,
                    height: 100,
                    child: showImage3(),
                  ),
                ),
              ),
            ),
          ]),
        ]),
        Row(children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 30.0, right: MediaQuery.of(context).size.width / 6),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                onTap: () => pickImageFromGallery4(ImageSource.gallery),
                onDoubleTap: () => pickImageFromGallery4(ImageSource.camera),
                child: Container(
                  width: 100,
                  height: 100,
                  child: showImage4(),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                onTap: () => pickImageFromGallery5(ImageSource.gallery),
                onDoubleTap: () => pickImageFromGallery5(ImageSource.camera),
                child: Container(
                  width: 100,
                  height: 100,
                  child: showImage5(),
                ),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
