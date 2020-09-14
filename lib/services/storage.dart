import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
class StorageService{
  String urlG;
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://billeteravirtual-92474.appspot.com');
  StorageUploadTask _uploadTask;
  String uid;
  StorageService({this.uid});

  /*
  * Sube la foto al Storage de la base de datos
  * */
  Future startUpload(File image) async{
    String path='$uid/'+image.path;
    _uploadTask=_storage.ref().child(path).putFile(image);
    StorageTaskSnapshot taskSnapshot = await _uploadTask.onComplete;
    return taskSnapshot.ref.getDownloadURL();
  }






}