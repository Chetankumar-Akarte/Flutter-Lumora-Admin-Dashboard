import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../../core/widgets/app_button.dart';
import '../viewmodel/dashboard_providers.dart';
import 'widgets/gradient_kpi_strip.dart';
import 'widgets/q2_goals_card.dart';
import 'widgets/recent_activity_card.dart';
import 'widgets/recent_orders_card.dart';
import 'widgets/sales_by_channel_card.dart';
import 'widgets/team_members_card.dart';
import 'widgets/top_products_card.dart';
import 'widgets/traffic_sources_card.dart';
import 'widgets/visits_sales_chart_card.dart';
import 'widgets/weekly_stats_row.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardViewModelProvider);
    final notifier = ref.read(dashboardViewModelProvider.notifier);
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayout.isMobile(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? AppDimensions.contentGutterSm : AppDimensions.contentGutter),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppDimensions.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Header with Breadcrumbs & Action Button
              _buildPageHeader(context, theme, isMobile),
              const SizedBox(height: 20),

              // 1. Gradient KPI Strip
              GradientKpiStrip(metrics: state.kpiMetrics),
              const SizedBox(height: 24),

              // 2. Visits/Sales Chart + Traffic Sources
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 8,
                      child: VisitsSalesChartCard(
                        dataPoints: state.visitSalesData,
                        selectedTimeframe: state.selectedTimeframe,
                        onTimeframeChanged: (timeframe) => notifier.setTimeframe(timeframe),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 4,
                      child: TrafficSourcesCard(items: state.trafficSources),
                    ),
                  ],
                )
              else ...[
                VisitsSalesChartCard(
                  dataPoints: state.visitSalesData,
                  selectedTimeframe: state.selectedTimeframe,
                  onTimeframeChanged: (timeframe) => notifier.setTimeframe(timeframe),
                ),
                const SizedBox(height: 20),
                TrafficSourcesCard(items: state.trafficSources),
              ],
              const SizedBox(height: 24),

              // 3. Weekly Stats KPI Row
              WeeklyStatsRow(items: state.weeklyStats),
              const SizedBox(height: 24),

              // 4. Q2 Goals + Sales by Channel
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Q2GoalsCard(goals: state.q2Goals),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 8,
                      child: SalesByChannelCard(channels: state.salesByChannel),
                    ),
                  ],
                )
              else ...[
                Q2GoalsCard(goals: state.q2Goals),
                const SizedBox(height: 20),
                SalesByChannelCard(channels: state.salesByChannel),
              ],
              const SizedBox(height: 24),

              // 5. Recent Orders Table
              RecentOrdersCard(orders: state.recentOrders),
              const SizedBox(height: 24),

              // 6. Recent Activity Feed + Team Members
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: RecentActivityCard(activities: state.recentActivities),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 5,
                      child: TeamMembersCard(members: state.teamMembers),
                    ),
                  ],
                )
              else ...[
                RecentActivityCard(activities: state.recentActivities),
                const SizedBox(height: 20),
                TeamMembersCard(members: state.teamMembers),
              ],
              const SizedBox(height: 24),

              // 7. Top Products Table
              TopProductsCard(products: state.topProducts),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context, ThemeData theme, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: AppTypography.heading(
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Home',
                    style: AppTypography.body(
                      fontSize: 12,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      size: 14,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                  Text(
                    'Overview',
                    style: AppTypography.body(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        AppButton(
          text: 'New report',
          icon: const FaIcon(FontAwesomeIcons.plus, size: 12, color: Colors.white),
          variant: AppButtonVariant.primary,
          size: AppButtonSize.md,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Generating new report...')),
            );
          },
        ),
      ],
    );
  }
}
