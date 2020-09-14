import 'package:billetera_virtual/models/User.dart';
import 'package:billetera_virtual/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';


class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //crea un User a partir de un FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) :null;
  }

  //Obtiene el user del Stream.
  Stream<User> get user{
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }


  //Iniciar sesion en anonimo (No se usa en el momento)
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){

      print(e.toString());
      return null;
    }
  }


  /*Iniciar sesion con email y contraseña
  * .
  * */
  Future signInWithEmailAndPassword(String email,String password)async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      DatabaseService.getInstance(user.uid);
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }

  /*Registrar Con email y contraseña
  * Si hay un error devuelve un string con el error obtenido
  * */

  Future registerWithEmailAndPassword(String email,String password,String moneda)async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      //create a new document for the user with the uid
      await DatabaseService.getInstance(user.uid).updateUserData(email, moneda);
      return _userFromFirebaseUser(user);
    }
    catch(e){
      return e.code;
    }

  }

  //Cerrar sesion, Cierra la base da datos
  Future singOut() async{
    try{
      DatabaseService.SignOut();
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


}