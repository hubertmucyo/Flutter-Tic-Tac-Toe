import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/button_widget.dart';
import '../screens/game_base_screen.dart';
import '../game_logic/minimax.dart';

class PlayersNamesScreen extends HookWidget {
  const PlayersNamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playerXController = useTextEditingController();
    final playerOController = useTextEditingController();
    final isBtnEnabled = useValueNotifier(false);

    void checkFields() {
      isBtnEnabled.value =
          playerXController.text.isNotEmpty && playerOController.text.isNotEmpty;
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/game_screen_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter Player Names',
                    style: GoogleFonts.fredoka(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Player X
                  SizedBox(
                    width: 280,
                    child: TextField(
                      controller: playerXController,
                      onChanged: (_) => checkFields(),
                      decoration: InputDecoration(
                        hintText: 'Player X',
                        hintStyle: GoogleFonts.fredoka(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.blueAccent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Player O
                  SizedBox(
                    width: 280,
                    child: TextField(
                      controller: playerOController,
                      onChanged: (_) => checkFields(),
                      decoration: InputDecoration(
                        hintText: 'Player O',
                        hintStyle: GoogleFonts.fredoka(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.purpleAccent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ValueListenableBuilder(
                    valueListenable: isBtnEnabled,
                    builder: (context, value, _) {
                      return ButtonWidget(
                        isEnabled: value,
                        text: 'Start Game',
                        textStyle: GoogleFonts.fredoka(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GameBaseScreen(
                                playerXName: playerXController.text,
                                playerOName: playerOController.text,
                                isAgainstAI: false,
                                difficulty: Difficulty.hard,
                              ),
                            ),
                          );
                        },
                      );
                    },
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
