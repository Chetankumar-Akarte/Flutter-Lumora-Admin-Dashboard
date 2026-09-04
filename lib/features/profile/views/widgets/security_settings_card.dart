import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../models/profile_model.dart';
import '../../viewmodel/profile_provider.dart';

class SecuritySettingsCard extends ConsumerWidget {
  final SecuritySettingsData securitySettings;

  const SecuritySettingsCard({
    super.key,
    required this.securitySettings,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: AppDimensions.rLg,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.lock,
                size: 15,
                color: isDark ? AppColors.brandDark : AppColors.brand,
              ),
              const SizedBox(width: 10),
              Text(
                'Security Settings',
                style: AppTypography.heading(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Items
          _buildSecurityRow(
            title: 'Two-Factor Authentication',
            desc: 'SMS & Authenticator app enabled',
            action: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? AppColors.successDarkSoft : AppColors.successSoft,
                borderRadius: AppDimensions.rPill,
              ),
              child: Text(
                'Active',
                style: AppTypography.heading(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.successDark : AppColors.success,
                ),
              ),
            ),
            isDark: isDark,
            theme: theme,
          ),
          _buildSecurityRow(
            title: 'Session Management',
            desc: '${securitySettings.activeSessions} active session (current device)',
            action: AppButton(
              text: 'Manage',
              size: AppButtonSize.sm,
              variant: AppButtonVariant.soft,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Device session manager opened',
                      style: AppTypography.body(fontSize: 13.5, color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    backgroundColor: isDark ? AppColors.darkSurface3 : const Color(0xFF1E293B),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppDimensions.rMd,
                      side: BorderSide(color: isDark ? AppColors.darkBorder : Colors.transparent),
                    ),
                  ),
                );
              },
            ),
            isDark: isDark,
            theme: theme,
          ),
          _buildSecurityRow(
            title: 'Password',
            desc: 'Last updated ${securitySettings.passwordLastUpdated}',
            action: AppButton(
              text: 'Change',
              size: AppButtonSize.sm,
              variant: AppButtonVariant.soft,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Change password flow requested',
                      style: AppTypography.body(fontSize: 13.5, color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    backgroundColor: isDark ? AppColors.darkSurface3 : const Color(0xFF1E293B),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppDimensions.rMd,
                      side: BorderSide(color: isDark ? AppColors.darkBorder : Colors.transparent),
                    ),
                  ),
                );
              },
            ),
            isDark: isDark,
            theme: theme,
          ),
          _buildSecurityRow(
            title: 'Login Alerts',
            desc: 'Email notifications enabled',
            action: Switch.adaptive(
              value: securitySettings.loginAlertsEnabled,
              activeTrackColor: isDark ? AppColors.brandDark : AppColors.brand,
              onChanged: (val) {
                ref.read(profileProvider.notifier).toggleLoginAlerts(val);
              },
            ),
            isDark: isDark,
            theme: theme,
          ),
          _buildSecurityRow(
            title: 'API Keys',
            desc: '${securitySettings.activeApiKeys} active keys',
            action: AppButton(
              text: 'Manage',
              size: AppButtonSize.sm,
              variant: AppButtonVariant.soft,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'API keys manager opened',
                      style: AppTypography.body(fontSize: 13.5, color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    backgroundColor: isDark ? AppColors.darkSurface3 : const Color(0xFF1E293B),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppDimensions.rMd,
                      side: BorderSide(color: isDark ? AppColors.darkBorder : Colors.transparent),
                    ),
                  ),
                );
              },
            ),
            isDark: isDark,
            theme: theme,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityRow({
    required String title,
    required String desc,
    required Widget action,
    required bool isDark,
    required ThemeData theme,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.heading(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: AppTypography.body(
                    fontSize: 12,
                    color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          action,
        ],
      ),
    );
  }
}
