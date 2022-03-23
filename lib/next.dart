import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Next extends StatefulWidget{
  final color;

  Next({required this.color});




  @override
  NextState createState() => NextState();
}

class NextState extends State<Next>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle page"),
        backgroundColor: widget.color,
      ),
      body: const Center(
        child: Text("Ceci est la page NEXT"),
      ),
    );
  }

}