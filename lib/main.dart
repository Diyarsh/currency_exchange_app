import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primaryColor: Color(0xFF00ABC2),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFfeba00)),
        scaffoldBackgroundColor: Colors.white,
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF00ABC2),
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF00ABC2),
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF00ABC2)),
          ),
          labelStyle: TextStyle(color: Color(0xFF00ABC2)),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}


