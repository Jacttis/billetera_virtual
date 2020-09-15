import 'dart:io';

import 'package:billetera_virtual/models/User.dart';
import 'package:billetera_virtual/models/UsuarioInfo.dart';
import 'package:billetera_virtual/screens/Home/Pages/Agregar/AgregarImagen.dart';
import 'package:billetera_virtual/services/database.dart';
import 'package:billetera_virtual/services/storage.dart';
import 'package:billetera_virtual/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsuarioPageView extends StatefulWidget {
  @override
  _UsuarioPageViewState createState() => _UsuarioPageViewState();
}

class _UsuarioPageViewState extends State<UsuarioPageView> {

  final List<String> monedas=["Peso argentino","Euro","Dolar"];
  String _currentmoneda;
  File image;
  AgregarImagen logicaFoto=AgregarImagen();
  DatabaseService databaseService = DatabaseService.getInstaceC();
  bool loading=true;
  String nombre;


  @override
  Widget build(BuildContext context) {
    final usuarioInfo = Provider.of<UsuarioInfo>(context)?? null;
    final user = Provider.of<User>(context);
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    if(usuarioInfo!=null){
      setState(() {
        loading=false;
      });
    }
    return loading?Loading():SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: Container(
          height: MediaQuery.of(context).size.height-100,
          width: MediaQuery.of(context).size.width,
          decoration:BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.deepPurple[700],Colors.deepPurple[500],Colors.deepPurple[400]]

            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              /*
              * Avatar si tiene una imagen cargada en la base de datos la muestra, si no hasta que no se cambie la imagen no se muestra nada
              * */
              CircleAvatar(
               backgroundImage: usuarioInfo.path!=''?NetworkImage(usuarioInfo.path):null,
                radius: 80.0,
                child: ClipOval(
                    child: SizedBox(
                      width: 267,
                      height: 267,
                      child: (image!=null)?Image.file(image,fit: BoxFit.fill,):null,
                    )
                ),
              ),

              /*
              Container que contiene al boton de Cambiar Imagen que llama a la logica de AgregarImagen y la selecciona de la camara
              * */
              Container(

                child: FlatButton.icon(
                  textColor: Colors.white,
                  color: Colors.deepPurple,
                  label: Text('Cambiar Imagen'),
                  onPressed: ()async {
                    image= await logicaFoto.getImage();
                    setState(() {
                      // ignore: unnecessary_statements
                      image;
                    });
                  },

                  icon: Icon(Icons.edit),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),


                ),
              ),

              SizedBox(height: 60.0,),
              /*
              * Fila que contiene el Text nombre y su respectivo nombre en la base de datos, si es la primera vez que entra
              * se le asigna su email.
              * */
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nombre:'),
                  SizedBox(width: 10.0,),
                  Container(
                    width: 140.0,
                    child:TextFormField(

                      decoration: InputDecoration(
                        fillColor: Colors.deepPurple[700],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70, width: 2.0),
                        ),
                        contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
                        isDense: true,
                      ),
                      initialValue: usuarioInfo.nombre,
                      onChanged: (nom){
                        nombre=nom;
                      },
                    )
                  ),
                ],
              ),


              SizedBox(height: 10.0,),
              /*
              * Fila que contiene un Text moneda y su actual moneda(_currentmoneda) elegida al iniciar sesion
              * Se puede modificar mediante un DropdownButton
              * */
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Moneda:'),
                  SizedBox(width: 10.0,),
                  Container(
                    width: 140.0,
                    child: DropdownButtonFormField(
                      iconEnabledColor: Colors.white,
                      dropdownColor: Colors.deepPurple[100],
                      focusColor: Colors.amber,
                      value: _currentmoneda ?? usuarioInfo.moneda,
                      items: monedas.map((moneda){
                        return DropdownMenuItem(
                          value: moneda,
                          child: Text('$moneda'),
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(()=> _currentmoneda = value);
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.0,),
              /*
              * Boton que actualiza lo modificado a la base de datos
              * Se pregunta si los valores fueron modificado con el operador ternario si no fueron modificados
              * se les asigna el valor en la base de datos
              * */
              RaisedButton(
                color: Colors.deepPurple,
                textColor: Colors.white,
                child: Text('Guardar Cambios'),

                onPressed: () async{
                  nombre==null?nombre=usuarioInfo.nombre:nombre=nombre;
                  _currentmoneda==null?_currentmoneda=usuarioInfo.moneda:_currentmoneda=_currentmoneda;
                  if(image!=null) {
                    var url = await StorageService(uid: user.uid).startUpload(image);
                    databaseService.actualiarPerfil(nombre, _currentmoneda, url);
                  }
                  else{
                    databaseService.actualiarPerfil(nombre,_currentmoneda,usuarioInfo.path);
                  }
                  setState(() {
                    image=null;
                  });

                  Scaffold
                      .of(context)
                      .showSnackBar(SnackBar(content: Text(" Usuario Modificado"),backgroundColor: Colors.black,));
                },

              )

            ],
          ),
        ),
      ),
    );
  }
}

