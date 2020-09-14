import 'package:billetera_virtual/models/Recibo.dart';
import 'package:billetera_virtual/screens/Home/Pages/detailsScreen.dart';
import 'package:flutter/material.dart';


class HistorialTile extends StatelessWidget {
  final Recibo recibo;
  final _key =  GlobalKey();
  HistorialTile({this.recibo});

  @override
  Widget build(BuildContext context) {
    /*
    * Creo un container el cual tiene como hijo una Columna de Widgets
    * */
    return Container(
      child: Column(
        children: [

          Padding(
            padding: EdgeInsets.only(top: 8.0),

            /*
            * Creo la carta el cual va a ser cada una un recibo
            * */
            child: Card(
              color: Colors.black38,
              margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
              /*
              * Tile expansible al hacer click se expande para ver lo que tiene en childrens (en este caso descripcion)
              * */
              child: ExpansionTile(
                /*
                * Detector de gesto para la imagen al hacer un tap abrirla en pantalla completa
                * */
                leading: GestureDetector(
                  onTap: (){
                    if(recibo.path!=''){
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return DetailScreen.fromNetworkImage(NetworkImage(recibo.path) );

                      }));}
                  },
                  child: CircleAvatar(
                    key: _key,
                    backgroundImage: recibo.path!=''?NetworkImage(recibo.path):null,
                    radius: 25,
                    backgroundColor: Colors.white70,
                  ),
                ),

                title: recibo.cant>=0?Text('\$'+recibo.cant.toString(),style: TextStyle(color: Colors.green),):Text('\$'+recibo.cant.toString(),style: TextStyle(color: Colors.red),),

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