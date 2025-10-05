import 'package:hooks_riverpod/hooks_riverpod.dart';

class BoardNotifier extends StateNotifier<List<List<String>>> {
  BoardNotifier() : super(List.generate(3, (_) => List.filled(3, '')));

  void resetBoard() {
    state = List.generate(3, (_) => List.filled(3, ''));
  }

  void updateBoard(int row, int col, String value) {
    final newBoard = List<List<String>>.from(state.map((row) => List<String>.from(row)));
    newBoard[row][col] = value;
    state = newBoard;
  }
}

class CurrentPlayerNotifier extends StateNotifier<String> {
  CurrentPlayerNotifier() : super('X');

  void togglePlayer() {
    state = state == 'X' ? 'O' : 'X';
  }
}

class WinnerNotifier extends StateNotifier<String> {
  WinnerNotifier() : super('');

  void updateWinner(String value) {
    state = value;
  }
}

final boardProvider =
    StateNotifierProvider<BoardNotifier, List<List<String>>>(
        (ref) => BoardNotifier());
final currentPlayerProvider =
    StateNotifierProvider<CurrentPlayerNotifier, String>(
        (ref) => CurrentPlayerNotifier());
final winnerProvider =
    StateNotifierProvider<WinnerNotifier, String>((ref) => WinnerNotifier());