import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../data/models/dashboard_models.dart';

class RecentActivityCard extends StatelessWidget {
  final List<ActivityItem> activities;

  const RecentActivityCard({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      title: 'Recent Activity',
      headerAction: AppButton(
        text: 'View all',
        icon: const FaIcon(FontAwesomeIcons.arrowRight, size: 11),
        variant: AppButtonVariant.ghost,
        size: AppButtonSize.sm,
        onPressed: () {},
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: activities.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == activities.length - 1;

          return Column(
            children: [
              _buildActivityItem(item, theme),
              if (!isLast)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: theme.colorScheme.outline.withValues(alpha: 0.6),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActivityItem(ActivityItem item, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Activity Category Icon Container
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
                size: 14,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Title & Highlight Text & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: AppTypography.body(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                    children: [
                      TextSpan(text: '${item.title} '),
                      TextSpan(
                        text: item.highlightText,
                        style: AppTypography.heading(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: item.iconColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.subtitle,
                  style: AppTypography.body(
                    fontSize: 12,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Time Ago
          Text(
            item.timeAgo,
            style: AppTypography.body(
              fontSize: 11,
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }
}
