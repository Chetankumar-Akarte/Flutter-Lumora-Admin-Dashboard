import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../navigation/viewmodel/navigation_provider.dart';
import '../viewmodel/profile_provider.dart';
import 'widgets/contact_info_card.dart';
import 'widgets/profile_hero_card.dart';
import 'widgets/profile_stats_row.dart';
import 'widgets/recent_activity_timeline_card.dart';
import 'widgets/roles_permissions_card.dart';
import 'widgets/security_settings_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = ResponsiveLayout.isMobile(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? AppDimensions.contentGutterSm : AppDimensions.contentGutter,
          vertical: AppDimensions.sp5,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppDimensions.maxContentWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Page Header & Breadcrumbs
                _buildPageHeader(context, ref, isDark, theme),
                const SizedBox(height: 20),

                // 2. Profile Hero Section
                ProfileHeroCard(profile: profile),
                const SizedBox(height: 20),

                // 3. Stats Overview Row (4 cards)
                ProfileStatsRow(stats: profile.stats),
                const SizedBox(height: 20),

                // 4. Main 2-Column Responsive Layout
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 960;

                    if (isWide) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Column: Contact Info & Roles/Permissions
                          Expanded(
                            child: Column(
                              children: [
                                ContactInfoCard(contactInfo: profile.contactInfo),
                                const SizedBox(height: 16),
                                RolesPermissionsCard(
                                  roleBadge: profile.roleBadge,
                                  permissions: profile.permissions,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Right Column: Recent Activity & Security Settings
                          Expanded(
                            child: Column(
                              children: [
                                RecentActivityTimelineCard(activities: profile.activities),
                                const SizedBox(height: 16),
                                SecuritySettingsCard(
                                  securitySettings: profile.securitySettings,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }

                    // Narrow / Mobile: Stacked Columns
                    return Column(
                      children: [
                        ContactInfoCard(contactInfo: profile.contactInfo),
                        const SizedBox(height: 16),
                        RolesPermissionsCard(
                          roleBadge: profile.roleBadge,
                          permissions: profile.permissions,
                        ),
                        const SizedBox(height: 16),
                        RecentActivityTimelineCard(activities: profile.activities),
                        const SizedBox(height: 16),
                        SecuritySettingsCard(
                          securitySettings: profile.securitySettings,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeader(
    BuildContext context,
    WidgetRef ref,
    bool isDark,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Admin Profile',
          style: AppTypography.heading(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            InkWell(
              onTap: () {
                ref.read(navigationProvider.notifier).selectPage('dashboard');
              },
              child: Text(
                'Home',
                style: AppTypography.body(
                  fontSize: 13,
                  color: isDark ? AppColors.brandDark : AppColors.brand,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FaIcon(
                FontAwesomeIcons.chevronRight,
                size: 9,
                color: isDark ? AppColors.darkTextSoft : AppColors.lightTextSoft,
              ),
            ),
            Text(
              'Pages',
              style: AppTypography.body(
                fontSize: 13,
                color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FaIcon(
                FontAwesomeIcons.chevronRight,
                size: 9,
                color: isDark ? AppColors.darkTextSoft : AppColors.lightTextSoft,
              ),
            ),
            Text(
              'Profile',
              style: AppTypography.heading(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
