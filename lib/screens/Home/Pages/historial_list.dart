import 'package:billetera_virtual/models/Recibo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'historialTile.dart';

class HistorialList extends StatefulWidget {
  @override
  _HistorialListState createState() => _HistorialListState();
}

class _HistorialListState extends State<HistorialList> {
  @override
  Widget build(BuildContext context) {
    final historial = Provider.of<List<Recibo>>(context) ?? [];

    double _calcularTotal(){
      double _total=0;
      historial.forEach((element) {
        _total=(_total+(element.cant));
      });
      return _total;
    }

    return Container(

      child: Column(
        children: <Widget>[
          Text(_calcularTotal().toString()),
          SizedBox(height: 20.0,),
          Expanded(
            child: ListView.builder(

                  itemCount: historial.length,
                  itemBuilder: (context,index){
                    return HistorialTile(recibo: historial[index]);
                  },
                ),
          ),
        ],
      ),
    );



    /*if(historial!= null) {
         historial.forEach((recibo) {
           print(recibo.cant);
           print(recibo.descripcion);
         });
       }*/


    /*  if(historial != null ) {
      print("EntraPrimero");
      for( var doc in historial.documents){
        print("Entra");
        print(doc.data['cantidad']);

      }
    }
    else{
      print('no fnciona');
    }
*/


  }
}


