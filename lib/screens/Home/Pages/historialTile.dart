import 'package:billetera_virtual/models/Recibo.dart';
import 'package:billetera_virtual/models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';

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
              child: ListTile(

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white70,
                ),
                title: Text('\$'+recibo.cant.toString(),style: TextStyle(color: Colors.white),),
                subtitle: Text(recibo.descripcion,style: TextStyle(color: Colors.white),),
              ),
            ),

          ),
        ],
      ),
    );

  }
}