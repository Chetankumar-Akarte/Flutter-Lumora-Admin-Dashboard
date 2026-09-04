import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../models/profile_model.dart';
import 'edit_contact_dialog.dart';

class ContactInfoCard extends StatelessWidget {
  final ContactInfo contactInfo;

  const ContactInfoCard({
    super.key,
    required this.contactInfo,
  });

  @override
  Widget build(BuildContext context) {
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
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.envelope,
                    size: 15,
                    color: isDark ? AppColors.brandDark : AppColors.brand,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Contact Information',
                    style: AppTypography.heading(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              AppButton(
                text: 'Edit',
                icon: const FaIcon(
                  FontAwesomeIcons.pen,
                  size: 11,
                ),
                size: AppButtonSize.sm,
                variant: AppButtonVariant.soft,
                onPressed: () {
                  EditContactDialog.show(context, contactInfo);
                },
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 2-Column Info Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 420;

              if (isNarrow) {
                return Column(
                  children: [
                    _buildInfoItem('EMAIL', contactInfo.email, isDark, theme, isLink: true),
                    const SizedBox(height: 12),
                    _buildInfoItem('PHONE', contactInfo.phone, isDark, theme),
                    const SizedBox(height: 12),
                    _buildInfoItem('DEPARTMENT', contactInfo.department, isDark, theme),
                    const SizedBox(height: 12),
                    _buildInfoItem('ORGANIZATION', contactInfo.organization, isDark, theme),
                    const SizedBox(height: 12),
                    _buildInfoItem('LOCATION', contactInfo.location, isDark, theme),
                    const SizedBox(height: 12),
                    _buildInfoItem('TIMEZONE', contactInfo.timezone, isDark, theme),
                  ],
                );
              }

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          'EMAIL',
                          contactInfo.email,
                          isDark,
                          theme,
                          isLink: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInfoItem(
                          'PHONE',
                          contactInfo.phone,
                          isDark,
                          theme,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          'DEPARTMENT',
                          contactInfo.department,
                          isDark,
                          theme,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInfoItem(
                          'ORGANIZATION',
                          contactInfo.organization,
                          isDark,
                          theme,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          'LOCATION',
                          contactInfo.location,
                          isDark,
                          theme,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInfoItem(
                          'TIMEZONE',
                          contactInfo.timezone,
                          isDark,
                          theme,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    String label,
    String value,
    bool isDark,
    ThemeData theme, {
    bool isLink = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.heading(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
            color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTypography.body(
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: isLink
                ? (isDark ? AppColors.brandDark : AppColors.brand)
                : theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
