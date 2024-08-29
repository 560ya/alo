

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false,
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
  List date = [];
  void fetchgate() async {
    final respons =
        await http.get(Uri.parse("https://dash.vips.uz/api/18/167/4460"));
    if (respons.statusCode == 200) {
      final jsondate = json.decode(respons.body);
      for (var item in jsondate) {
        date.add(Map<String, dynamic>.from(item));
      }
      setState(() {});
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchgate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: date.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: 250,
                  width: 700,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 200,
                                        width: 200,
                                        color: 
                                        Colors.red,
                                        child: Image.network("${date[index]["mahsulotrasmi"]}",fit: BoxFit.cover,),
                                      ),
                                      Container(
                                        height: 200,
                                        width: 350,
                                        color: Colors.amber,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text("mahsulotnomi:   ",
                                                      style: TextStyle(
                                                    color: Colors.white
                                                  ),),
                                                  Text("${date[index]["mahsulotnomi"]}",
                                                  style: TextStyle(
                                                    color: Colors.white
                                                  ),)
                                                ],
                                              ),
                                            ),
                                              Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text("summa:   ",
                                                      style: TextStyle(
                                                    color: Colors.white
                                                  ),),
                                                  Text("${date[index]["narxi"]}",
                                                  style: TextStyle(
                                                    color: Colors.white
                                                  ),)
                                                ],
                                              ),
                                            ),
                                             Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text("olchov narxi:   ",
                                                      style: TextStyle(
                                                    color: Colors.white
                                                  ),),
                                                  Text("${date[index]["ulchovturi"]}",
                                                  style: TextStyle(
                                                    color: Colors.white
                                                  ),)
                                                ],
                                              ),
                                            ),
                                              Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text("ishlab chiqrilgan sana:   ",
                                                      style: TextStyle(
                                                    color: Colors.white
                                                  ),),
                                                  Text("${date[index]["exdate"]}",
                                                  style: TextStyle(
                                                    color: Colors.white
                                                  ),)
                                                ],
                                              ),
                                            ),
                                              Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text("miqdori:   ",
                                                      style: TextStyle(
                                                    color: Colors.white
                                                  ),),
                                                  Text("${date[index]["miqdori"]}",
                                                  style: TextStyle(
                                                    color: Colors.white
                                                  ),)
                                                ],
                                              ),
                                            ),
                                            
                                            
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                         Container(
                                        height: 40,
                                        width: 230,
                                        color: Colors.amber,),
                                      Container(
                                        height: 40,
                                        width: 250,
                                        child: Row(
                                          children: [
                                            Text("mahsulotid",
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                               color: Colors.white
                                            ),),
                                            Text("${date[index]["mahsulotid"]}",
                                                   style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),      
                                    ),
                ),
              ],
            );
          }),
    );
  }
}
