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
    /*
    * Devuelve 2 StreamProvider que uno de valor tiene una lista de id de recibos,
    * el otro tiene una lista de Recibos ordenados de la misma manera para un mejor manejo
    * y el cuerpo del Scaffold es un HistorialList
    * */
    return StreamProvider<List<Text>>.value( //Devuelve un Stream de una lista de ID de recibos

      value:DatabaseService.getInstaceC().obtenerIDRecibo(),//aca se obtiene el valor del stream

      child: StreamProvider<List<Recibo>>.value(

        value: DatabaseService.getInstaceC().obtenerRecibos(),

        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Cuenta'),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),

          body: HistorialList(),
        ),
      ),
    );
  }
}
