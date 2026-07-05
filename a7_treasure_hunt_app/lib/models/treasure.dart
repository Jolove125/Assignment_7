/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 7
   Summer 2026

   Tropical Treasure Hunt App
*/

import 'package:flutter/material.dart';

class Treasure {
  final String id;
  final String name;
  final String icon;
  final int points;

  Offset position;

  bool
  isRevealed; // Controls whether the treasure has been discovered (shown on screen)
  bool
  isCollected; // Tracks whether the treasure has been successfully collected by the player

  Treasure({
    required this.id,
    required this.name,
    required this.icon,
    required this.points,
    required this.position,
    this.isRevealed = false,
    this.isCollected = false,
  });

  // Resets the treasure state for a new game session and optionally repositions it
  void reset(Offset newPosition) {
    position = newPosition;
    isRevealed = false;
    isCollected = false;
  }
}
