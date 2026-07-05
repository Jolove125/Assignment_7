/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 7
   Summer 2026

   Tropical Treasure Hunt App
*/

import 'package:flutter/material.dart';

class TreasureChest extends StatefulWidget {
  final Function(String) onTreasureCollected;
  final bool isOpen;

  const TreasureChest({
    super.key,
    required this.onTreasureCollected,
    required this.isOpen,
  });

  @override
  State<TreasureChest> createState() => _TreasureChestState();
}

class _TreasureChestState extends State<TreasureChest>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Controls a quick bounce animation when a treasure is dropped into the chest
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Simple scale-up and scale-down sequence to simulate a "bounce" effect
    _scaleAnimation =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 1),
          TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 1),
        ]).animate(
          CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
        );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      // Accepts a dragged treasure ID when dropped on the chest
      onWillAcceptWithDetails: (details) {
        return details.data.isNotEmpty;
      },
      // Notify parent that a treasure has been collected
      onAcceptWithDetails: (details) {
        widget.onTreasureCollected(details.data);
        // Trigger bounce animation on successful drop
        _bounceController.forward(from: 0.0);
        // Small secondary bounce to reinforce feedback response
        Future.delayed(const Duration(milliseconds: 150), () {
          _bounceController.forward(from: 0.0);
        });
      },
      // True when a draggable treasure is currently hovering over the chest
      builder: (context, candidateData, rejectedData) {
        bool isHovering = candidateData.isNotEmpty;

        return ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 120,
            width: 120,
            // Visual feedback changes depending on whether a treasure is hovering
            decoration: BoxDecoration(
              color: isHovering ? Colors.amber.shade300 : Colors.brown.shade600,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isHovering ? Colors.greenAccent : Colors.amber,
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Switches chest image depending on whether it is open or closed
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Image.asset(
                      widget.isOpen
                          ? 'assets/images/treasure_chest_open.png'
                          : 'assets/images/treasure_chest_closed.png',
                      key: ValueKey(widget.isOpen),
                      width: 90,
                      height: 90,
                    ),
                  ),

                  // Small visual cue when an item is being dragged over the chest
                  if (isHovering)
                    const Positioned(
                      top: 8,
                      child: Text('✨', style: TextStyle(fontSize: 30)),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
