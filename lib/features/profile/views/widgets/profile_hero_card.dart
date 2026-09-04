import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/widgets/app_button.dart';
import '../../models/profile_model.dart';
import 'edit_profile_dialog.dart';

class ProfileHeroCard extends StatelessWidget {
  final UserProfile profile;

  const ProfileHeroCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: AppDimensions.rLg,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: AppDimensions.rLg,
        child: Stack(
          children: [
            // Background Radial Gradients matching CSS
            Positioned(
              top: -60,
              left: -60,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      (isDark ? AppColors.brandDark : AppColors.brand)
                          .withValues(alpha: isDark ? 0.18 : 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              right: -60,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      (isDark ? AppColors.successDark : AppColors.success)
                          .withValues(alpha: isDark ? 0.14 : 0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Content
            Padding(
              padding: EdgeInsets.all(isMobile ? 18 : 28),
              child: Column(
                crossAxisAlignment:
                    isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  // Top Row: Avatar & Profile Info
                  if (isMobile)
                    Column(
                      children: [
                        _buildAvatar(isDark),
                        const SizedBox(height: 16),
                        _buildProfileDetails(context, isDark, isMobile),
                      ],
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAvatar(isDark),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildProfileDetails(context, isDark, isMobile),
                        ),
                      ],
                    ),

                  const SizedBox(height: 20),

                  // Action Buttons
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                    children: [
                      AppButton(
                        text: 'Edit Profile',
                        icon: const FaIcon(
                          FontAwesomeIcons.penToSquare,
                          size: 13,
                        ),
                        variant: AppButtonVariant.primary,
                        onPressed: () {
                          EditProfileDialog.show(context, profile);
                        },
                      ),
                      AppButton(
                        text: 'Download Resume',
                        icon: const FaIcon(
                          FontAwesomeIcons.download,
                          size: 13,
                        ),
                        variant: AppButtonVariant.soft,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(Icons.downloading_rounded, color: Colors.white, size: 18),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Resume download initiated...',
                                    style: AppTypography.body(
                                      fontSize: 13.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: isDark ? AppColors.darkSurface3 : const Color(0xFF1E293B),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 3),
                              shape: RoundedRectangleBorder(
                                borderRadius: AppDimensions.rMd,
                                side: BorderSide(
                                  color: isDark ? AppColors.darkBorder : Colors.transparent,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      AppButton(
                        text: 'Share Profile',
                        icon: const FaIcon(
                          FontAwesomeIcons.shareNodes,
                          size: 13,
                        ),
                        variant: AppButtonVariant.soft,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 18),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Profile link copied to clipboard!',
                                    style: AppTypography.body(
                                      fontSize: 13.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: AppColors.brand,
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 3),
                              shape: RoundedRectangleBorder(
                                borderRadius: AppDimensions.rMd,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(bool isDark) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            borderRadius: AppDimensions.rLg,
            border: Border.all(
              color: isDark ? AppColors.brandDark : AppColors.brand,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: (isDark ? AppColors.brandDark : AppColors.brand)
                    .withValues(alpha: 0.2),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: Image.network(
              profile.avatarUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: isDark ? AppColors.darkSurface2 : AppColors.lightSurface2,
                child: Center(
                  child: Text(
                    '${profile.firstName[0]}${profile.lastName[0]}',
                    style: AppTypography.heading(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.brandDark : AppColors.brand,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: isDark ? AppColors.successDark : AppColors.success,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                width: 2.5,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileDetails(BuildContext context, bool isDark, bool isMobile) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Full Name
        Text(
          profile.fullName,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: AppTypography.heading(
            fontSize: isMobile ? 22 : 26,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),

        // Title
        Text(
          profile.title,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: AppTypography.body(
            fontSize: 15,
            color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
          ),
        ),
        const SizedBox(height: 12),

        // Badges Row
        Wrap(
          spacing: 8,
          runSpacing: 6,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _buildBadge(
              icon: FontAwesomeIcons.code,
              label: 'ARCHITECT',
              bgColor: (isDark ? AppColors.brandDark : AppColors.brand)
                  .withValues(alpha: 0.12),
              textColor: isDark ? AppColors.brandDark : AppColors.brand,
            ),
            if (profile.isVerified)
              _buildBadge(
                icon: FontAwesomeIcons.circleCheck,
                label: 'VERIFIED',
                bgColor: (isDark ? AppColors.successDark : AppColors.success)
                    .withValues(alpha: 0.12),
                textColor: isDark ? AppColors.successDark : AppColors.success,
              ),
          ],
        ),
        const SizedBox(height: 14),

        // Meta Details (Joined, Last active, Location)
        Wrap(
          spacing: 18,
          runSpacing: 8,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _buildMetaItem(
              icon: FontAwesomeIcons.calendar,
              label: 'Joined ',
              boldText: profile.joinedDate,
              isDark: isDark,
              theme: theme,
            ),
            _buildMetaItem(
              icon: FontAwesomeIcons.clock,
              label: 'Last active ',
              boldText: profile.lastActive,
              isDark: isDark,
              theme: theme,
            ),
            _buildMetaItem(
              icon: FontAwesomeIcons.globe,
              label: '',
              boldText: profile.location,
              isDark: isDark,
              theme: theme,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBadge({
    required FaIconData icon,
    required String label,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppDimensions.rPill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, size: 10, color: textColor),
          const SizedBox(width: 5),
          Text(
            label,
            style: AppTypography.heading(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem({
    required FaIconData icon,
    required String label,
    required String boldText,
    required bool isDark,
    required ThemeData theme,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(
          icon,
          size: 13,
          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
        ),
        const SizedBox(width: 6),
        RichText(
          text: TextSpan(
            style: AppTypography.body(
              fontSize: 13,
              color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
            ),
            children: [
              if (label.isNotEmpty) TextSpan(text: label),
              TextSpan(
                text: boldText,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
