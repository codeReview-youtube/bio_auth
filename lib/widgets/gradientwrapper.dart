import 'package:flutter/material.dart';

class GradientWrapper extends StatelessWidget {
  final Widget child;
  Color mainColor;

  GradientWrapper({this.child, this.mainColor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: [
              Colors.indigo[800],
              Colors.indigo[500],
              Colors.indigo[400],
              Colors.indigo[300],
            ],
          ),
        ),
        child: this.child,
      ),
    );
  }
}
