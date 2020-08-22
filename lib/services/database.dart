
import 'package:billetera_virtual/models/Recibo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class DatabaseService {

  final  String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference collection = Firestore.instance.collection(
      'Historiales');
  final firestoreInstance = Firestore.instance;

  // Hace un update de la base de datos del usuario al crear una cuenta de en la apliacion

  Future updateUserData(String name, String moneda,double total) async {

    await collection.document(uid).collection('Recibos').document().setData({
      'descripcion': 'new member',
      'cantidad': 0.0
    });
    return await collection.document(uid).setData({
      'name': name,
      'moneda': moneda,
      'total': total,

    });
  }

  Future addRecibo(String desc,double cant) async {

   return await collection.document(uid).collection('Recibos').document().setData({
      'descripcion': desc,
      'cantidad': cant
    });

  }


  //historial lista(Recibe snapshots y las devuelve como una lista de recibos en este caso)
  List<Recibo> _reciboListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      print(doc.data['descripcion']);
      return Recibo(
          cant: doc.data['cantidad'] ?? 0.0,
          descripcion: doc.data['descripcion'] ?? ''
      );
    }).toList();
  }
//Esto se llama en la pagina Home para que al obtener recibos consulte la base de datos y la devuelva mapeando al metodo _reciboFromsnapshot
  Stream<List<Recibo>> obtenerRecibos() {
    print(uid);
    String path ='/Historiales/$uid/Recibos';
    print(path);
    return firestoreInstance.collection(path).snapshots().map(_reciboListFromSnapshot);
  }

}