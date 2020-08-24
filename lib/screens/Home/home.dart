import 'package:billetera_virtual/screens/Home/Pages/Add/agregar.dart';
import 'package:billetera_virtual/screens/Home/Pages/Cuenta.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //State class
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final Cuenta _cuenta = Cuenta();
  final Agregar _agregar=Agregar();

  Widget _showPage=new Cuenta();

  Widget _pageChooser(int page){
    switch(page){
      case 0:return _cuenta;break;
      case 1:return _agregar;break;
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          backgroundColor: Colors.deepPurple[400],
          color: Colors.deepPurple[400],
          items: <Widget>[
            Icon(Icons.account_balance_wallet, size: 30),
            Icon(Icons.add_circle, size: 30),
            Icon(Icons.settings, size: 30),
          ],
          onTap: (index) {
            setState(() {
              _showPage  = _pageChooser(index);
            });
          },
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: 10.40),
          decoration:BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.deepPurple[700],Colors.deepPurple[500],Colors.deepPurple[400]]

            ),
          ),
          child:_showPage,
          ),
        );
  }
}
