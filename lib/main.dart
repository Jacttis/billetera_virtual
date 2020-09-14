import 'package:billetera_virtual/screens/wrapper.dart';
import 'package:billetera_virtual/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
Corre la aplicacion
 */
void main() {
  runApp(MyApp());
}

/*

 */
class MyApp extends StatelessWidget {
  /*
    Crea un Stream Provider el cual tiene el valor(value) del usuario actual.
    Crea un MaterialApp top-level de la aplicacion,y llama al wrapper como ruta default
  */
  @override
  Widget build(BuildContext context) {
   return StreamProvider.value(
     value: AuthService().user,
     child: MaterialApp(
       home: Wrapper(),
     ),
   );
  }

}