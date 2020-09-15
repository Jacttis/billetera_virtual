import 'package:billetera_virtual/models/User.dart';
import 'package:billetera_virtual/screens/Home/Pages/Agregar/AgregarImagen.dart';
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
         /*
          * TextField que guarda el valor de la entrada numericaPositiva
          * */
  static  TextFormField _entradaCantidadPositiva= TextFormField(
    controller: _controladorNumero,
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
           /*
          * TextField que guarda el valor de la entrada numericaNegativa
          * */

  static TextFormField _entradaCantidadNegativa= TextFormField(
    controller: _controladorNumero,
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

  //Guarda el valor de la entrada dependiendo de si es un gasto o un ingreso
  TextFormField _textoEntrada=_entradaCantidadNegativa;

  static TextEditingController _controladorTitulo = new TextEditingController();
  static TextEditingController _controladorDescripcion = new TextEditingController();
  static TextEditingController _controladorNumero=new TextEditingController();
  File image;
  AgregarImagen logicaFoto=AgregarImagen();
  DatabaseService databaseService = DatabaseService.getInstaceC();
  String titulo;
  static double number;
  String descripcion;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 20.0,),
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
            /*
            * Cambia el valor de la entrada de texto  depende de la opcion obtenida
            * Si se cambia de gasto a ingreso se limpia el valor
            * */
            radioButtonValue: (value) {
              setState(() {
                if(value =='GASTO'){
                  _textoEntrada=_entradaCantidadNegativa;
                  _textoEntrada.controller.clear();
                }
                else{
                  _textoEntrada=_entradaCantidadPositiva;
                  _textoEntrada.controller.clear();
                }
              });
            },
            selectedColor:Colors.deepPurple[500],
          ),

          SizedBox(height: 20.0,),
          /*
          * TextField que guarda el valor del titulo
          * */
          Container(
            margin: EdgeInsets.only(left: 40),
            child: TextFormField(
              controller: _controladorTitulo,
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
                hintText: 'Título',
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

          _textoEntrada,

          SizedBox(height: 20.0,),
          /*
          * TextField que guarda el valor de la Descripcion
          * */
          Container(
            margin: EdgeInsets.only(left: 40),
            child: TextFormField(
              controller: _controladorDescripcion,
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
                  hintText: 'Descripción',
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
              /*
              * Container que contiene la imagen a subir , al hacer tap sobre esta
              * se puede ver en patnalla completa
              * */
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

              //SizedBox(width: MediaQuery.of(context).size.width-330,),
              /*
              * Boton de subir imagen desde la camara
              * */
              Container(
                alignment: Alignment.centerRight,
                width:MediaQuery.of(context).size.width-150,
                child: RaisedButton.icon(
                  textColor: Colors.white,
                  color: Colors.black38,
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
              ),

            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height-600,),
          /*
          * Al presionar el boton 'Crear' se sube la imagen a la storage y se sube el recibo a la base de datos
          * luego se limpian los valores y los TextFiled y la imagen
          * Si no se completo la cantidad deseada y el titulo no se crea y se avisa al usuario
          * */
          RaisedButton(
            color: Colors.black38,
            textColor: Colors.white,
            child: Text('Crear'),

            onPressed: () async{
              if(_textoEntrada.controller.text!='' && _controladorTitulo.text!='') {
                if (image != null) {
                  var url = await StorageService(uid: user.uid).startUpload(
                      image);
                  databaseService.addRecibo(descripcion, number, url, titulo);
                }
                else {
                  databaseService.addRecibo(descripcion, number, '', titulo);
                }
                _controladorTitulo.clear();
                _controladorDescripcion.clear();
                _textoEntrada.controller.clear();
                setState(() {
                  image = null;
                });

                Scaffold
                    .of(context)
                    .showSnackBar(SnackBar(content: Text(" Recibo Creado"),
                  backgroundColor: Colors.black,));
              }
              else{
                Scaffold
                    .of(context)
                    .showSnackBar(SnackBar(content: Text("No se pudo crear el recibo \nTitulo y Cantidad(\$\$\$) obligatoria"),
                  backgroundColor: Colors.black,));
              }
            },
          )

        ],

      ),
    );
  }


}

