import 'package:billetera_virtual/models/User.dart';
import 'package:billetera_virtual/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Agregar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Container(
      child:RaisedButton(
          onPressed: ()async{
            await DatabaseService(uid: user.uid).addRecibo("Prueba  boton", 20.5);

          }
          ),

    );
  }
}

