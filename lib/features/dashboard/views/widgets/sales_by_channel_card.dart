import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../data/models/dashboard_models.dart';

class SalesByChannelCard extends StatelessWidget {
  final List<ChannelSalesItem> channels;

  const SalesByChannelCard({super.key, required this.channels});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppCard(
      title: 'Sales by Channel',
      headerAction: AppButton(
        text: 'View report',
        icon: const Icon(Icons.arrow_forward_rounded, size: 14),
        variant: AppButtonVariant.ghost,
        size: AppButtonSize.sm,
        onPressed: () {},
      ),
      child: Column(
        children: channels
            .map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: _buildChannelItem(item, theme, isDark),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildChannelItem(ChannelSalesItem item, ThemeData theme, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Brand Icon Container
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: item.iconColor.withValues(alpha: isDark ? 0.2 : 0.12),
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
        const SizedBox(width: 14),

        // Channel Details & Progress Bar
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.channelName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.heading(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.amount,
                        style: AppTypography.num(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.percentageChange,
                        style: AppTypography.heading(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: item.isPositive
                              ? (isDark ? AppColors.successDark : AppColors.success)
                              : (isDark ? AppColors.dangerDark : AppColors.danger),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: AppDimensions.rPill,
                child: Container(
                  height: 7,
                  width: double.infinity,
                  color: isDark ? AppColors.darkSurface2 : AppColors.lightSurface2,
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: item.progress.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: item.gradient),
                        borderRadius: AppDimensions.rPill,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
