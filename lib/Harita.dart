import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Harita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Text(
            "Harita",
            style: TextStyle(fontSize: 20),
          ))
        ],
      ),
    );
  }
}
