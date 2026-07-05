# 🏝️ Tropical Treasure Hunt Mini Game App 🏴‍☠️


**Treasure Hunt App** is an interactive, animated 2D mobile game built with Flutter. It blends simple logic, quick decision‑making, and playful exploration as you dig across a sunny beach to uncover hidden treasures using a Hot/Cold proximity system.

## Gameplay
You’re given**8 digs** to locate **5 hidden treasures** scattered around the beach.

1. **Search:** Double-tap on the beach decorations (rocks, seashells, sandcastles) to dig.
2. **Feedback:**  If your dig misses, floating animated text appears to show how close you were (**🔥 HOT**, **🙂 WARM**, or **🥶 COLD**). 
3. **Collect:** When you uncover a treasure, drag and drop it into the open treasure chest at the bottom of the screen. 
4. **Win/Lose:** Recover all 5 treasures before you run out of digs to win the round.

## Key Features

This project highlights several advanced Flutter UI/UX techniques:

* **Interactive Animations:** 
  * `TweenAnimationBuilder` powers the smooth floating Hot/Cold feedback text.
  * `AnimatedContainer` adds a glowing white outline when decorations are tapped.
  * `AnimatedSwitcher` triggers "pop" scaling effects on the scoreboard when values change.
* **Drag and Drop Mechanics:** Uses Flutter’s `Draggable` and `DragTarget` widgets to let players physically move discovered treasures into the chest.
* **Gesture Controls:** Uses Flutter’s `GestureDetector` to capture `onDoubleTapDown` events and translate raw touch coordinates into the game’s mapped board logic,   enabling the core digging mechanic.
* **Management & Game Loop:** Implements a robust reset system that clears all game variables, restores the dig count, and reshuffles treasure locations using Dart’s `Random().shuffle()`. This approach provides endless replayability without needing to rebuild the widget tree.
* **Custom Level Design:** The beach layout is handcrafted using mathematically mapped `Offset` coordinates for precise placement of decorations and treasure spots.
* **Responsive Scaling:** Custom scaling logic ensures the game board and touch targets look consistent across small phones, tablets, and large emulators.
* **Polished UI Layers:** Transparent scrims and crisp 4‑point drop shadows keep text readable no matter what’s happening in the background.

## Project Structure

* `lib/main.dart` - App entry point and theme configuration.
* `lib/screens/intro_screen.dart` - Welcome screen with custom background overlay and instructions.
* `lib/screens/game_screen.dart` - The core game engine containing the layout, animation controllers, Win/Loss logic, and touch detection.
* `lib/widgets/` - Reusable UI components like `ScoreBoard`, `TreasureChest`, and draggable `TreasureItem`.
* `lib/models/` - Data classes for the `Treasure` and `BeachDecoration`.

### Getting Started

## Prerequisites
* Flutter SDK (recommended 3.0.0+)
* Dart SDK
* An android emulator

## Installation
1. Clone this repository to your local machine.
2. Open the project directory in your terminal.
3. Remember to run the following command to fetch dependencies:
   ```bash
   flutter pub get
4. Run the following command:
   ```bash
   flutter run


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
