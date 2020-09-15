import 'package:billetera_virtual/models/User.dart';
import 'package:billetera_virtual/screens/Home/Pages/Mas/Usuarios/usuarioPageView.dart';
import 'package:billetera_virtual/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsuarioPage extends StatefulWidget {
  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: DatabaseService.getInstaceC().obtenerUsuario(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Cuenta'),
          backgroundColor: Colors.deepPurple[700],
          elevation: 1,
        ),
        body: UsuarioPageView(),
      ),
    );
  }
}
