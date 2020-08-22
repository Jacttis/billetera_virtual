import 'package:billetera_virtual/screens/wrapper.dart';
import 'package:billetera_virtual/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return StreamProvider.value(
     value: AuthService().user,
     child: MaterialApp(
       home: Wrapper(),
     ),
   );
  }

}