import '../data/models/dashboard_models.dart';

class DashboardState {
  final bool isLoading;
  final String selectedTimeframe; // 'Year', 'Month', 'Week'
  final String selectedDatePreset; // 'Last 30 days', 'Last 7 days', etc.
  final List<KpiMetric> kpiMetrics;
  final List<VisitSalesPoint> visitSalesData;
  final List<TrafficSourceItem> trafficSources;
  final List<WeeklyStatItem> weeklyStats;
  final List<GoalItem> q2Goals;
  final List<ChannelSalesItem> salesByChannel;
  final List<RecentOrderItem> recentOrders;
  final List<ActivityItem> recentActivities;
  final List<TeamMemberItem> teamMembers;
  final List<TopProductItem> topProducts;

  const DashboardState({
    this.isLoading = false,
    this.selectedTimeframe = 'Year',
    this.selectedDatePreset = 'Last 30 days',
    this.kpiMetrics = const [],
    this.visitSalesData = const [],
    this.trafficSources = const [],
    this.weeklyStats = const [],
    this.q2Goals = const [],
    this.salesByChannel = const [],
    this.recentOrders = const [],
    this.recentActivities = const [],
    this.teamMembers = const [],
    this.topProducts = const [],
  });

  DashboardState copyWith({
    bool? isLoading,
    String? selectedTimeframe,
    String? selectedDatePreset,
    List<KpiMetric>? kpiMetrics,
    List<VisitSalesPoint>? visitSalesData,
    List<TrafficSourceItem>? trafficSources,
    List<WeeklyStatItem>? weeklyStats,
    List<GoalItem>? q2Goals,
    List<ChannelSalesItem>? salesByChannel,
    List<RecentOrderItem>? recentOrders,
    List<ActivityItem>? recentActivities,
    List<TeamMemberItem>? teamMembers,
    List<TopProductItem>? topProducts,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      selectedTimeframe: selectedTimeframe ?? this.selectedTimeframe,
      selectedDatePreset: selectedDatePreset ?? this.selectedDatePreset,
      kpiMetrics: kpiMetrics ?? this.kpiMetrics,
      visitSalesData: visitSalesData ?? this.visitSalesData,
      trafficSources: trafficSources ?? this.trafficSources,
      weeklyStats: weeklyStats ?? this.weeklyStats,
      q2Goals: q2Goals ?? this.q2Goals,
      salesByChannel: salesByChannel ?? this.salesByChannel,
      recentOrders: recentOrders ?? this.recentOrders,
      recentActivities: recentActivities ?? this.recentActivities,
      teamMembers: teamMembers ?? this.teamMembers,
      topProducts: topProducts ?? this.topProducts,
    );
  }
}
