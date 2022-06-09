import 'dart:async';
import 'package:flutter/material.dart';

class Achievements extends StatelessWidget {
  const Achievements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        title: Text('Achievements page'),
        centerTitle: true,
      ),
       body: Center(
        child: RaisedButton(
            child: Text('Back To HomeScreen'),
            color: Colors.red, //Theme.of(context).primaryColor
            textColor: Colors.white,
            onPressed: () => Navigator.pop(context)
        ),
      ),
    );
  }
}