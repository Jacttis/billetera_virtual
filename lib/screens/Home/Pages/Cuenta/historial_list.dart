import 'package:billetera_virtual/models/Recibo.dart';
import 'package:billetera_virtual/models/User.dart';
import 'package:billetera_virtual/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
    /*
    * Lista de recibos(historial) y IDRecibos( IDRecibos) dadas por Stream Provider
    * */
    final historial = Provider.of<List<Recibo>>(context) ?? [];
    final IDRecibos = Provider.of<List<Text>>(context) ?? [];


    // Calcula el Saldo total de la lista

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
          Text("Saldo:",style: TextStyle(fontSize:40.0 ),),

          Text("\$"+_calcularTotal().toStringAsFixed(3),style: TextStyle(fontSize: 34.0,fontWeight: FontWeight.w900),),

          SizedBox(height: 20.0,),
          /*
          * Expande la lista para que rellene la pantalla
          * */
          Expanded(
            /*
            * Lista creada con el constructor .builder para darle el item
            * */
            child: ListView.builder(
                  // Convierte la lista en infinita
                  itemCount: historial.length,

                  //Esto me da el contexto de la lista y que posicion esta
                  itemBuilder: (context,index){
                    /*
                    * Devuelve un Dismissible que su funcion convertir al hijo en dismissible
                    * y que se pueda realizar una funcion al mover el objeto hacia una direccion especifica
                    * */
                    return Dismissible(
                      direction: DismissDirection.endToStart,

                      background: Container(
                        width: 6,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(left: 20.0),
                        color: Colors.redAccent[400],
                        child: Icon(Icons.delete, color: Colors.white),
                      ),

                      confirmDismiss: (direction) {

                        return showDialog(
                          context: context,
                          builder: (context) {
                            /*
                            * Alerta en pantalla para decidir si quiere eliminarlo
                            * */
                            return CupertinoAlertDialog(
                              title: Text('Esta seguro que desea eliminarlo?'),
                              content: Text('Eliminar'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    // Navigator.pop(context, false);
                                    Navigator.of(
                                      context,
                                      // rootNavigator: true,
                                    ).pop(false);
                                  },
                                  child: Text('Atras'),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    // Navigator.pop(context, true);
                                    Navigator.of(
                                      context,
                                      // rootNavigator: true,
                                    ).pop(true);
                                  },
                                  child: Text('Si'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      /*
                      * Cada Dismissible debe tener una key que permita a flutter identificar los widgets
                      * */
                      key: UniqueKey(),

                      /*
                      * Provee una funcion que le indica a la app que hacer despues de swiped a un lado
                      * */
                      onDismissed: (direction) {
                        // Elimina el elemento.
                        setState(() {
                          historial.removeAt(index);
                          DatabaseService.getInstaceC().deleteRecibo(IDRecibos.elementAt(index).data);
                        });

                        // Muestra a snackbar.
                        Scaffold
                            .of(context)
                            .showSnackBar(SnackBar(content: Text(" Recibo eliminado")));
                      },

                      child: HistorialTile(recibo: historial[index]),
                    );
                  },
                ),
          ),
        ],
      ),
    );


  }
}


