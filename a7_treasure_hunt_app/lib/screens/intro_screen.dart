/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 7
   Summer 2026

   Tropical Treasure Hunt App
*/

import 'package:flutter/material.dart';
import 'game_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        // Full-screen background image for the beach theme
        children: [
          Image.asset('assets/images/beach.png', fit: BoxFit.cover),
          // Dark overlay to improve text and logo readability
          Container(color: Colors.black.withValues(alpha: 0.5)),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/TTH_logo.png',
                width: 300,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 40),

              // Simple game instructions shown on the intro screen
              const Text(
                'Find 5 hidden treasures.\nYou only have 10 digs!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 300),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  elevation: 8,
                ),

                // Navigates to the main game screen and replaces intro
                // so the user cannot return to this screen with back button
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const GameScreen()),
                  );
                },
                child: const Text(
                  'START GAME',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
