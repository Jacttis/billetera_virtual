
import 'package:billetera_virtual/models/User.dart';
import 'package:billetera_virtual/screens/Home/Pages/Add/AgregarView.dart';
import 'package:billetera_virtual/services/auth.dart';
import 'package:billetera_virtual/services/database.dart';
import 'package:billetera_virtual/shared/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Agregar extends StatefulWidget {

  @override
  _AgregarState createState() => _AgregarState();
}

class _AgregarState extends State<Agregar> {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Add'),
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
      body:AgregarView(),
    );




    /*Container(
      child:RaisedButton(
          onPressed: ()async{
            await DatabaseService(uid: user.uid).addRecibo("Prueba  boton", 20.5);

          }
          ),

    );*/
  }
}

