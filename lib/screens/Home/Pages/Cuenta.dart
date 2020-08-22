import 'package:billetera_virtual/models/Recibo.dart';
import 'package:billetera_virtual/models/User.dart';
import 'package:billetera_virtual/services/auth.dart';
import 'package:billetera_virtual/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'historial_list.dart';

class Cuenta extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); // devuelve el usuario activo
    return StreamProvider<List<Recibo>>.value(
      value: DatabaseService(uid: user.uid).obtenerRecibos(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Cuenta'),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: ()async {
                  await _auth.singOut();

                },
                icon: Icon(Icons.person),
                label: Text('logout'))
          ],
        ),
        body: HistorialList(),
      ),
    );
  }
}
