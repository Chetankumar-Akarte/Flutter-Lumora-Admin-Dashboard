import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../models/profile_model.dart';

class RecentActivityTimelineCard extends StatelessWidget {
  final List<ActivityItemData> activities;

  const RecentActivityTimelineCard({
    super.key,
    required this.activities,
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
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.clockRotateLeft,
                    size: 15,
                    color: isDark ? AppColors.brandDark : AppColors.brand,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Recent Activity',
                    style: AppTypography.heading(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Activity log history opened',
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
                child: Text(
                  'View all',
                  style: AppTypography.body(
                    fontSize: 12,
                    color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Timeline items
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final item = activities[index];
              final isLast = index == activities.length - 1;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline Node & Vertical Connector Line
                    SizedBox(
                      width: 22,
                      child: Column(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            margin: const EdgeInsets.only(top: 3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: item.isActive
                                  ? (isDark ? AppColors.brandDark : AppColors.brand)
                                  : (isDark ? AppColors.darkSurface : AppColors.lightSurface),
                              border: Border.all(
                                color: item.isActive
                                    ? (isDark ? AppColors.brandDark : AppColors.brand)
                                    : (isDark ? AppColors.darkBorderStrong : AppColors.lightBorderStrong),
                                width: 2,
                              ),
                            ),
                          ),
                          if (!isLast)
                            Expanded(
                              child: Container(
                                width: 2,
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Content
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.time,
                              style: AppTypography.heading(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.6,
                                color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                              ),
                            ),
                            const SizedBox(height: 3),
                            RichText(
                              text: TextSpan(
                                style: AppTypography.body(
                                  fontSize: 13,
                                  color: theme.colorScheme.onSurface,
                                ),
                                children: [
                                  TextSpan(text: item.prefix),
                                  TextSpan(
                                    text: item.highlight,
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(text: item.suffix),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
