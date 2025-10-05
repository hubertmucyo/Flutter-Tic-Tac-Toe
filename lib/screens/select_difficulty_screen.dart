import 'package:flutter/material.dart';
import '../game_logic/minimax.dart';

class SelectDifficultyScreen extends StatelessWidget {
  final Function(Difficulty) onDifficultySelected;

  const SelectDifficultyScreen({super.key, required this.onDifficultySelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Select Difficulty"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/background.jpg', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Choose Difficulty",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFD700),
                  ),
                ),
                const SizedBox(height: 32),
                DifficultyButton(
                  text: "Easy",
                  onTap: () => onDifficultySelected(Difficulty.easy),
                ),
                const SizedBox(height: 16),
                DifficultyButton(
                  text: "Medium",
                  onTap: () => onDifficultySelected(Difficulty.medium),
                ),
                const SizedBox(height: 16),
                DifficultyButton(
                  text: "Hard",
                  onTap: () => onDifficultySelected(Difficulty.hard),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DifficultyButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const DifficultyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B4513),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFD700),
          ),
        ),
      ),
    );
  }
}
