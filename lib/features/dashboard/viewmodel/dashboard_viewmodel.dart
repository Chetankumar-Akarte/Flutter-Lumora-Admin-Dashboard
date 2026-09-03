import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/dashboard_repository.dart';
import 'dashboard_state.dart';

class DashboardViewModel extends StateNotifier<DashboardState> {
  final DashboardRepository _repository;

  DashboardViewModel(this._repository) : super(const DashboardState()) {
    loadDashboardData();
  }

  void loadDashboardData() {
    state = state.copyWith(isLoading: true);

    final kpis = _repository.getKpiMetrics();
    final visitSales = _repository.getVisitSalesData(state.selectedTimeframe);
    final traffic = _repository.getTrafficSources();
    final weekly = _repository.getWeeklyStats();
    final goals = _repository.getQ2Goals();
    final channels = _repository.getSalesByChannel();
    final orders = _repository.getRecentOrders();
    final activities = _repository.getRecentActivities();
    final members = _repository.getTeamMembers();
    final products = _repository.getTopProducts();

    state = state.copyWith(
      isLoading: false,
      kpiMetrics: kpis,
      visitSalesData: visitSales,
      trafficSources: traffic,
      weeklyStats: weekly,
      q2Goals: goals,
      salesByChannel: channels,
      recentOrders: orders,
      recentActivities: activities,
      teamMembers: members,
      topProducts: products,
    );
  }

  void setTimeframe(String timeframe) {
    if (state.selectedTimeframe == timeframe) return;
    final visitSales = _repository.getVisitSalesData(timeframe);
    state = state.copyWith(
      selectedTimeframe: timeframe,
      visitSalesData: visitSales,
    );
  }

  void setDatePreset(String preset) {
    state = state.copyWith(selectedDatePreset: preset);
  }
}
