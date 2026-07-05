/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 7
   Summer 2026

   Tropical Treasure Hunt App
*/

import 'screens/intro_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TreasureHuntApp());
}

class TreasureHuntApp extends StatelessWidget {
  const TreasureHuntApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tropical Treasure Hunt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFFEED9A0),
      ),
      home: const IntroScreen(),
    );
  }
}
