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
    //final user = Provider.of<User>(context);
    final historial = Provider.of<List<Recibo>>(context) ?? [];
    final recibos=Provider.of<List<Text>>(context) ?? [];

    // Calcula el total de la lista
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
          Text("\$"+_calcularTotal().toStringAsFixed(3),style: TextStyle(fontSize: 34.0),),
          SizedBox(height: 20.0,),
          Expanded( // Expando el container para que entre en la aplicacion
            child: ListView.builder(//creo un constructor de lista

                  itemCount: historial.length, // con esto la hago infinita
                  itemBuilder: (context,index){ //Esto me da el contexto de la lista y que posicion esta
                    return Dismissible( //Se encarga de realizar una accion al direccionar el widget hacia un lado
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
                            return CupertinoAlertDialog(
                              title: Text('Esta seguro que desea eliminarlo?'),
                              content: Text('Delete'),
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
                      // Each Dismissible must contain a Key. Keys allow Flutter to
                      // uniquely identify widgets.
                      key: UniqueKey(),
                      // Provide a function that tells the app
                      // what to do after an item has been swiped away.
                      onDismissed: (direction) {
                        // Remove the item from the data source.
                        setState(() {
                          historial.removeAt(index);
                          DatabaseService.getInstaceC().deleteRecibo(recibos.elementAt(index).data);
                        });

                        // Show a snackbar. This snackbar could also contain "Undo" actions.
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


