import 'dart:math';
import '../game_logic/check_result.dart';

enum Difficulty { easy, medium, hard }

/// Returns the best AI move as [row, col]
List<int> getAIMove(List<List<String>> board, Difficulty difficulty) {
  final random = Random();

  // Collect all empty cells
  final empty = <List<int>>[];
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j].isEmpty) empty.add([i, j]);
    }
  }

  if (empty.isEmpty) return [-1, -1]; // No moves left

  // Easy: random move
  if (difficulty == Difficulty.easy) {
    return empty[random.nextInt(empty.length)];
  }

  // Medium: 50% minimax, 50% random
  if (difficulty == Difficulty.medium && random.nextBool()) {
    return empty[random.nextInt(empty.length)];
  }

  // Hard: minimax
  int bestScore = -1000;
  int bestRow = -1;
  int bestCol = -1;

  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j].isEmpty) {
        board[i][j] = 'O';
        int score = minimax(board, false);
        board[i][j] = '';
        if (score > bestScore) {
          bestScore = score;
          bestRow = i;
          bestCol = j;
        }
      }
    }
  }

  return [bestRow, bestCol];
}

/// Minimax recursive algorithm
int minimax(List<List<String>> board, bool isMaximizing) {
  if (checkWin(board, 'O')) return 1;
  if (checkWin(board, 'X')) return -1;
  if (checkDraw(board)) return 0;

  if (isMaximizing) {
    int bestScore = -1000;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          board[i][j] = 'O';
          int score = minimax(board, false);
          board[i][j] = '';
          bestScore = max(score, bestScore);
        }
      }
    }
    return bestScore;
  } else {
    int bestScore = 1000;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          board[i][j] = 'X';
          int score = minimax(board, true);
          board[i][j] = '';
          bestScore = min(score, bestScore);
        }
      }
    }
    return bestScore;
  }
}
