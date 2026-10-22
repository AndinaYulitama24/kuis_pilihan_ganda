import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class OptionCard extends StatelessWidget {
  final String text;
  final int index;
  final int? selectedIndex;
  final int correctIndex;
  final bool isAnswered;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.text,
    required this.index,
    required this.selectedIndex,
    required this.correctIndex,
    required this.isAnswered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textLightDark : AppColors.textDark;
    final unselectedColor = isDark ? AppColors.cardDark : AppColors.cream;

    bool isSelected = selectedIndex == index;
    bool isCorrect = index == correctIndex;

    Color bgColor = unselectedColor;
    Color borderColor = Colors.transparent;

    if (isAnswered) {
      if (isCorrect) {
        bgColor = Colors.green.withValues(alpha: 0.2);
        borderColor = Colors.green;
      } else if (isSelected && !isCorrect) {
        bgColor = Colors.red.withValues(alpha: 0.2);
        borderColor = Colors.red;
      }
    } else if (isSelected) {
      bgColor = AppColors.peach;
      borderColor = AppColors.peachDark;
    }

    return GestureDetector(
      onTap: isAnswered ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isSelected || (isAnswered && isCorrect) ? FontWeight.w600 : FontWeight.normal,
            color: textColor,
          ),
        ),
      ),
    );
  }
}