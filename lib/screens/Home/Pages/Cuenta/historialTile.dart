import 'package:billetera_virtual/models/Recibo.dart';
import 'package:billetera_virtual/models/User.dart';
import 'package:billetera_virtual/services/database.dart';
import 'package:billetera_virtual/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistorialTile extends StatelessWidget {
  final Recibo recibo;

  HistorialTile({this.recibo});
  @override
  Widget build(BuildContext context) {
    // Creo la Card para manejar la lista de recibos
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Card(
              color: Colors.black38,
              margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
              child: ExpansionTile(

                leading: CircleAvatar(
                  backgroundImage: NetworkImage(recibo.path),
                  radius: 25,
                  backgroundColor: Colors.white70,
                ),
                title: Text('\$'+recibo.cant.toString(),style: TextStyle(color: Colors.white),),
                subtitle: Text(recibo.titulo,style: TextStyle(color: Colors.white),),
                children: [
                  Text(recibo.descripcion,style: TextStyle(color: Colors.white),),
                ],
              ),
            ),

          ),
        ],
      ),
    );

  }
  
  
}