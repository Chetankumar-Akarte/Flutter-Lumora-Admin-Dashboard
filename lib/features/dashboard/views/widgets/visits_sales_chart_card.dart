import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/segmented_control.dart';
import '../../data/models/dashboard_models.dart';

class VisitsSalesChartCard extends StatelessWidget {
  final List<VisitSalesPoint> dataPoints;
  final String selectedTimeframe;
  final ValueChanged<String> onTimeframeChanged;

  const VisitsSalesChartCard({
    super.key,
    required this.dataPoints,
    required this.selectedTimeframe,
    required this.onTimeframeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final visitSpots = dataPoints.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.visits);
    }).toList();

    final salesSpots = dataPoints.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.sales);
    }).toList();

    double maxY = 600;
    if (dataPoints.isNotEmpty) {
      final maxVisit = dataPoints.map((e) => e.visits).reduce((a, b) => a > b ? a : b);
      final maxSale = dataPoints.map((e) => e.sales).reduce((a, b) => a > b ? a : b);
      final highest = maxVisit > maxSale ? maxVisit : maxSale;
      maxY = (highest * 1.15).ceilToDouble();
    }

    return AppCard(
      title: 'Visit and Sales Statistics',
      subtitle: 'Compare last 12 months',
      headerAction: SegmentedControl<String>(
        items: const ['Year', 'Month', 'Week'],
        selectedValue: selectedTimeframe,
        labelBuilder: (s) => s,
        onValueChanged: onTimeframeChanged,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Legend
          Row(
            children: [
              _buildLegendItem(
                label: 'Visits',
                color: isDark ? AppColors.brandDark : AppColors.brand,
                theme: theme,
              ),
              const SizedBox(width: 20),
              _buildLegendItem(
                label: 'Sales',
                color: isDark ? AppColors.successDark : AppColors.success,
                theme: theme,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Chart
          SizedBox(
            height: 260,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: (dataPoints.length - 1).toDouble().clamp(0, 50),
                minY: 0,
                maxY: maxY,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: maxY / 4 > 0 ? (maxY / 4) : 100,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: theme.colorScheme.outline.withValues(alpha: 0.6),
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: maxY / 4 > 0 ? (maxY / 4) : 100,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: AppTypography.num(
                            fontSize: 11,
                            color: theme.textTheme.bodySmall?.color,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < dataPoints.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              dataPoints[index].label,
                              style: AppTypography.body(
                                fontSize: 11,
                                color: theme.textTheme.bodySmall?.color,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  // Visits Series
                  LineChartBarData(
                    spots: visitSpots,
                    isCurved: true,
                    curveSmoothness: 0.35,
                    color: isDark ? AppColors.brandDark : AppColors.brand,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          (isDark ? AppColors.brandDark : AppColors.brand)
                              .withValues(alpha: 0.3),
                          (isDark ? AppColors.brandDark : AppColors.brand)
                              .withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                  // Sales Series
                  LineChartBarData(
                    spots: salesSpots,
                    isCurved: true,
                    curveSmoothness: 0.35,
                    color: isDark ? AppColors.successDark : AppColors.success,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          (isDark ? AppColors.successDark : AppColors.success)
                              .withValues(alpha: 0.25),
                          (isDark ? AppColors.successDark : AppColors.success)
                              .withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required String label,
    required Color color,
    required ThemeData theme,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTypography.heading(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }
}
