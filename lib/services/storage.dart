import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
class StorageService{

  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://billeteravirtual-92474.appspot.com');
  StorageUploadTask _uploadTask;
  String uid;
  StorageService({this.uid});

  Future startUpload(File image) async{
    String path='$uid/'+image.path;
    _uploadTask=_storage.ref().child(path).putFile(image);
    StorageTaskSnapshot taskSnapshot = await _uploadTask.onComplete;
    print('Completado');
  }




}