import 'package:billetera_virtual/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

class Divisa extends StatefulWidget {
  @override
  _DivisaState createState() => _DivisaState();
}

class _DivisaState extends State<Divisa> {
  final AuthService _auth=AuthService();
  String currencyPath='html/currency.html';
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Divisas"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      /*
      * Carga el valor del html y lo convierte en una pagina dentro de la apliacion con la funcion(_loadHtmlFromAssets())
      * */
      body: WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController){
          _webViewController=webViewController;
          _loadHtmlFromAssets();
        },
      ),

    );
  }

  _loadHtmlFromAssets() async{
    String fileHtmlContents = await rootBundle.loadString(currencyPath);
    _webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,mimeType: 'text/html',encoding: Encoding.getByName('utf-8')).toString());


  }
}
