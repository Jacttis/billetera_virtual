import 'package:flutter/material.dart';


const textInputDecoration = InputDecoration(
  fillColor: Colors.deepPurple,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black87, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white70, width: 2.0),
  ),
);

TextFormField entradaCantidadPositiva= TextFormField(

  keyboardType: TextInputType.number,
  style: TextStyle(
    fontSize: 25,


  ),
  decoration: textInputDecoration.copyWith(hintText:'\$\$\$',fillColor: Colors.deepPurple[700], icon: Icon(Icons.add,color: Colors.black,)),
  textAlign: TextAlign.right,
);

TextFormField entradaCantidadNegative= TextFormField(
  keyboardType: TextInputType.number,
  style: TextStyle(
    fontSize: 25,
  ),
  decoration: textInputDecoration.copyWith(hintText:'\$\$\$',fillColor: Colors.deepPurple[700], icon: Icon(Icons.remove,color: Colors.black,),),
  textAlign: TextAlign.right,
);
/*const gradiente = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topCenter,
      colors: [Colors.deepPurple[500],Colors.deepPurple[400]]

  );
);*/
