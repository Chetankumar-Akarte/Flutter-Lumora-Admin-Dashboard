import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_typography.dart';

class SegmentedControl<T> extends StatelessWidget {
  final List<T> items;
  final T selectedValue;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onValueChanged;

  const SegmentedControl({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.labelBuilder,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface2 : AppColors.lightSurface2,
        borderRadius: AppDimensions.rMd,
        border: Border.all(color: theme.colorScheme.outline),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) {
          final isSelected = item == selectedValue;
          return GestureDetector(
            onTap: () => onValueChanged(item),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark ? AppColors.brandDark : AppColors.brand)
                    : Colors.transparent,
                borderRadius: AppDimensions.rSm,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: (isDark ? AppColors.brandDark : AppColors.brand)
                              .withValues(alpha: 0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                labelBuilder(item),
                style: AppTypography.heading(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
