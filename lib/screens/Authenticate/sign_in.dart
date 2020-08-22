import 'package:billetera_virtual/services/auth.dart';
import 'package:billetera_virtual/shared/constans.dart';
import 'package:billetera_virtual/shared/loading.dart';
import 'package:flutter/material.dart';
class SingIn extends StatefulWidget {

  final Function toggleView;
  SingIn ({this.toggleView});
  @override
  _SingInState createState() => _SingInState();
}

class _SingInState extends State<SingIn> {

  final AuthService _authService= AuthService();
  final _formKey =GlobalKey<FormState>();
  //bool loading =false;

  String email='';
  String password='';
  String error='';
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Container(
      decoration:BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [Colors.deepPurple[700],Colors.deepPurple[500],Colors.deepPurple[400]]

        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Sign In",style: TextStyle(color: Colors.black87),),
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
                        setState(()=> password = value);
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
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async{
                          if(_formKey.currentState.validate()){
                            setState(() => loading = true);
                            dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                            if(result == null){
                              setState((){
                                error = 'could not sign in with those credential ';
                                loading = false;
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
                        label: Text('Sign up')),
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
