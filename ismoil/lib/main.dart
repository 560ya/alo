import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: bir(),
    ),
  );
}

class bir extends StatefulWidget {
  const bir({super.key});

  @override
  State<bir> createState() => _birState();
}

class _birState extends State<bir> {
 
  Color firstAvatarColor = Colors.black;
  Color secondAvatarColor = Colors.black;
  Color thirdAvatarColor = Colors.black;

  int buttonPressCount = 0;

  void _changeAvatarColor() {
    setState(() {
      buttonPressCount++;

      // Reset all colors to black
      firstAvatarColor = Colors.black;
      secondAvatarColor = Colors.black;
      thirdAvatarColor = Colors.black;


      if (buttonPressCount % 3 == 1) {
        firstAvatarColor = Colors.red;
      } else if (buttonPressCount % 3 == 2) {
        secondAvatarColor = Colors.amber;
      } else if (buttonPressCount % 3 == 0) {
        thirdAvatarColor = Colors.green;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: firstAvatarColor,
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 70,
              backgroundColor: secondAvatarColor,
            ),
            SizedBox(height: 20), 
            CircleAvatar(
              radius: 70,
              backgroundColor: thirdAvatarColor,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeAvatarColor,
        child: Icon(Icons.color_lens),
      ),
    );
  }
}
