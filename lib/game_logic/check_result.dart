import 'dart:math';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/game_providers.dart';

bool checkWin(List<List<String>> board, String player) {
  // Rows & Columns
  for (int i = 0; i < 3; i++) {
    if ((board[i][0] == player &&
            board[i][1] == player &&
            board[i][2] == player) ||
        (board[0][i] == player &&
            board[1][i] == player &&
            board[2][i] == player)) {
      return true;
    }
  }
  // Diagonals
  if ((board[0][0] == player &&
          board[1][1] == player &&
          board[2][2] == player) ||
      (board[0][2] == player &&
          board[1][1] == player &&
          board[2][0] == player)) {
    return true;
  }
  return false;
}

bool checkDraw(List<List<String>> board) =>
    board.every((row) => row.every((cell) => cell.isNotEmpty));

/// Reset board for a new game while preserving AI difficulty & player roles
void resetGame(WidgetRef ref, {bool isAgainstAI = false}) {
  final boardNotifier = ref.read(boardProvider.notifier);
  final winnerNotifier = ref.read(winnerProvider.notifier);
  final currentPlayerNotifier = ref.read(currentPlayerProvider.notifier);

  // Clear board
  boardNotifier.resetBoard();

  // Reset winner
  winnerNotifier.updateWinner('');

  // Set starting player
  if (isAgainstAI) {
    currentPlayerNotifier.state = 'X';
  } else {
    // Random starting player for multiplayer
    currentPlayerNotifier.state = ['X', 'O'][Random().nextInt(2)];
  }
}