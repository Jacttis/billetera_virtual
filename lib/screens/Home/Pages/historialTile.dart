import 'package:billetera_virtual/models/Recibo.dart';
import 'package:flutter/material.dart';

class HistorialTile extends StatelessWidget {
  final Recibo recibo;

  HistorialTile({this.recibo});
  @override

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Card(
              color: Colors.grey[300],
              margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                ),
                title: Text(recibo.cant.toString()),
                subtitle: Text(recibo.descripcion),
              ),
            ),

          ),
        ],
      ),
    );

  }
}