import 'package:billetera_virtual/models/User.dart';
import 'package:billetera_virtual/screens/Authenticate/authenticate.dart';
import 'package:billetera_virtual/screens/Authenticate/register.dart';
import 'package:billetera_virtual/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home/home.dart';



class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
    * Usuario actual
    * */
    final user = Provider.of<User>(context);

    /*
    * Si el Usuario Actual es nulo entonces devuelve la pagina de Autentificacion, si no devuelve la pantalla home.
    * */
    if(user == null){
      return Authenticate();
    }
    else{
      DatabaseService.getInstance(user.uid);
      return Home();
    }
  }
}