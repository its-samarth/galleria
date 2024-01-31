import 'package:flutter/material.dart';
import 'screens/gallery_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static ThemeMode themeMode = ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      home: GalleryScreen(),
    );
  }
}

