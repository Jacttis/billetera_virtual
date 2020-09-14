import 'package:flutter/material.dart';

class SingleCard{

  final Icon icono;
  final BuildContext contexto;
  final StatefulWidget pagina;
  final String texto;
  final bool lista;
  SingleCard({this.icono,this.texto,this.contexto,this.pagina,this.lista});

  Card crearCarta(){

    return Card(
      elevation: 0.05,
      color: Colors.transparent,

      child: InkWell(
        onTap:pagina!=null?(){ Navigator.push(contexto, MaterialPageRoute(builder: (_) {return pagina;})); } :(){},

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          /*
          * Crea un carta con los hijos:
          * + Si esta lista la pagina(lista==true) no muestra nada en cambio si no esta lista Crear un Texto que dice proximamente
          * + Muestra el icono
          * + Devuelve el texto con el nombre de la pagina
          * */
          children: [
            lista==true?SizedBox(height: 0.0,):Text('Proximamente',style: TextStyle(color: Colors.red),),
            icono,
            Text(texto,style: TextStyle(color: Colors.black,fontSize: 25.0),)
          ],
        ),
      ),
    );
  }

}