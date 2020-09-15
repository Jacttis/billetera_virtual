
import 'package:billetera_virtual/models/Recibo.dart';
import 'package:billetera_virtual/models/UsuarioInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DatabaseService {

   String uid;
  static DatabaseService _instance=null;
/*
* Constructor interno del Singleton
* */
  DatabaseService._internal(String uidd){
    uid=uidd;
  }
  /*
  * Obtiene la instancia a partir de un uid, o permita Crearla
  * */
  static DatabaseService getInstance(String uid){
    if(_instance==null){
      _instance=new DatabaseService._internal(uid);
    }
      return _instance;

  }
  /*
  * Si ya esta creada la instancia la devuelve
  * */
  static DatabaseService getInstaceC(){
    return _instance;
  }

  /*
  * Convierte la instacia nula despues de Cerrar Sesion
  * */
  static void SignOut(){
    _instance=null;
  }

  //collection reference
  final CollectionReference collection = Firestore.instance.collection(
      'Historiales');
  final CollectionReference collectionU = Firestore.instance.collection(
      'Usuarios');
  final firestoreInstance = Firestore.instance;

  // Hace un update de la base de datos del usuario al crear una cuenta de en la aplicacion

  Future updateUserData(String name, String moneda) async {

    await collection.document(uid).collection('Recibos').document().setData({
      'titulo': 'Nuevo miembro',
      'cantidad': 0.0,
      'path':'',
      'descripcion':'cuenta nueva',
      'creado':Timestamp.now()
    });
    return await collectionU.document(uid).setData({
      'nombre': name,
      'moneda': moneda,
      'creado':Timestamp.now(),
      'path':'',

    });
  }

  Future actualiarPerfil(String nombre,String moneda,String path) async{
    return await collectionU.document(uid).setData({
      'nombre':nombre,
      'moneda':moneda,
      'path':path
        });

  }

// Añado un Recibo a la base de datos de dicho user con la descripcion (desc) y la cantidad(cant), el path de la imagen y el titulo del recibo pasada como parametro
  Future addRecibo(String desc,double cant,String path,String tit) async {
    print('entra');
    print('$uid');
   return await collection.document(uid).collection('Recibos').document().setData({
      'descripcion': desc,
      'cantidad': cant,
      'path':path,
      'titulo':tit,
      'creado':Timestamp.now()
    });

  }

  //Devuelve una lista de text(a partir de un snapshot)
  List<Text> _stringListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Text(doc.documentID);
    }).toList();
  }

 // A partir de todos los recibos devuelvo un Stream mapeandolo a una lista de Text() con _stringListFromSnapshot()
  Stream<List<Text>>  obtenerIDRecibo(){
    String path ='/Historiales/$uid/Recibos';
    return firestoreInstance.collection(path).orderBy('creado',descending: true).snapshots().map(_stringListFromSnapshot);

  }

  //A partir de un ID de un recibo lo elimino de la base de datos.
  Future deleteRecibo(String reciboID) async {
    return await collection.document(uid).collection('Recibos')
        .document(reciboID)
        .delete();
  }


  //historial lista(Recibe snapshots y las devuelve como una lista de recibos en este caso)
  List<Recibo> _reciboListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Recibo(
          cant: doc.data['cantidad'] ?? 0.0,
          descripcion: doc.data['descripcion'] ?? '',
          path: doc.data['path'] ?? '',
          titulo: doc.data['titulo']??''
      );
    }).toList();
  }

//Esto se llama en la pagina Home para que al obtener recibos consulte la base de datos y la devuelva mapeando al metodo _reciboFromsnapshot
  Stream<List<Recibo>> obtenerRecibos() {
    String path ='/Historiales/$uid/Recibos';
    return firestoreInstance.collection(path).orderBy('creado',descending: true).snapshots().map(_reciboListFromSnapshot);
  }

  Stream<UsuarioInfo> obtenerUsuario() {
    print('$uid');
    return collectionU.document("$uid").snapshots().map(_usuarioFromSnapshot);

  }

  UsuarioInfo _usuarioFromSnapshot(DocumentSnapshot doc) {
      return UsuarioInfo(
          moneda: doc.data['moneda'] ?? '',
          nombre: doc.data['nombre']?? '',
          creacion: doc.data['creacion'],
          path: doc.data['path']??'',
      );

  }

}