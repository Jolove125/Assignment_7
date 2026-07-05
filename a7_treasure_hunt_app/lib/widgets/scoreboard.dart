/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 7
   Summer 2026

   Tropical Treasure Hunt App
*/

import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final int score;
  final int treasuresFound;
  final int totalTreasures;

  const ScoreBoard({
    super.key,
    required this.score,
    required this.treasuresFound,
    required this.totalTreasures,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Displays current score accumulated from collected treasures
          Text(
            '🏆 Score: $score',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 4),

          // Shows progress in terms of treasures found vs total available
          Text(
            '📦 $treasuresFound / $totalTreasures found',
            style: const TextStyle(fontSize: 16, color: Colors.brown),
          ),
          const SizedBox(height: 4),

          // Converts progress into a percentage for quick visual feedback
          Text(
            '📊 ${(treasuresFound / totalTreasures * 100).toStringAsFixed(0)}% complete',
            style: const TextStyle(fontSize: 16, color: Colors.brown),
          ),
        ],
      ),
    );
  }
}
