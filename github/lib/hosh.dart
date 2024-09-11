import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Diagonal Container Example"),
          backgroundColor: Colors.blueGrey,
        ),
        body: Center(
          child: Transform(
            // Rotate the container 45 degrees along the Z-axis
            transform: Matrix4.rotationZ(0.785398), // 45 degrees in radians
            alignment: Alignment.center,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(
                "rasm/rasm012.jpg", 
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
