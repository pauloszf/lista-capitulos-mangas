import 'package:flutter/material.dart';
import 'package:manga_cap/views/manga_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mangá Cap List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Raleway',
        primaryColor: Color(0xFFFFD748),
        accentColor: Color(0xFFFFD748),
        scaffoldBackgroundColor: Color(0xFF0A0A0A),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MangaList(),
    );
  }
}
