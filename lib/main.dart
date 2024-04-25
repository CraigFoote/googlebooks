import 'package:flutter/material.dart';
import 'search_page.dart';

void main() {
  runApp(const GoogleBooksApp());
}

class GoogleBooksApp extends StatelessWidget {
  const GoogleBooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Books',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(76, 86, 106, 1.0)),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: const SearchPage(),
    );
  }
}
