import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/theme/app_sizes.dart';
import '../theme/colors.dart';

class ButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final String winner; // default to "draw"
  final bool isEnabled;
  final TextStyle? textStyle;

  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.isEnabled = true,
    this.winner = "draw",
    this.textStyle,
  });

  Color getColor() {
    if (!isEnabled) return GameColors.kGrey;

    switch (winner) {
      case 'X':
        return GameColors.kBlue;
      case 'O':
        return GameColors.kPurple;
      default:
        return GameColors.kForeground;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: getColor(),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: borderRadiusM()),
      ),
      child: Text(
        text,
        style: textStyle ??
            TextStyle(
              color: isEnabled ? GameColors.kWhitish : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
      ),
    );
  }
}
