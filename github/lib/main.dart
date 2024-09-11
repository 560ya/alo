import 'package:flutter/material.dart';
import 'dart:async'; // Kutish funksiyasi uchun kerak

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // Ko'zcha icon uchun

  String errorMessage = '';

  void validateInput() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == "abdulazizxon" && password == "mirzaakbarov") {
      setState(() {
        errorMessage = ''; 
      });

      // 5 soniya kutib, ikkinchi sahifaga o'tamiz
      Future.delayed(Duration(seconds: 5), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondPage()), // Ikkinchi sahifa
        );
      });
    } else {
      setState(() {
        errorMessage = 'Username yoki password xato!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  errorText: errorMessage.isNotEmpty ? errorMessage : null,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  errorText: errorMessage.isNotEmpty ? errorMessage : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  validateInput();
                }, 
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Bu ikkinchi sahifa uchun oddiy misol
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ikkinchi Sahifa'),
      ),
      body: Center(
        child: Text(
          'Xush kelibsiz!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
