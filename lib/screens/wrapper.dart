import 'package:billetera_virtual/models/User.dart';
import 'package:billetera_virtual/screens/Authenticate/authenticate.dart';
import 'package:billetera_virtual/screens/Authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home/home.dart';



class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Hello World");
    final user = Provider.of<User>(context);
    print(user);
    //return either home or authenticate widget
    if(user == null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}