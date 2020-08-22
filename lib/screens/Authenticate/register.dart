import 'package:billetera_virtual/services/auth.dart';
import 'package:billetera_virtual/shared/constans.dart';
import 'package:billetera_virtual/shared/loading.dart';
import 'package:flutter/material.dart';


class Register extends StatefulWidget {

  final Function toggleView;
  Register ({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService= AuthService();
  final _formKey =GlobalKey<FormState>();
  final List<String> monedas=["Peso argentino","Euro","Dolar"];
  //bool loading =false;

  String email='';
  String password1='';
  String password2='';
  String error='';
  String _currentmoneda='Peso argentino';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [Colors.deepPurple[700],Colors.deepPurple[500],Colors.deepPurple[400]]

        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Register",style: TextStyle(color: Colors.black87),),
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
                      validator: (val) => val.isEmpty ?'Enter an email':null,
                      onChanged: (val){
                        setState(()=> email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText:'Password',fillColor: Colors.deepPurple[500]),
                      obscureText: true,
                      validator: (value) => value.length<6 ?'Enter a password 6+ chars long':null,
                      onChanged: (value){
                        setState(()=> password1 = value);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText:'Repeat Password',fillColor: Colors.deepPurple[400]),
                      obscureText: true,
                      validator: (value) => value!=password1 ? 'Las contraseñas no coinciden':null,
                      onChanged: (value){
                        setState(()=> password2 = value);
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
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async{
                          if(_formKey.currentState.validate()){
                            setState(() {
                              //loading=true;
                            });
                            dynamic result = await _authService.registerWithEmailAndPassword(email, password2,_currentmoneda);
                            if(result == null){
                              setState(() {
                                error = 'please supply a valid email ';
                               // loading =false;
                              });
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
                        label: Text('Sign In')),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red,fontSize: 14.0),
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
