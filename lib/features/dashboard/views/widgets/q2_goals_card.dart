import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_card.dart';
import '../../data/models/dashboard_models.dart';

class Q2GoalsCard extends StatelessWidget {
  final List<GoalItem> goals;

  const Q2GoalsCard({super.key, required this.goals});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppCard(
      title: 'Q2 Goals',
      headerAction: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isDark ? AppColors.brandDarkSoft : AppColors.brandSoft,
          borderRadius: AppDimensions.rPill,
        ),
        child: Text(
          'May 2026',
          style: AppTypography.heading(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.brandDark : AppColors.brand,
          ),
        ),
      ),
      child: Column(
        children: goals
            .map((goal) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buildGoalItem(goal, theme, isDark),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildGoalItem(GoalItem goal, ThemeData theme, bool isDark) {
    final percentInt = (goal.percentage * 100).toInt();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: goal.color.withValues(alpha: isDark ? 0.2 : 0.12),
                      borderRadius: AppDimensions.rMd,
                    ),
                    child: Center(
                      child: FaIcon(
                        goal.icon,
                        color: goal.color,
                        size: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          goal.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.heading(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          '${goal.currentFormatted} / ${goal.targetFormatted}',
                          style: AppTypography.body(
                            fontSize: 11,
                            color: theme.textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$percentInt%',
              style: AppTypography.heading(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: goal.color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Progress Bar
        ClipRRect(
          borderRadius: AppDimensions.rPill,
          child: Container(
            height: 7,
            width: double.infinity,
            color: isDark ? AppColors.darkSurface2 : AppColors.lightSurface2,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: goal.percentage.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: goal.gradient),
                  borderRadius: AppDimensions.rPill,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
