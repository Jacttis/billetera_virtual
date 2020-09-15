
import 'package:billetera_virtual/models/User.dart';
import 'package:billetera_virtual/screens/Home/Pages/Agregar/AgregarView.dart';
import 'package:billetera_virtual/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Agregar extends StatefulWidget {

  @override
  _AgregarState createState() => _AgregarState();
}

class _AgregarState extends State<Agregar> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body:AgregarView(),
    );




    /*Container(
      child:RaisedButton(
          onPressed: ()async{
            await DatabaseService(uid: user.uid).addRecibo("Prueba  boton", 20.5);

          }
          ),

    );*/
  }
}

