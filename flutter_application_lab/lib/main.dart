import 'package:flutter/material.dart';
import 'splashscreen.dart';
import 'mainscreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab Assignment 1',
      home: SplashScreen(),
    );
  }
}
