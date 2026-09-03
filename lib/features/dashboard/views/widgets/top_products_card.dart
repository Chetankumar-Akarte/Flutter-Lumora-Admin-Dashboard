import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../data/models/dashboard_models.dart';

class TopProductsCard extends StatelessWidget {
  final List<TopProductItem> products;

  const TopProductsCard({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppCard(
      title: 'Top Products',
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
                  // Table Header Row with Separator
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
                            'PRODUCT',
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
                            'CATEGORY',
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
                            'UNITS SOLD',
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
                            'REVENUE',
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
                            'TREND',
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
                            'STOCK',
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
                  ...products.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isLast = index == products.length - 1;
                    final trendColor = item.isTrendUp
                        ? (isDark ? AppColors.successDark : AppColors.success)
                        : (isDark ? AppColors.dangerDark : AppColors.danger);
                    final trendBg = item.isTrendUp
                        ? (isDark ? AppColors.successDarkSoft : AppColors.successSoft)
                        : (isDark ? AppColors.dangerDarkSoft : AppColors.dangerSoft);

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
                          // 1. PRODUCT
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: item.iconGradient,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: AppDimensions.rMd,
                                  ),
                                  child: Center(
                                    child: FaIcon(
                                      item.icon,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item.name,
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

                          // 2. CATEGORY
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? item.categoryColor.withValues(alpha: 0.18)
                                      : item.categoryBgColor,
                                  borderRadius: AppDimensions.rPill,
                                ),
                                child: Text(
                                  item.category,
                                  style: AppTypography.heading(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: isDark ? Colors.white : item.categoryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 3. UNITS SOLD
                          Expanded(
                            flex: 2,
                            child: Text(
                              item.unitsSold,
                              style: AppTypography.num(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),

                          // 4. REVENUE
                          Expanded(
                            flex: 2,
                            child: Text(
                              item.revenue,
                              style: AppTypography.num(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),

                          // 5. TREND
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: trendBg,
                                  borderRadius: AppDimensions.rPill,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FaIcon(
                                      item.isTrendUp
                                          ? FontAwesomeIcons.arrowUp
                                          : FontAwesomeIcons.arrowDown,
                                      size: 9,
                                      color: trendColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      item.trend,
                                      style: AppTypography.heading(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: trendColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // 6. STOCK
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: AppDimensions.rPill,
                                    child: Container(
                                      height: 6,
                                      color: isDark ? AppColors.darkSurface2 : AppColors.lightSurface2,
                                      child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: item.stockPercentage.clamp(0.0, 1.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: item.stockColor,
                                            borderRadius: AppDimensions.rPill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${(item.stockPercentage * 100).toInt()}%',
                                  style: AppTypography.body(
                                    fontSize: 11,
                                    color: theme.textTheme.bodySmall?.color,
                                  ),
                                ),
                              ],
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
