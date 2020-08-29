import 'package:billetera_virtual/services/auth.dart';
import 'package:billetera_virtual/shared/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'TextoModificado.dart';


class AgregarView extends StatefulWidget {
  @override
  _AgregarViewState createState() => _AgregarViewState();
}

class _AgregarViewState extends State<AgregarView> {

  String valor='GASTO';
  TextFormField textoEntrada=entradaCantidadNegative;
  File image;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          CustomRadioButton(
            elevation: 100,
            unSelectedColor: Colors.black12,
            buttonLables: [
              'Gasto',
              'Ingreso',
            ],
            customShape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
            enableShape: true,
            defaultSelected: 'GASTO',
            buttonValues: [
              'GASTO',
              'INGRESO',
            ],
            buttonTextStyle: ButtonTextStyle(
                selectedColor: Colors.white,
                unSelectedColor: Colors.white38,
                textStyle: TextStyle(fontSize: 16)),
            radioButtonValue: (value) {
              setState(() {
                if(value =='GASTO'){
                  textoEntrada=entradaCantidadNegative;
                }
                else{
                  textoEntrada=entradaCantidadPositiva;
                }
              });
            },
            selectedColor:Colors.deepPurple[500],
          ),
          SizedBox(height: 20.0,),
          Container(
            margin: EdgeInsets.only(left: 40),
            child: TextFormField(
              style: TextStyle(
                fontSize: 25,
              ),
              decoration: InputDecoration(
                fillColor: Colors.deepPurple[700],
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70, width: 2.0),
                ),
                hintText: 'titulo',
                contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                border: OutlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
                isDense: true,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(height: 20.0,),
          textoEntrada,
          SizedBox(height: 20.0,),

          Container(
            margin: EdgeInsets.only(left: 40),
            child: TextFormField(
              style: TextStyle(
                fontSize: 25,
              ),
              decoration: InputDecoration(
                fillColor: Colors.deepPurple[700],
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70, width: 2.0),
                ),
                  hintText: 'Descripcion',
                  contentPadding: new EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
                  border: OutlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
                  isDense: true,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(height:10.0),
          Row(
            children: [
              SizedBox(width: 260,),
              RaisedButton.icon(
                textColor: Colors.white,
                color: Colors.black87,
                label: Text('Subir Imagen'),
                onPressed: (){},
                icon: Icon(Icons.cloud_upload),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),


              ),
            ],
          )

        ],

      ),
    );
  }
}
