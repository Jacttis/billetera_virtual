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
  Image imagen;
  Widget build(BuildContext context) {
     foo();
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
                  child: imagen,
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
  
  void foo()async{
    imagen= await StorageService().getImage('/1AfgAlDOVgdGocVAuAfIE2pwLPS2/storage/emulated/0/Android/data/com.jacttis.billetera_virtual/files/Pictures/30e3f1e4-4f4d-4766-89cf-03726d731bde8130336375952141148.jpg');
  }
  
}