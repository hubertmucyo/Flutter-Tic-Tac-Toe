import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'screens/main_menu.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const ProviderScope( // ✅ Add this
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mr Bean Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.baloo2TextTheme(), // 🎯 In-game text font
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            foregroundColor: Colors.yellowAccent,
            textStyle: GoogleFonts.fredoka(fontSize: 18, fontWeight: FontWeight.bold),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
            shadowColor: Colors.black54,
          ),
        ),
      ),
      home: const WelcomeOverlay(), // 👈 Show welcome before MainMenu
    );
  }
}

class WelcomeOverlay extends StatefulWidget {
  const WelcomeOverlay({super.key});

  @override
  State<WelcomeOverlay> createState() => _WelcomeOverlayState();
}

class _WelcomeOverlayState extends State<WelcomeOverlay> {
  @override
  void initState() {
    super.initState();
    // Show popup once after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeDialog(context);
    });
  }

  void _showWelcomeDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // force them to press "Continue"
      builder: (_) => AlertDialog(
        backgroundColor: Colors.yellow.shade50.withOpacity(0.95),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/welcome.jpg',
              height: 180,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              "🎉 Welcome to Mr Bean’s Tic Tac Toe 🎉",
              style: GoogleFonts.chewy(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Enjoy a fun and silly Tic Tac Toe match with Mr Bean vibes! 😂\n\nGood luck, players!",
              style: GoogleFonts.baloo2(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade700,
                foregroundColor: Colors.yellowAccent,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
                shadowColor: Colors.black45,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // After closing, move to MainMenu
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const MainMenu()),
                );
              },
              child: Text(
                "Continue",
                style: GoogleFonts.fredoka(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Just an empty container until dialog is dismissed
    return const Scaffold(
      backgroundColor: Colors.black,
    );
  }
}
