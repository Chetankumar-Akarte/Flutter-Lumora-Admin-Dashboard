import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../models/profile_model.dart';

class ProfileStatsRow extends StatelessWidget {
  final List<MetricStat> stats;

  const ProfileStatsRow({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;
        final isTablet = constraints.maxWidth >= 500 && constraints.maxWidth < 900;

        if (isDesktop) {
          // 4 items in one row
          return Row(
            children: [
              for (int i = 0; i < stats.length; i++) ...[
                if (i > 0) const SizedBox(width: 16),
                Expanded(child: _buildStatCard(context, stats[i])),
              ],
            ],
          );
        } else if (isTablet) {
          // 2x2 Grid
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildStatCard(context, stats[0])),
                  const SizedBox(width: 14),
                  Expanded(child: _buildStatCard(context, stats[1])),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: _buildStatCard(context, stats[2])),
                  const SizedBox(width: 14),
                  Expanded(child: _buildStatCard(context, stats[3])),
                ],
              ),
            ],
          );
        } else {
          // Mobile: 2x2 or column
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildStatCard(context, stats[0])),
                  const SizedBox(width: 10),
                  Expanded(child: _buildStatCard(context, stats[1])),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _buildStatCard(context, stats[2])),
                  const SizedBox(width: 10),
                  Expanded(child: _buildStatCard(context, stats[3])),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildStatCard(BuildContext context, MetricStat stat) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: AppDimensions.rLg,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            stat.value,
            style: AppTypography.heading(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.brandDark : AppColors.brand,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              stat.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.body(
                fontSize: 12.5,
                color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
