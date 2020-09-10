import 'package:billetera_virtual/models/User.dart';
import 'package:billetera_virtual/screens/Home/Pages/Add/AgregarImagen.dart';
import 'package:billetera_virtual/screens/Home/Pages/detailsScreen.dart';
import 'package:billetera_virtual/services/database.dart';
import 'package:billetera_virtual/services/storage.dart';
import 'package:billetera_virtual/shared/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:provider/provider.dart';
import 'dart:io';


class AgregarView extends StatefulWidget {
  @override
  _AgregarViewState createState() => _AgregarViewState();
}

class _AgregarViewState extends State<AgregarView> {

  static  TextFormField entradaCantidadPositiva= TextFormField(
    controller: controladorNumero,
    onChanged: (num){
      number=double.parse(num);
    },
    keyboardType: TextInputType.number,
    style: TextStyle(
      fontSize: 25,
    ),
    decoration: textInputDecoration.copyWith(hintText:'\$\$\$',fillColor: Colors.deepPurple[700], icon: Icon(Icons.add,color: Colors.black,)),
    textAlign: TextAlign.right,
  );

  static TextFormField entradaCantidadNegativa= TextFormField(
    controller: controladorNumero,
    onChanged: (num){
      number=double.parse(num);
      number=-number;
    },
    keyboardType: TextInputType.number,
    style: TextStyle(
      fontSize: 25,
    ),
    decoration: textInputDecoration.copyWith(hintText:'\$\$\$',fillColor: Colors.deepPurple[700], icon: Icon(Icons.remove,color: Colors.black,),),
    textAlign: TextAlign.right,
  );

  String valor='GASTO';
  TextFormField textoEntrada=entradaCantidadNegativa;
  static TextEditingController controladorTitulo = new TextEditingController();
  static TextEditingController controladorDescripcion = new TextEditingController();
  static TextEditingController controladorNumero=new TextEditingController();
  File image;
  AgregarImagen logicaFoto=AgregarImagen();
  DatabaseService _databaseService = DatabaseService.getInstaceC();
  String titulo;
  static double number;
  String descripcion;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
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
                  textoEntrada=entradaCantidadNegativa;
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
              controller: controladorTitulo,
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
              onChanged:(tit){
                titulo=tit;
              },
            ),
          ),
          SizedBox(height: 20.0,),
          textoEntrada,
          SizedBox(height: 20.0,),

          Container(
            margin: EdgeInsets.only(left: 40),
            child: TextFormField(
              controller: controladorDescripcion,
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
              onChanged:(Desc){
                descripcion=Desc;
              },
            ),
          ),
          SizedBox(height:10.0),
          Row(
            children: [
              SizedBox(width: 50,),
              Container(
                width: 100,
                height: 100,
                child:GestureDetector(
                  child:(image!=null)?Image.file(image,fit: BoxFit.fill,):null,
                  onTap: () {
                    if(image!=null){
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DetailScreen(image);

                  }));}},
                ),
              ),
              SizedBox(width: 110,),
              RaisedButton.icon(
                textColor: Colors.white,
                color: Colors.black87,
                label: Text('Subir Imagen'),
                onPressed: ()async {
                    image= await logicaFoto.getImage();
                    setState(() {
                      // ignore: unnecessary_statements
                      image;
                    });
                  },
                icon: Icon(Icons.cloud_upload),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),


              ),

            ],
          ),
          SizedBox(height: 50,),
          RaisedButton(
            color: Colors.black,
            textColor: Colors.white,
            child: Text('Crear'),
            onPressed: () async{
              if(image!=null) {
                var url = await StorageService(uid: user.uid).startUpload(image);
                _databaseService.addRecibo(
                    descripcion, number, url, titulo);
              }
              controladorTitulo.clear();
              controladorDescripcion.clear();
              textoEntrada.controller.clear();
              image=null;
              Scaffold
                  .of(context)
                  .showSnackBar(SnackBar(content: Text(" Recibo Creado")));

            },
          )

        ],

      ),
    );
  }


}

