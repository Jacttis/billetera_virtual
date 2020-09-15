import 'file:///D:/ProyectoDart/billetera_virtual/lib/screens/Home/Pages/Mas/SingleCard.dart';
import 'file:///D:/ProyectoDart/billetera_virtual/lib/screens/Home/Pages/Mas/Usuarios/UsuarioPage.dart';
import 'package:billetera_virtual/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Divisas/divisas.dart';

class MasPage extends StatefulWidget{
  @override
  _MasPageState createState() => _MasPageState();
}

class _MasPageState extends State<MasPage> {
  final AuthService _auth=AuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        title: Text("Mas Opciones"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,

        actions: [
          FlatButton.icon(
              onPressed: ()async {
                await _auth.singOut();

              },
              icon: Icon(Icons.person),
              label: Text('Cerrar Sesion'))
        ],
      ),

        /*
        * Creo un GridView de 2 columnas ,Cada hijo es una SingleCard
        * */
        body: GridView.count(

        crossAxisCount: 2,

        children:[
           SingleCard(icono: Icon(Icons.attach_money,size: 85.0,color: Colors.black,),texto: 'Divisas',contexto: context,pagina: Divisa(),lista: true).crearCarta(),
          SingleCard(icono: Icon(Icons.account_circle,size: 85.0,color: Colors.black,),texto: 'Usuario',contexto: context,pagina: UsuarioPage(),lista: true).crearCarta(),
          SingleCard(icono: Icon(Icons.group,size: 85.0,color: Colors.black,),texto: 'Grupos',contexto: context,lista: false).crearCarta(),
        ],
      )
    );

}

}
