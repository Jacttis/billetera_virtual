import 'file:///D:/ProyectoDart/billetera_virtual/lib/screens/Home/Pages/Add/TextoModificado.dart';
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
  static LinearGradient myGradient =LinearGradient(colors: [Colors.purpleAccent[700],Colors.purpleAccent[400],Colors.purpleAccent[100]]


  );

  GlobalKey _textNumber = GlobalKey();

  final _controller=TextEditingController();
  InputDecoration _toggle=textInputDecoration.copyWith(hintText:'\$\$\$',fillColor: Colors.deepPurple[700], icon: Icon(Icons.attach_money),);

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
                  onPressed: () {
                    setState(() {
                      _toggle=TextoModificado().devolverNegativo();
                    });
                  },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
              padding: const EdgeInsets.all(0.0),
              child: Ink(
                decoration:  BoxDecoration(
                  gradient: myGradient,
                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                ),
                child: Container(
                  constraints: const BoxConstraints(minWidth: 120.0, minHeight: 36.0), // min sizes for Material buttons
                  alignment: Alignment.center,
                  child: const Text(
                    'Gasto',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      _toggle=TextoModificado().devolverPositivo();
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration:  BoxDecoration(
                      gradient: myGradient,
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    ),
                    child: Container(
                      constraints: const BoxConstraints(minWidth: 120.0, minHeight: 36.0), // min sizes for Material buttons
                      alignment: Alignment.center,
                      child: const Text(
                        'Ingreso',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
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
              decoration: _toggle,
              textAlign: TextAlign.right,
              controller: _controller,
            ),
            SizedBox(height: 20.0,),  
            TextFormField(
              style: TextStyle(
                fontSize: 25,
              ),
              decoration: InputDecoration(
                hintText: 'Descripcion',
                contentPadding: new EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
                border: OutlineInputBorder(borderSide: new BorderSide(color: Colors.teal))
              ),
              textAlign: TextAlign.right,
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

