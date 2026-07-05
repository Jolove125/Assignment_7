/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 7
   Summer 2026

   Tropical Treasure Hunt App
*/

import 'package:flutter/material.dart';
import 'dart:math';
import '../models/treasure.dart';
import '../widgets/treasure_items.dart';
import '../widgets/treasure_chest.dart';
import '../widgets/scoreboard.dart';
import '../models/beach_decorations.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<Treasure> masterTreasurePool = [
    Treasure(
      id: 'coin',
      name: 'Gold Coin',
      icon: 'assets/images/coin.png',
      points: 10,
      position: Offset.zero,
    ),
    Treasure(
      id: 'ruby',
      name: 'Ruby',
      icon: 'assets/images/ruby.png',
      points: 20,
      position: Offset.zero,
    ),
    Treasure(
      id: 'emerald',
      name: 'Emerald',
      icon: 'assets/images/emerald.png',
      points: 30,
      position: Offset.zero,
    ),
    Treasure(
      id: 'crown',
      name: 'Crown',
      icon: 'assets/images/crown.png',
      points: 90,
      position: Offset.zero,
    ),
    Treasure(
      id: 'key',
      name: 'Key',
      icon: 'assets/images/key.png',
      points: 40,
      position: Offset.zero,
    ),
    Treasure(
      id: 'diamond',
      name: 'Diamond',
      icon: 'assets/images/diamond.png',
      points: 60,
      position: Offset.zero,
    ),
    Treasure(
      id: 'gold_bar',
      name: 'Gold Bar',
      icon: 'assets/images/gold_bar.png',
      points: 80,
      position: Offset.zero,
    ),
    Treasure(
      id: 'pearl',
      name: 'Pearl',
      icon: 'assets/images/pearl.png',
      points: 50,
      position: Offset.zero,
    ),
    Treasure(
      id: 'cup',
      name: 'Gold Cup',
      icon: 'assets/images/cup.png',
      points: 70,
      position: Offset.zero,
    ),
  ];

  List<Treasure> activeTreasures = [];

  final List<BeachDecoration> decorations = [
    BeachDecoration(
      image: 'assets/images/decorations/rock.png',
      position: const Offset(40, 390),
    ),
    BeachDecoration(
      image: 'assets/images/decorations/rock.png',
      position: const Offset(200, 300),
    ),
    BeachDecoration(
      image: 'assets/images/decorations/seashell.png',
      position: const Offset(160, 380),
    ),
    BeachDecoration(
      image: 'assets/images/decorations/seashell.png',
      position: const Offset(50, 520),
    ),
    BeachDecoration(
      image: 'assets/images/decorations/sandcastle.png',
      position: const Offset(300, 390),
    ),
    BeachDecoration(
      image: 'assets/images/decorations/wood.png',
      position: const Offset(280, 270),
    ),
    BeachDecoration(
      image: 'assets/images/decorations/coconut.png',
      position: const Offset(300, 520),
    ),
    BeachDecoration(
      image: 'assets/images/decorations/beach_grass.png',
      position: const Offset(260, 320),
    ),
    BeachDecoration(
      image: 'assets/images/decorations/flip_flops.png',
      position: const Offset(80, 450),
    ),
    BeachDecoration(
      image: 'assets/images/decorations/starfish.png',
      position: const Offset(60, 290),
    ),
    BeachDecoration(
      image: 'assets/images/decorations/starfish.png',
      position: const Offset(30, 600),
    ),
    BeachDecoration(
      image: 'assets/images/decorations/palm_plant.png',
      position: const Offset(140, 500),
    ),
    BeachDecoration(
      image: 'assets/images/decorations/sand_mound.png',
      position: const Offset(220, 450),
    ),
    BeachDecoration(
      image: 'assets/images/decorations/sand_mound.png',
      position: const Offset(310, 600),
    ),
  ];

  String hintMessage = 'Double tap the beach to search!';
  int score = 0;
  int remainingDigs = 10;
  Offset? lastDigPosition;
  Offset? feedbackPosition;
  bool showPuff = false;
  bool chestOpen = false;

  String floatingFeedback = '';
  Color feedbackColor = Colors.transparent;
  int feedbackKey = 0;
  int? clickedDecorationIndex;

  // Returns true only when every active treasure has been collected
  // Used to determine the win condition
  bool get isComplete =>
      activeTreasures.isNotEmpty && activeTreasures.every((t) => t.isCollected);

  @override
  void initState() {
    super.initState();
    _setupBoard();
  }

  // Reset all treasure and decoration states before creating
  // a new randomized game board.
  void _setupBoard() {
    final random = Random();

    for (final treasure in masterTreasurePool) {
      treasure.isCollected = false;
      treasure.isRevealed = false;
    }

    for (final d in decorations) {
      d.hasTreasure = false;
      d.treasureId = null;
    }

    masterTreasurePool.shuffle(random);
    activeTreasures = masterTreasurePool.take(5).toList();

    decorations.shuffle(random);

    // Randomly assign each active treasure to a unique decoration
    // so every game has a different layout
    for (int i = 0; i < activeTreasures.length; i++) {
      decorations[i].hasTreasure = true;
      decorations[i].treasureId = activeTreasures[i].id;
      activeTreasures[i].position = decorations[i].position;
    }
  }

  void _resetGame() {
    setState(() {
      score = 0;
      remainingDigs = 10;
      chestOpen = false;
      lastDigPosition = null;
      feedbackPosition = null;
      showPuff = false;
      clickedDecorationIndex = null;
      hintMessage = 'Double tap the beach to search!';
      _setupBoard();
    });
  }

  // Display the end-of-game dialog for either a win or loss
  void _showGameOverDialog(String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.amber.shade50,

          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),

          content: Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Play Again', style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  void _handleTreasureCollected(String id) {
    final treasure = activeTreasures.firstWhere((t) => t.id == id);
    setState(() {
      if (!treasure.isCollected) {
        treasure.isCollected = true;
        score += treasure.points;
        chestOpen = false;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${treasure.name} collected!'),
        duration: const Duration(milliseconds: 800),
      ),
    );

    if (isComplete) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _showGameOverDialog(
          '🎉 You Won!',
          'You found all the treasure with $remainingDigs digs to spare!',
        );
      });
    } else {
      bool hasUncollectedRevealed = activeTreasures.any(
        (t) => t.isRevealed && !t.isCollected,
      );

      if (remainingDigs <= 0 && !hasUncollectedRevealed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _showGameOverDialog(
            '💀 Game Over',
            'You ran out of digs before finding all the treasure.',
          );
        });
      }
    }
  }

  void _revealTreasure(String id) {
    setState(() {
      final index = activeTreasures.indexWhere((t) => t.id == id);
      if (index != -1) activeTreasures[index].isRevealed = true;
    });
  }

  void _dig(Offset tapPosition) {
    if (remainingDigs <= 0 || isComplete) return;

    // Convert the tap location from the current screen size
    // back to the original design coordinates so treasure
    // locations stay accurate on different devices
    final Size screenSize = MediaQuery.of(context).size;
    final double scaleX = screenSize.width / 400;
    final double scaleY = screenSize.height / 800;

    Offset adjustedTap = Offset(
      tapPosition.dx / scaleX,
      tapPosition.dy / scaleY,
    );
    const double searchRadius = 60;
    bool found = false;
    double closestDistance = double.infinity;

    // Find the closest decoration so it can briefly highlight
    // where the player searched
    int? nearestDecoIndex;
    double nearestDecoDist = double.infinity;
    for (int i = 0; i < decorations.length; i++) {
      final dist = (decorations[i].position - adjustedTap).distance;
      if (dist < nearestDecoDist) {
        nearestDecoDist = dist;
        nearestDecoIndex = i;
      }
    }

    setState(() {
      remainingDigs--;
      lastDigPosition = tapPosition;
      feedbackPosition = tapPosition;
      feedbackKey++;
      showPuff = true;

      if (nearestDecoDist <= searchRadius) {
        clickedDecorationIndex = nearestDecoIndex;
      } else {
        clickedDecorationIndex = null;
      }
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) setState(() => showPuff = false);
    });

    // Remove the floating feedback text and decoration highlight
    // after the animation finishes
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          feedbackPosition = null;
          clickedDecorationIndex = null;
        });
      }
    });

    // Check whether the player's dig is close enough to reveal
    // an unrevealed treasure
    for (final treasure in activeTreasures) {
      if (treasure.isCollected) continue;

      final distance = (treasure.position - adjustedTap).distance;
      if (distance < closestDistance) closestDistance = distance;

      if (distance <= searchRadius && !treasure.isRevealed) {
        setState(() {
          treasure.isRevealed = true;
          chestOpen = true;
          floatingFeedback = '✨ FOUND!';
          feedbackColor = Colors.yellowAccent;
          hintMessage =
              '✨ You found a ${treasure.name}!!!\n Hold and drag treasure to the treasure chest';
        });
        found = true;
        break;
      }
    }

    // Give the player a proximity hint based on the distance
    // to the closest remaining treasure.
    if (!found) {
      setState(() {
        if (closestDistance < 100) {
          floatingFeedback = '🔥 HOT!';
          feedbackColor = Colors.redAccent;
          hintMessage = '🔥 HOT!';
        } else if (closestDistance < 180) {
          floatingFeedback = '🙂 WARM';
          feedbackColor = Colors.orangeAccent;
          hintMessage = '🙂 Warm';
        } else {
          floatingFeedback = '🥶 COLD';
          feedbackColor = Colors.lightBlueAccent;
          hintMessage = '🥶 Cold';
        }
      });
    }

    bool hasUncollectedRevealed = activeTreasures.any(
      (t) => t.isRevealed && !t.isCollected,
    );
    if (remainingDigs == 0 && !hasUncollectedRevealed && !isComplete) {
      // Hide the digging animation after a short delay.
      Future.delayed(const Duration(milliseconds: 400), () {
        _showGameOverDialog(
          '💀 Game Over',
          'You ran out of digs before finding all the treasure.',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double scaleX = screenSize.width / 400;
    final double scaleY = screenSize.height / 800;
    List<Treasure> remainingTreasures = activeTreasures
        .where((t) => !t.isCollected)
        .toList();

    return Scaffold(
      backgroundColor: Colors.amber.shade200,
      appBar: AppBar(
        title: const Text(
          'Treasure Hunt',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: _resetGame,
            icon: const Icon(Icons.refresh, color: Colors.black, size: 24),
            label: const Text(
              'Restart',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/beach.png', fit: BoxFit.cover),
          ),
          Container(color: Colors.black.withValues(alpha: 0.15)),

          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onDoubleTapDown: (details) => _dig(details.localPosition),
              child: Stack(
                children: [
                  ...decorations.asMap().entries.map((entry) {
                    int idx = entry.key;
                    BeachDecoration d = entry.value;
                    bool isClicked = idx == clickedDecorationIndex;

                    return Positioned(
                      // Scale decoration positions to match the current screen size
                      left: d.position.dx * scaleX,
                      top: d.position.dy * scaleY,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isClicked
                              ? Colors.white.withValues(alpha: 0.4)
                              : Colors.transparent,
                          boxShadow: isClicked
                              ? [
                                  const BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 12,
                                    spreadRadius: 4,
                                  ),
                                ]
                              : [],
                        ),
                        child: Image.asset(
                          d.image,
                          width: 55 * scaleX,
                          height: 55 * scaleX,
                        ),
                      ),
                    );
                  }),

                  if (lastDigPosition != null)
                    Positioned(
                      left: lastDigPosition!.dx - 20,
                      top: lastDigPosition!.dy - 20,
                      child: AnimatedOpacity(
                        opacity: showPuff ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: const Text('💨', style: TextStyle(fontSize: 40)),
                      ),
                    ),

                  ...remainingTreasures.where((t) => t.isRevealed).map((
                    treasure,
                  ) {
                    return Positioned(
                      left: treasure.position.dx * scaleX,
                      top: treasure.position.dy * scaleY,
                      child: TreasureItem(
                        treasure: treasure,
                        onReveal: () => _revealTreasure(treasure.id),
                      ),
                    );
                  }),

                  if (feedbackPosition != null)
                    Positioned(
                      left: feedbackPosition!.dx - 50,
                      top: feedbackPosition!.dy - 40,
                      // Show a short floating message (FOUND, HOT, WARM, or COLD)
                      // that fades upward after each dig
                      child: TweenAnimationBuilder<double>(
                        key: ValueKey(feedbackKey),
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 1000),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, -80 * value),
                            child: Opacity(
                              opacity: (1.0 - value).clamp(0.0, 1.0),
                              child: Text(
                                floatingFeedback,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: feedbackColor,
                                  shadows: const [
                                    Shadow(
                                      blurRadius: 4,
                                      color: Colors.black,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  ScoreBoard(
                    score: score,
                    treasuresFound: activeTreasures
                        .where((t) => t.isCollected)
                        .length,
                    totalTreasures: activeTreasures.length,
                  ),
                  const SizedBox(height: 40),
                  // Smoothly animate changes to the status message whenever
                  // the remaining number of digs changes
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },

                    child: Text(
                      isComplete
                          ? '🎉 You found all the treasure!'
                          : '💥 Digs left: $remainingDigs\n$hintMessage',
                      key: ValueKey<int>(remainingDigs),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(-1.5, -1.5),
                            color: Colors.black,
                          ),
                          Shadow(
                            offset: Offset(1.5, -1.5),
                            color: Colors.black,
                          ),
                          Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
                          Shadow(
                            offset: Offset(-1.5, 1.5),
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  TreasureChest(
                    onTreasureCollected: _handleTreasureCollected,
                    isOpen: chestOpen,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
