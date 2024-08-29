import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: azim(),
  ));
}
class azim extends StatefulWidget {
  const azim({super.key});

  @override
  State<azim> createState() => _azimState();
}

class _azimState extends State<azim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
        Text("Salom",
        style: TextStyle(
          fontSize: 33,
          fontWeight: FontWeight.bold,
        ),),
      ),
    );
  }
}