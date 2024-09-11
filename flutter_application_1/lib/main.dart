import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: asosiynav(),
    );
  }
}

class asosiynav extends StatefulWidget {
  const asosiynav({super.key});

  @override
  State<asosiynav> createState() => _asosiynavState();
}

class _asosiynavState extends State<asosiynav> {
  List listnom = [
    QuranScreen(),
    PrayerTimes(),
    uch(),
    turt(),
    besh(),
  ];
  int nom = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listnom.elementAt(nom),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(CupertinoIcons.clock),
          Icon(Icons.search, size: 30),
          Icon(Icons.bookmark, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            nom = index;
          });
        },
      ),
    );
  }
}

class QuranScreen extends StatefulWidget {
  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  List<dynamic> verses = [];

  void fetchQuranData() async {
    final response =
        await http.get(Uri.parse("https://api.alquran.cloud/v1/quran/en.asad"));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final data = jsonData['data'];
      setState(() {
        verses = data['surahs'];
      });
    } else {
      print('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuranData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qur\'an'),
        backgroundColor: Colors.grey,
      ),
 
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("rasm/quran1.jpg"),fit: BoxFit.cover)
        ),
        height: double.infinity,
        width: double.infinity,
        child: verses.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: verses.length,
                itemBuilder: (context, index) {
                  final surah = verses[index];
                  return ListTile(
                    title: Text(
                      surah['englishName'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,  // Shrift o'lchami 25
                      ),
                    ),
                    subtitle: Text(
                      surah['englishNameTranslation'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,  // Shrift o'lchami 25
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            surah: surah,
                            toggleTheme: () {
                              // Implement theme toggle functionality
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final dynamic surah;
  final VoidCallback toggleTheme;

  DetailScreen({required this.surah, required this.toggleTheme});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isUzbek = false;
  bool isDarkMode = false;
  Map<String, dynamic>? translationData;

  void fetchTranslationData(String language) async {
    String url = language == 'uz'
        ? "https://api.alquran.cloud/v1/surah/${widget.surah['number']}/uz.sodik"
        : "https://api.alquran.cloud/v1/surah/${widget.surah['number']}/ar.alafasy";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          translationData = jsonData['data'];
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTranslationData('ar'); // Default to Arabic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surah['englishName']),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isUzbek = false;
                fetchTranslationData('ar');
              });
            },
            child: Text(
              "Arabcha",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isUzbek = true;
                fetchTranslationData('uz');
              });
            },
            child: Text(
              "O'zbekcha",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: translationData == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: isDarkMode ? Colors.white : Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: translationData!['ayahs'].length,
                  itemBuilder: (context, index) {
                    final ayah = translationData!['ayahs'][index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Oyat ${ayah['numberInSurah']}:",
                          style: TextStyle(
                            fontSize: 25, 
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.black : Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          ayah['text'],
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.black : Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
