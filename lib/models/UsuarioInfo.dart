import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioInfo{

  final String nombre;
  final Timestamp creacion;
  final String moneda;
  final String path;

  UsuarioInfo({this.moneda,this.nombre,this.creacion,this.path});
}