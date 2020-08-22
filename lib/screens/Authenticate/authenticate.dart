import 'package:billetera_virtual/screens/Authenticate/register.dart';
import 'package:billetera_virtual/screens/Authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSign = true;
  void toggleView(){
    setState(() => showSign = !showSign);
  }

  @override
  Widget build(BuildContext context) {
    if(showSign){
      return SingIn(toggleView: toggleView);
    }
    else{
      return Register(toggleView: toggleView);
    }
  }
}
