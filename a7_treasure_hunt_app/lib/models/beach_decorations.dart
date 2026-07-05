/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 7
   Summer 2026

   Tropical Treasure Hunt App
*/

import 'package:flutter/material.dart';

class BeachDecoration {
  String image;
  Offset position;

  // Tracks whether this decoration is hiding a treasure during the current game
  bool hasTreasure;
  String? treasureId;

  BeachDecoration({
    required this.image,
    required this.position,
    this.hasTreasure = false,
    this.treasureId,
  });
}
