/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 7
   Summer 2026

   Tropical Treasure Hunt App
*/

import 'package:flutter/material.dart';
import '../models/treasure.dart';

class TreasureItem extends StatelessWidget {
  final Treasure treasure;
  final VoidCallback onReveal;

  const TreasureItem({
    super.key,
    required this.treasure,
    required this.onReveal,
  });

  @override
  Widget build(BuildContext context) {
    // When the treasure has not been revealed yet, show a hidden placeholder
    // that the player can interact with to "discover" it.
    if (!treasure.isRevealed) {
      return GestureDetector(
        onDoubleTap: onReveal,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 60,
          height: 60,
          // Simple visual representation of an undiscovered object in sand
          decoration: BoxDecoration(
            color: const Color(0xFFD7B98E),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
      );
    }

    // Once revealed, animate the treasure appearance and allow dragging it
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 400),
      tween: Tween<double>(begin: 0.0, end: 1.0),

      builder: (context, value, child) {
        // Fade and scale-in effect when treasure becomes visible
        return Transform.scale(
          scale: value,
          child: Opacity(opacity: value, child: child),
        );
      },

      child: Draggable<String>(
        data: treasure.id,

        // Image shown while actively dragging the treasure
        feedback: Image.asset(treasure.icon, width: 90, height: 90),
        // Visual placeholder when the treasure is being dragged away
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: Image.asset(treasure.icon, width: 80, height: 80),
        ),
        // Default visible state when not dragging
        child: Image.asset(treasure.icon, width: 80, height: 80),
      ),
    );
  }
}
