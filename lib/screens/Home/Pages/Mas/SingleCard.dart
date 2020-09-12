import 'package:flutter/material.dart';

class SingleCard{

  final Icon icono;
  final BuildContext contexto;
  final StatefulWidget pagina;
  final String texto;
  SingleCard({this.icono,this.texto,this.contexto,this.pagina});

  Card crearCarta(){
    return Card(
      elevation: 0.05,
      color: Colors.transparent,
      child: InkWell(
        onTap:(){ Navigator.push(contexto, MaterialPageRoute(builder: (_) {return pagina;})); } ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icono,
            Text(texto,style: TextStyle(color: Colors.black,fontSize: 25.0),)
          ],
        ),
      ),
    );
  }

}