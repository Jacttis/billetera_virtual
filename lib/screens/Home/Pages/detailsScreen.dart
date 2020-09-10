import 'dart:io';

import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  Image imagen;
  DetailScreen(File image1){
    imagen=Image.file(image1);
  }
  DetailScreen.from(NetworkImage net) {
    imagen=Image.network(net.url);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: imagen,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
