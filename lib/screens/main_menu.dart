import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/screens/players_names_screen.dart';
import 'package:flutter_tic_tac_toe/screens/select_difficulty_screen.dart';
import 'game_base_screen.dart';
import '../theme/app_sizes.dart';
import 'package:google_fonts/google_fonts.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Image.asset('assets/background.jpg', fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: Container(color: Colors.black.withOpacity(0.3)),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Text(
                  "MR BEAN TIC TAC TOE",
                  style: GoogleFonts.chewy(
                    fontSize: 50,
                    color: const Color(0xFFCBBA5B),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    shadows: const [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black54,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                gap4XL(),
                // Single Player button
                MainMenuButton(
                  btnText: 'Single Player',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SelectDifficultyScreen(
                          onDifficultySelected: (difficulty) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => GameBaseScreen(
                                  playerXName: 'You',
                                  playerOName: 'BOT',
                                  isAgainstAI: true,
                                  difficulty: difficulty,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                gapXL(),
                // Multiplayer button
                MainMenuButton(
                  btnText: 'Multiplayer',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PlayersNamesScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MainMenuButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onPressed;

  const MainMenuButton({super.key, required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: 280, // slightly narrower for a cleaner look
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B4513), // brown
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 8,
              shadowColor: Colors.black54,
            ),
            child: Text(
              btnText,
              style: GoogleFonts.fredoka(
                color: const Color(0xFFFFD700), // gold
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      );
}
