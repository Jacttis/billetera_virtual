import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class AgregarImagen{

  File image;
  final picker=ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://billeteravirtual-92474.appspot.com');

  /*
  * Obtener imagen desde la camara.
  * */
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    image = File(pickedFile.path);
    return image;
  }



}