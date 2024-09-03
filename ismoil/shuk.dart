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
  // State to keep track of the selected star index
  int selectedStar = 0;

  // State to keep track of the text value
  int textCount = 1;
  String topRightText = 'R1';

  // State to manage the visibility of the input field in the top right
  bool isTopRightEditing = false;

  // State to keep track of the center text
  String centerText = "Nazarov O";

  // State to show/hide the input field
  bool isEditing = false;

  // Controller to manage the input field text
  TextEditingController _controller = TextEditingController();
  TextEditingController _topRightController = TextEditingController();

  // Function to change the selected star
  void _onStarTap(int index) {
    setState(() {
      selectedStar = index;
    });
  }

  // Function to update the top-right text value when tapped
  void _toggleTopRightEditing() {
    setState(() {
      isTopRightEditing = true;
      _topRightController.text = topRightText; // Set the current text in the input field
    });
  }

  // Function to save the new top-right text value
  void _saveTopRightText() {
    setState(() {
      topRightText = _topRightController.text;
      isTopRightEditing = false;
    });
  }

  // Function to toggle between text and input field in the center
  void _toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      _controller.text = centerText; // Set the current text in the input field
    });
  }

  // Function to save the new center text value
  void _saveText() {
    setState(() {
      centerText = _controller.text; // Update the center text with input value
      isEditing = false; // Hide the input field
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            image: DecorationImage(
              image: AssetImage("rasm/rasm17.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          height: 400,
          width: 600,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Aligns stars to the left
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          Icons.star,
                          color: index < selectedStar ? Colors.amber : Colors.grey,
                        ),
                        onPressed: () {
                          _onStarTap(index + 1); // Update the selected star index
                        },
                      );
                    }),
                  ),
                ],
              ),
              // Top-right text (R1, R2, ...)
              Positioned(
                top: 10,
                right: 10,
                child: isTopRightEditing
                    ? Container(
                        width: 80, // Small input field
                        child: TextField(
                          controller: _topRightController,
                          onSubmitted: (_) => _saveTopRightText(),
                          decoration: InputDecoration(
                            hintText: "Enter text",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: _toggleTopRightEditing,
                        child: Text(
                          topRightText,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
              // Bottom-right date text
              Positioned(
                bottom: 10, // Position the text at the bottom-right corner
                right: 10,
                child: Text(
                  '31.07.2024',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              // Center text (Nazarov O)
              Center(
                child: isEditing
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _controller,
                          onSubmitted: (_) => _saveText(),
                          decoration: InputDecoration(
                            hintText: "Enter new text",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: _toggleEditing, // Toggle to input field on tap
                        child: Text(
                          centerText,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
