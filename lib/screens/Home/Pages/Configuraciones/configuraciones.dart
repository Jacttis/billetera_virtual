import 'package:billetera_virtual/services/auth.dart';
import 'package:flutter/material.dart';

class Configuraciones extends StatefulWidget {
  @override
  _ConfiguracionesState createState() => _ConfiguracionesState();
}

class _ConfiguracionesState extends State<Configuraciones> {
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Configuraciones"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          FlatButton.icon(
              onPressed: ()async {
                await _auth.singOut();

              },
              icon: Icon(Icons.person),
              label: Text('logout'))
        ],
      ),

    );
  }
}
