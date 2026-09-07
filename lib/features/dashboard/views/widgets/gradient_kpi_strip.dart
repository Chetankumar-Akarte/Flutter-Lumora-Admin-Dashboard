import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/sparkline_painter.dart';
import '../../data/models/dashboard_models.dart';

class GradientKpiStrip extends StatelessWidget {
  final List<KpiMetric> metrics;

  const GradientKpiStrip({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int crossAxisCount = 4;
        if (width < 520) {
          crossAxisCount = 1;
        } else if (width < 820) {
          crossAxisCount = 2;
        }

        if (crossAxisCount == 1) {
          return Column(
            children: metrics
                .map(
                  (m) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildGradientCard(m),
                  ),
                )
                .toList(),
          );
        }

        final double itemWidth =
            (width - ((crossAxisCount - 1) * 16)) / crossAxisCount;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: metrics
              .map(
                (m) => SizedBox(
                  width: itemWidth,
                  child: _buildGradientCard(m),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildGradientCard(KpiMetric metric) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: metric.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppDimensions.rLg,
        boxShadow: [
          BoxShadow(
            color: metric.gradientColors.first.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Icon + Trend Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: AppDimensions.rMd,
                ),
                child: Center(
                  child: FaIcon(
                    metric.icon,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: AppDimensions.rPill,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(
                      metric.isPositive
                          ? FontAwesomeIcons.arrowUp
                          : FontAwesomeIcons.arrowDown,
                      size: 10,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${metric.changePercentage}%',
                      style: AppTypography.heading(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Value
          Text(
            metric.value,
            style: AppTypography.num(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),

          // Title
          Text(
            metric.title,
            style: AppTypography.body(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 12),

          // Sparkline Curve
          SizedBox(
            height: 32,
            width: double.infinity,
            child: CustomPaint(
              painter: SparklinePainter(
                dataPoints: metric.sparklineData,
                lineColor: Colors.white.withValues(alpha: 0.9),
                fillColor: Colors.white.withValues(alpha: 0.3),
                strokeWidth: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
