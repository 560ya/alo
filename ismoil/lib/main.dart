import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Stri()));
}

class Stri extends StatefulWidget {
  const Stri({super.key});

  @override
  State<Stri> createState() => _StriState();
}

class _StriState extends State<Stri> {
  TextEditingController input = TextEditingController();

  List<String> haftaningKunlari = [
    'dushanba',
    "domla",
    "doska",
    'seshanba',
    "sel",
    'chorshanba',
    "choch",
    "chol",
    'payshanba',
    "popka",
    "poyga",
    'juma',
    "jumAN",
    "joja",
    'shanba',
    "shashka",
    'yakshanba',
    "yaxyo",
    "yonbosar",
    "sahro",
    "sanam"
  ];

  String? haf;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: input,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'So\'z kiriting',
              ),
              onChanged: (text) {
                setState(() {
                  if (text.isEmpty) {
                    // Agar matn bo'sh bo'lsa, `haf` ni bo'sh qilamiz
                    haf = '';
                  } else {
                    // Mos keladigan barcha kunlarni topish va bitta stringga birlashtirish
                    List<String> mosKunlar = haftaningKunlari.where(
                      (kun) => kun.startsWith(text.toLowerCase()),
                    ).toList();
                    
                    haf = mosKunlar.join(', ');  // Kunni vergul bilan ajratib birlashtirish
                  }
                });
              },
            ),
            SizedBox(height: 20),
            Container(
              height: 100,
              width: double.infinity, // To'liq kenglikni egallash uchun
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: SingleChildScrollView(
                child: Text(
                  haf ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
