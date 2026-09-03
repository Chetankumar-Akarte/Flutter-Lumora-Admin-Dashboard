import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/avatar_badge.dart';
import '../../data/models/dashboard_models.dart';

class TeamMembersCard extends StatelessWidget {
  final List<TeamMemberItem> members;

  const TeamMembersCard({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppCard(
      title: 'Team Members',
      headerAction: AppButton(
        text: 'Manage',
        icon: const FaIcon(FontAwesomeIcons.arrowRight, size: 11),
        variant: AppButtonVariant.ghost,
        size: AppButtonSize.sm,
        onPressed: () {},
      ),
      child: Column(
        children: members
            .map((member) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildMemberItem(member, theme, isDark),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildMemberItem(TeamMemberItem member, ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: AppDimensions.rMd,
      ),
      child: Row(
        children: [
          AvatarBadge(
            imageUrl: member.avatarUrl,
            size: 38,
            isOnline: member.isOnline,
            statusColor: member.statusColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: AppTypography.heading(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  member.role,
                  style: AppTypography.body(
                    fontSize: 12,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: isDark ? AppColors.brandDarkSoft : AppColors.brandSoft,
              borderRadius: AppDimensions.rPill,
            ),
            child: Text(
              '${member.taskCount} tasks',
              style: AppTypography.heading(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.brandDark : AppColors.brand,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
