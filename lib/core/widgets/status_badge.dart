import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_typography.dart';

enum OrderStatus { done, inProgress, onHold, rejected }

class StatusBadge extends StatelessWidget {
  final OrderStatus status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final (label, textColor, bgColor) = switch (status) {
      OrderStatus.done => (
          'Done',
          isDark ? AppColors.successDark : AppColors.success,
          isDark ? AppColors.successDarkSoft : AppColors.successSoft,
        ),
      OrderStatus.inProgress => (
          'In progress',
          isDark ? AppColors.infoDark : AppColors.info,
          isDark ? AppColors.infoDarkSoft : AppColors.infoSoft,
        ),
      OrderStatus.onHold => (
          'On hold',
          isDark ? AppColors.warnDark : AppColors.warn,
          isDark ? AppColors.warnDarkSoft : AppColors.warnSoft,
        ),
      OrderStatus.rejected => (
          'Rejected',
          isDark ? AppColors.dangerDark : AppColors.danger,
          isDark ? AppColors.dangerDarkSoft : AppColors.dangerSoft,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppDimensions.rPill,
      ),
      child: Text(
        label,
        style: AppTypography.heading(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
