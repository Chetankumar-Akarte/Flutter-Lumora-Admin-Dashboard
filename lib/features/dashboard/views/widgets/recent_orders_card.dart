import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/avatar_badge.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../data/models/dashboard_models.dart';

class RecentOrdersCard extends StatelessWidget {
  final List<RecentOrderItem> orders;

  const RecentOrdersCard({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppCard(
      title: 'Recent Orders',
      headerAction: AppButton(
        text: 'View all',
        icon: const FaIcon(FontAwesomeIcons.arrowRight, size: 11),
        variant: AppButtonVariant.ghost,
        size: AppButtonSize.sm,
        onPressed: () {},
      ),
      padding: EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tableWidth = constraints.maxWidth > 800 ? constraints.maxWidth : 800.0;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: tableWidth,
              child: Column(
                children: [
                  // Table Header with Separator
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface2 : AppColors.lightSurface2,
                      border: Border(
                        bottom: BorderSide(color: theme.colorScheme.outline),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'CUSTOMER',
                            style: AppTypography.heading(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            'SUBJECT',
                            style: AppTypography.heading(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'STATUS',
                            style: AppTypography.heading(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'DATE',
                            style: AppTypography.heading(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'TRACKING ID',
                            style: AppTypography.heading(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Table Body Rows
                  ...orders.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isLast = index == orders.length - 1;

                    return Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        border: isLast
                            ? null
                            : Border(
                                bottom: BorderSide(color: theme.colorScheme.outline),
                              ),
                      ),
                      child: Row(
                        children: [
                          // 1. Customer Avatar + Name
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                AvatarBadge(
                                  imageUrl: item.userAvatar,
                                  size: 32,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    item.userName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.heading(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 2. Subject
                          Expanded(
                            flex: 4,
                            child: Text(
                              item.subject,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.body(
                                fontSize: 13,
                                color: theme.textTheme.bodyMedium?.color,
                              ),
                            ),
                          ),

                          // 3. Status
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: StatusBadge(status: item.status),
                            ),
                          ),

                          // 4. Date
                          Expanded(
                            flex: 2,
                            child: Text(
                              item.date,
                              style: AppTypography.body(
                                fontSize: 12,
                                color: theme.textTheme.bodySmall?.color,
                              ),
                            ),
                          ),

                          // 5. Tracking ID
                          Expanded(
                            flex: 2,
                            child: Text(
                              item.trackingId,
                              style: AppTypography.mono(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
