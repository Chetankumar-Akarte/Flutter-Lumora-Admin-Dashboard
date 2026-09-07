import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PasswordStrengthMeter extends StatelessWidget {
  final int strength; // 0 to 4

  const PasswordStrengthMeter({super.key, required this.strength});

  Color _getBarColor(int strength) {
    switch (strength) {
      case 1:
        return AppColors.danger;
      case 2:
        return AppColors.warn;
      case 3:
        return const Color(0xFF3B82F6);
      case 4:
        return AppColors.success;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final unfilledColor = isDark ? const Color(0xFF2E3447) : const Color(0xFFE5E7EB);
    final activeColor = _getBarColor(strength);

    return Row(
      children: List.generate(4, (index) {
        final isFilled = index < strength;
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 4,
            margin: EdgeInsets.only(
              right: index < 3 ? 6 : 0,
            ),
            decoration: BoxDecoration(
              color: isFilled ? activeColor : unfilledColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
