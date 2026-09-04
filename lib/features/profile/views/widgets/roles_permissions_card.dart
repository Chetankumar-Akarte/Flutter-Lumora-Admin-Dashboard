import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../models/profile_model.dart';

class RolesPermissionsCard extends StatelessWidget {
  final String roleBadge;
  final List<PermissionChipData> permissions;

  const RolesPermissionsCard({
    super.key,
    required this.roleBadge,
    required this.permissions,
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
            children: [
              FaIcon(
                FontAwesomeIcons.shieldHalved,
                size: 15,
                color: isDark ? AppColors.brandDark : AppColors.brand,
              ),
              const SizedBox(width: 10),
              Text(
                'Roles & Permissions',
                style: AppTypography.heading(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Role Badge Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: (isDark ? AppColors.brandDark : AppColors.brand)
                  .withValues(alpha: 0.12),
              borderRadius: AppDimensions.rPill,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.crown,
                  size: 11,
                  color: isDark ? AppColors.brandDark : AppColors.brand,
                ),
                const SizedBox(width: 8),
                Text(
                  roleBadge,
                  style: AppTypography.heading(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.brandDark : AppColors.brand,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Permission Chips Grid (3 cols on normal, 2 cols on mobile)
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth < 360
                  ? 2
                  : (constraints.maxWidth < 540 ? 3 : 3);

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: permissions.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.6,
                ),
                itemBuilder: (context, index) {
                  final item = permissions[index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface2 : AppColors.lightSurface2,
                      borderRadius: AppDimensions.rMd,
                      border: Border.all(
                        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          item.icon,
                          size: 18,
                          color: isDark ? AppColors.brandDark : AppColors.brand,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.label,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.heading(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
