import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Secenekler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Text(
            "Seçenekler",
            style: TextStyle(fontSize: 20),
          ))
        ],
      ),
    );
  }
}
