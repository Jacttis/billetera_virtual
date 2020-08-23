import 'package:billetera_virtual/models/User.dart';
import 'package:billetera_virtual/services/auth.dart';
import 'package:billetera_virtual/services/database.dart';
import 'package:billetera_virtual/shared/constans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Agregar extends StatefulWidget {

  @override
  _AgregarState createState() => _AgregarState();
}

class _AgregarState extends State<Agregar> {
  final AuthService _auth = AuthService();

  GlobalKey _textNumber = GlobalKey();

  final _controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return  Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Add'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: ()async {
                await _auth.singOut();

              },
              icon: Icon(Icons.person),
              label: Text('logout'))
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            ButtonBar(
              children: [
                RaisedButton(
                  child: Text("Gasto"),
                  onPressed: (){
                   setState(() {
                     _controller.text='-0';
                   });
                  },
                ),
                RaisedButton(
                  child: Text("Ingreso"),
                ),

              ],
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              key: _textNumber,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 25,
              ),
              decoration: textInputDecoration.copyWith(hintText:'\$\$\$',fillColor: Colors.deepPurple[700], icon: Icon(Icons.attach_money),),
              textAlign: TextAlign.right,
              controller: _controller,
            )

          ],

        ),
      ),
    );




    /*Container(
      child:RaisedButton(
          onPressed: ()async{
            await DatabaseService(uid: user.uid).addRecibo("Prueba  boton", 20.5);

          }
          ),

    );*/
  }
}

