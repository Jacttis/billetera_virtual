import 'package:flutter/material.dart';

class TextoModificado{

  InputDecoration texto;

  TextoModificado();

  InputDecoration devolverNegativo(){
    texto=new InputDecoration(
      fillColor: Colors.deepPurple[700], icon: Icon(Icons.attach_money),
      hintText: '-0',
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white70, width: 2.0),
      ),
    );
    return texto;
  }

  InputDecoration devolverPositivo(){
    texto=new InputDecoration(
      hintText: '+0',
      fillColor: Colors.deepPurple[700], icon: Icon(Icons.attach_money),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white70, width: 2.0),
      ),
    );
    return texto;
  }



}