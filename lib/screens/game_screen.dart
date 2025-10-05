import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/game_providers.dart';
import '../game_logic/minimax.dart';
import '../game_logic/check_result.dart';
import '../widgets/scoreboard.dart';
import '../widgets/alert_dialog.dart';

class GameScreen extends ConsumerStatefulWidget {
  final String playerXName;
  final String playerOName;
  final bool isAgainstAI;
  final Difficulty difficulty;

  const GameScreen({
    super.key,
    required this.playerXName,
    required this.playerOName,
    required this.isAgainstAI,
    required this.difficulty,
  });

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  int playerXScore = 0;
  int playerOScore = 0;

  void makeMove(int row, int col) async {
    final board = ref.read(boardProvider);
    final currentPlayer = ref.read(currentPlayerProvider);
    final winner = ref.read(winnerProvider);

    if (board[row][col].isNotEmpty || winner.isNotEmpty) return;

    ref.read(boardProvider.notifier).updateBoard(row, col, currentPlayer);

    if (checkWin(ref.read(boardProvider), currentPlayer)) {
      ref.read(winnerProvider.notifier).updateWinner(currentPlayer);
      setState(() {
        if (currentPlayer == 'X') {
          playerXScore++;
        } else {
          playerOScore++;
        }
      });
      
      final message = currentPlayer == 'X' 
          ? '${widget.playerXName} wins!' 
          : '${widget.playerOName} wins!';
      showGameAlertDialog(
        message, 
        context, 
        currentPlayer, 
        () => resetGame(ref, isAgainstAI: widget.isAgainstAI)
      );
      return;
    } else if (checkDraw(ref.read(boardProvider))) {
      ref.read(winnerProvider.notifier).updateWinner('Draw');
      showGameAlertDialog(
        'It\'s a draw!', 
        context, 
        'Draw', 
        () => resetGame(ref, isAgainstAI: widget.isAgainstAI)
      );
      return;
    }

    if (!widget.isAgainstAI) {
      ref.read(currentPlayerProvider.notifier).togglePlayer();
    } else {
      await Future.delayed(const Duration(milliseconds: 300));
      final aiMove = getAIMove(ref.read(boardProvider), widget.difficulty);
      if (aiMove[0] != -1) {
        ref.read(boardProvider.notifier).updateBoard(aiMove[0], aiMove[1], 'O');
      }

      if (checkWin(ref.read(boardProvider), 'O')) {
        ref.read(winnerProvider.notifier).updateWinner('O');
        setState(() => playerOScore++);
        showGameAlertDialog(
          '${widget.playerOName} wins!', 
          context, 
          'O', 
          () => resetGame(ref, isAgainstAI: widget.isAgainstAI)
        );
      } else if (checkDraw(ref.read(boardProvider))) {
        ref.read(winnerProvider.notifier).updateWinner('Draw');
        showGameAlertDialog(
          'It\'s a draw!', 
          context, 
          'Draw', 
          () => resetGame(ref, isAgainstAI: widget.isAgainstAI)
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final board = ref.watch(boardProvider);
    final currentPlayer = ref.watch(currentPlayerProvider);
    final winner = ref.watch(winnerProvider);
    
    final screenWidth = MediaQuery.of(context).size.width;
    final boardSize = screenWidth > 600 ? 450.0 : screenWidth - 48;
    final cellSize = boardSize / 3;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScoreBoard(
            playerXName: widget.playerXName,
            playerOName: widget.playerOName,
            playerXScore: playerXScore,
            playerOScore: playerOScore,
            isTurn: winner.isEmpty && currentPlayer == 'X',
          ),
          const SizedBox(height: 16),
          // FIX: Replace GridView with manual layout
          SizedBox(
            width: boardSize,
            height: boardSize,
            child: Column(
              children: List.generate(3, (row) {
                return Expanded(
                  child: Row(
                    children: List.generate(3, (col) {
                      final cellValue = board[row][col];
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GestureDetector(
                            onTap: () => makeMove(row, col),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF8B4513),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  cellValue,
                                  style: TextStyle(
                                    fontSize: cellSize * 0.4,
                                    fontWeight: FontWeight.bold,
                                    color: cellValue == 'X'
                                        ? Colors.lightBlueAccent
                                        : const Color(0xFFFFD700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}