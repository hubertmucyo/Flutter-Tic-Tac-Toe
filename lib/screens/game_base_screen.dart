import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/game_logic/minimax.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../widgets/button_widget.dart';
import '../screens/game_screen.dart';
import '../screens/main_menu.dart';
import '../providers/game_providers.dart';
import '../game_logic/check_result.dart';

class GameBaseScreen extends ConsumerStatefulWidget {
  final String playerXName;
  final String playerOName;
  final bool isAgainstAI;
  final Difficulty difficulty;

  const GameBaseScreen({
    super.key,
    required this.playerXName,
    required this.playerOName,
    required this.isAgainstAI,
    required this.difficulty,
  });

  @override
  ConsumerState<GameBaseScreen> createState() => _GameBaseScreenState();
}

class _GameBaseScreenState extends ConsumerState<GameBaseScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resetGame(ref, isAgainstAI: widget.isAgainstAI);
    });
  }

  void _replayGame() {
    resetGame(ref, isAgainstAI: widget.isAgainstAI);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Tic Tac Toe",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.yellowAccent,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/game_screen_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          // Main content - FIXED: Use Column instead of Positioned
          Column(
            children: [
              // Game screen with flexible space
              Expanded(
                child: GameScreen(
                  playerXName: widget.playerXName,
                  playerOName: widget.playerOName,
                  isAgainstAI: widget.isAgainstAI,
                  difficulty: widget.difficulty,
                ),
              ),
              // Button row at bottom
              Container(
                padding: const EdgeInsets.only(bottom: 16, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonWidget(
                      text: "Return",
                      onPressed: () => Navigator.pop(context),
                    ),
                    ButtonWidget(
                      text: "Replay",
                      onPressed: _replayGame,
                    ),
                    ButtonWidget(
                      text: "Main Menu",
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const MainMenu()),
                        (route) => false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}