import 'package:billetera_virtual/services/auth.dart';
import 'package:billetera_virtual/shared/constans.dart';
import 'package:billetera_virtual/shared/loading.dart';
import 'package:flutter/material.dart';


class Register extends StatefulWidget {
  /*
  * Requiere un cambio de vista para cambiar de registro a Inicio de sesion,
  * */
  final Function toggleView;
  Register ({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService= AuthService();
  final _formKey =GlobalKey<FormState>();
  final List<String> monedas=["Peso argentino","Euro","Dolar"];
  bool loading =false;

  String _email='';
  String _password1='';
  String _password2='';
  String _error='';
  String _currentmoneda='Peso argentino';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration:BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [Colors.deepPurple[700],Colors.deepPurple[500],Colors.deepPurple[400]]

        ),
      ),


      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Registro",style: TextStyle(color: Colors.black87),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),


        body: SingleChildScrollView(

          child: Container(
              padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[

                    SizedBox(height: 20.0),

                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText:'Email',fillColor: Colors.deepPurple[700]),
                      validator: (val) => val.isEmpty ?'Ingrese un email':null,
                      onChanged: (val){
                        setState(()=> _email = val);
                      },
                    ),

                    SizedBox(height: 20.0),

                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText:'Contraseña',fillColor: Colors.deepPurple[500]),
                      obscureText: true,
                      validator: (value) => value.length<6 ?'Ingrese una contraseña con mas de 6 digitos':null,
                      onChanged: (value){
                        setState(()=> _password1 = value);
                      },
                    ),

                    SizedBox(height: 20.0),

                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText:'Repetir Contraseña',fillColor: Colors.deepPurple[400]),
                      obscureText: true,
                      validator: (value) => value!=_password1 ? 'Las contraseñas no coinciden':null,
                      onChanged: (value){
                        setState(()=> _password2 = value);
                      },
                    ),

                    SizedBox(height: 20.0),

                    DropdownButtonFormField(
                      dropdownColor: Colors.deepPurple[100],
                      focusColor: Colors.amber,
                      value: _currentmoneda ?? "Peso argentino",
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

                    SizedBox(height: 20.0),

                    ButtonTheme(
                      minWidth: 200.0,
                      height: 50.0,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                        color: Colors.black87,
                        child: Text(
                          'Registrar',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async{
                          if(_formKey.currentState.validate()){
                            setState(() {
                              loading=true;
                            });
                            /*
                            *result devuelve el usuario registrado en cambio si devuelve un String se evalua el error obtenido
                            * */
                            dynamic result = await _authService.registerWithEmailAndPassword(_email, _password2,_currentmoneda);
                            if(result == 'ERROR_EMAIL_ALREADY_IN_USE'){
                              setState(() {
                                _error = 'Este email ya esta en uso ';
                                loading =false;
                              });
                            }
                            else{
                              if(result == 'ERROR_INVALID_EMAIL'){
                                setState(() {
                                  _error = 'Ingrese un email valido ';
                                  loading =false;
                                });
                              }
                            }
                          }
                        },
                      ),
                    ),

                    SizedBox(height:12.0),

                    FlatButton.icon(
                        onPressed: (){
                          widget.toggleView();
                        },
                        icon: Icon(Icons.person),
                        label: Text('Inicio Sesion')),
                    Text(
                      _error,
                      style: TextStyle(color: Colors.red[700],fontSize: 17.0),
                    ),
                  ],

                ),
              )
          ),
        ),
      ),
    );
  }
}
