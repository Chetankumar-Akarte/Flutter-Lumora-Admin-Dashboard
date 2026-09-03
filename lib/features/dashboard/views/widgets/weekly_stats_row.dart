import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_card.dart';
import '../../data/models/dashboard_models.dart';

class WeeklyStatsRow extends StatelessWidget {
  final List<WeeklyStatItem> items;

  const WeeklyStatsRow({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int crossAxisCount = 4;
        if (width < 600) {
          crossAxisCount = 1;
        } else if (width < 1100) {
          crossAxisCount = 2;
        }

        if (crossAxisCount == 1) {
          return Column(
            children: items
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildStatCard(item, context),
                  ),
                )
                .toList(),
          );
        }

        final double itemWidth =
            (width - ((crossAxisCount - 1) * 16)) / crossAxisCount;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: items
              .map(
                (item) => SizedBox(
                  width: itemWidth,
                  child: _buildStatCard(item, context),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildStatCard(WeeklyStatItem item, BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final trendColor = item.isUp
        ? (isDark ? AppColors.successDark : AppColors.success)
        : (isDark ? AppColors.dangerDark : AppColors.danger);
    final trendBg = item.isUp
        ? (isDark ? AppColors.successDarkSoft : AppColors.successSoft)
        : (isDark ? AppColors.dangerDarkSoft : AppColors.dangerSoft);

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Label + Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.heading(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: item.iconBgColor,
                  borderRadius: AppDimensions.rMd,
                ),
                child: Center(
                  child: FaIcon(
                    item.icon,
                    color: item.iconColor,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Value
          Text(
            item.value,
            style: AppTypography.num(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 10),

          // Bottom row: Trend badge + SubLabel
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: trendBg,
                  borderRadius: AppDimensions.rPill,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(
                      item.isUp
                          ? FontAwesomeIcons.arrowUp
                          : FontAwesomeIcons.arrowDown,
                      size: 9,
                      color: trendColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.trend,
                      style: AppTypography.heading(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: trendColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.subLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body(
                    fontSize: 12,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
