import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/status_badge.dart';
import 'models/dashboard_models.dart';

class DashboardRepository {
  List<KpiMetric> getKpiMetrics() {
    return [
      const KpiMetric(
        title: 'Total Revenue',
        value: '\$284,521',
        changePercentage: 18.4,
        isPositive: true,
        icon: FontAwesomeIcons.dollarSign,
        gradientColors: AppColors.kpiGradientRevenue,
        sparklineData: [24, 20, 22, 13, 15, 7, 3],
      ),
      const KpiMetric(
        title: 'New Customers',
        value: '1,842',
        changePercentage: 12.1,
        isPositive: true,
        icon: FontAwesomeIcons.userPlus,
        gradientColors: AppColors.kpiGradientCustomers,
        sparklineData: [26, 22, 24, 15, 17, 9, 11],
      ),
      const KpiMetric(
        title: 'Active Projects',
        value: '38',
        changePercentage: 8.7,
        isPositive: true,
        icon: FontAwesomeIcons.diagramProject,
        gradientColors: AppColors.kpiGradientProjects,
        sparklineData: [25, 29, 17, 19, 11, 15, 7],
      ),
      const KpiMetric(
        title: 'Pending Tasks',
        value: '127',
        changePercentage: 3.2,
        isPositive: false,
        icon: FontAwesomeIcons.listCheck,
        gradientColors: AppColors.kpiGradientTasks,
        sparklineData: [11, 13, 19, 9, 17, 15, 21],
      ),
    ];
  }

  List<VisitSalesPoint> getVisitSalesData(String timeframe) {
    if (timeframe == 'Month') {
      return const [
        VisitSalesPoint(label: 'W1', visits: 180, sales: 120),
        VisitSalesPoint(label: 'W2', visits: 240, sales: 190),
        VisitSalesPoint(label: 'W3', visits: 290, sales: 220),
        VisitSalesPoint(label: 'W4', visits: 340, sales: 270),
      ];
    } else if (timeframe == 'Week') {
      return const [
        VisitSalesPoint(label: 'Mon', visits: 45, sales: 30),
        VisitSalesPoint(label: 'Tue', visits: 60, sales: 48),
        VisitSalesPoint(label: 'Wed', visits: 52, sales: 40),
        VisitSalesPoint(label: 'Thu', visits: 78, sales: 65),
        VisitSalesPoint(label: 'Fri', visits: 90, sales: 80),
        VisitSalesPoint(label: 'Sat', visits: 68, sales: 55),
        VisitSalesPoint(label: 'Sun', visits: 50, sales: 42),
      ];
    }
    // Default 'Year'
    return const [
      VisitSalesPoint(label: 'Jan', visits: 120, sales: 85),
      VisitSalesPoint(label: 'Feb', visits: 160, sales: 110),
      VisitSalesPoint(label: 'Mar', visits: 200, sales: 150),
      VisitSalesPoint(label: 'Apr', visits: 280, sales: 210),
      VisitSalesPoint(label: 'May', visits: 240, sales: 190),
      VisitSalesPoint(label: 'Jun', visits: 320, sales: 260),
      VisitSalesPoint(label: 'Jul', visits: 380, sales: 310),
      VisitSalesPoint(label: 'Aug', visits: 340, sales: 280),
      VisitSalesPoint(label: 'Sep', visits: 410, sales: 350),
      VisitSalesPoint(label: 'Oct', visits: 450, sales: 390),
      VisitSalesPoint(label: 'Nov', visits: 520, sales: 440),
      VisitSalesPoint(label: 'Dec', visits: 590, sales: 510),
    ];
  }

  List<TrafficSourceItem> getTrafficSources() {
    return const [
      TrafficSourceItem(label: 'Search engines', percentage: 30, color: AppColors.chart1),
      TrafficSourceItem(label: 'Direct click', percentage: 30, color: AppColors.chart2),
      TrafficSourceItem(label: 'Bookmarks', percentage: 40, color: AppColors.chart3),
    ];
  }

  List<WeeklyStatItem> getWeeklyStats() {
    return const [
      WeeklyStatItem(
        label: 'Weekly Sales',
        value: '\$15,000',
        trend: '60%',
        isUp: true,
        subLabel: 'vs last week',
        icon: FontAwesomeIcons.sackDollar,
        iconColor: AppColors.brand,
        iconBgColor: AppColors.brandSoft,
      ),
      WeeklyStatItem(
        label: 'Weekly Orders',
        value: '45,634',
        trend: '10%',
        isUp: false,
        subLabel: 'vs last week',
        icon: FontAwesomeIcons.cartShopping,
        iconColor: AppColors.success,
        iconBgColor: AppColors.successSoft,
      ),
      WeeklyStatItem(
        label: 'Visitors Online',
        value: '95,741',
        trend: '5%',
        isUp: true,
        subLabel: 'live now',
        icon: FontAwesomeIcons.usersViewfinder,
        iconColor: AppColors.info,
        iconBgColor: AppColors.infoSoft,
      ),
      WeeklyStatItem(
        label: 'Avg. Conversion',
        value: '3.42%',
        trend: '1.2%',
        isUp: true,
        subLabel: 'this month',
        icon: FontAwesomeIcons.chartLine,
        iconColor: AppColors.warn,
        iconBgColor: AppColors.warnSoft,
      ),
    ];
  }

  List<GoalItem> getQ2Goals() {
    return const [
      GoalItem(
        title: 'Revenue Target',
        currentFormatted: '\$284K',
        targetFormatted: '\$320K',
        percentage: 0.88,
        icon: FontAwesomeIcons.dollarSign,
        color: AppColors.brand,
        gradient: [Color(0xFF5B5BF7), Color(0xFF8B5CF6)],
      ),
      GoalItem(
        title: 'Customer Growth',
        currentFormatted: '1,842',
        targetFormatted: '2,500',
        percentage: 0.74,
        icon: FontAwesomeIcons.users,
        color: AppColors.success,
        gradient: [Color(0xFF22C55E), Color(0xFF16A34A)],
      ),
      GoalItem(
        title: 'Projects Delivered',
        currentFormatted: '38',
        targetFormatted: '50',
        percentage: 0.76,
        icon: FontAwesomeIcons.diagramProject,
        color: AppColors.info,
        gradient: [Color(0xFF0EA5E9), Color(0xFF0284C7)],
      ),
      GoalItem(
        title: 'NPS Score',
        currentFormatted: '67',
        targetFormatted: '80',
        percentage: 0.84,
        icon: FontAwesomeIcons.star,
        color: AppColors.danger,
        gradient: [Color(0xFFEF4444), Color(0xFFDC2626)],
      ),
    ];
  }

  List<ChannelSalesItem> getSalesByChannel() {
    return const [
      ChannelSalesItem(
        channelName: 'Shopify Store',
        amount: '\$98,420',
        percentageChange: '+24%',
        isPositive: true,
        progress: 0.82,
        icon: FontAwesomeIcons.shopify,
        iconColor: AppColors.brand,
        gradient: [Color(0xFF5B5BF7), Color(0xFF8B5CF6)],
      ),
      ChannelSalesItem(
        channelName: 'Amazon Marketplace',
        amount: '\$74,180',
        percentageChange: '+18%',
        isPositive: true,
        progress: 0.62,
        icon: FontAwesomeIcons.amazon,
        iconColor: AppColors.success,
        gradient: [Color(0xFF22C55E), Color(0xFF16A34A)],
      ),
      ChannelSalesItem(
        channelName: 'Direct Website',
        amount: '\$55,260',
        percentageChange: '+11%',
        isPositive: true,
        progress: 0.46,
        icon: FontAwesomeIcons.globe,
        iconColor: AppColors.info,
        gradient: [Color(0xFF0EA5E9), Color(0xFF0284C7)],
      ),
      ChannelSalesItem(
        channelName: 'Instagram Shop',
        amount: '\$31,480',
        percentageChange: '+35%',
        isPositive: true,
        progress: 0.26,
        icon: FontAwesomeIcons.instagram,
        iconColor: AppColors.warn,
        gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
      ),
      ChannelSalesItem(
        channelName: 'Etsy Listings',
        amount: '\$25,183',
        percentageChange: '-4%',
        isPositive: false,
        progress: 0.21,
        icon: FontAwesomeIcons.etsy,
        iconColor: AppColors.danger,
        gradient: [Color(0xFFEF4444), Color(0xFFDC2626)],
      ),
      ChannelSalesItem(
        channelName: 'TikTok Shop',
        amount: '\$18,970',
        percentageChange: '+52%',
        isPositive: true,
        progress: 0.16,
        icon: FontAwesomeIcons.tiktok,
        iconColor: Color(0xFF8B5CF6),
        gradient: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
      ),
    ];
  }

  List<RecentOrderItem> getRecentOrders() {
    return const [
      RecentOrderItem(
        userName: 'Chetankumar Akarte',
        userAvatar: 'https://avatars.githubusercontent.com/u/27378345?v=4',
        subject: 'Fund is not received',
        status: OrderStatus.done,
        date: 'Dec 5, 2025',
        trackingId: 'WD-12345',
      ),
      RecentOrderItem(
        userName: 'Stella Johnson',
        userAvatar: 'https://i.pravatar.cc/64?img=20',
        subject: 'High loading time on checkout',
        status: OrderStatus.inProgress,
        date: 'Dec 12, 2025',
        trackingId: 'WD-12346',
      ),
      RecentOrderItem(
        userName: 'Marina Michel',
        userAvatar: 'https://i.pravatar.cc/64?img=32',
        subject: 'Website down for one week',
        status: OrderStatus.onHold,
        date: 'Dec 16, 2025',
        trackingId: 'WD-12347',
      ),
      RecentOrderItem(
        userName: 'John Doe',
        userAvatar: 'https://i.pravatar.cc/64?img=45',
        subject: 'Losing control on server',
        status: OrderStatus.rejected,
        date: 'Dec 3, 2025',
        trackingId: 'WD-12348',
      ),
    ];
  }

  List<ActivityItem> getRecentActivities() {
    return const [
      ActivityItem(
        title: 'New order from',
        highlightText: 'Sarah Anderson',
        subtitle: '#ORD-7821 · \$340.00 · 3 items',
        timeAgo: '2m ago',
        icon: FontAwesomeIcons.cartShopping,
        iconColor: AppColors.brand,
        iconBgColor: AppColors.brandSoft,
      ),
      ActivityItem(
        title: 'Task',
        highlightText: '“API Integration” completed',
        subtitle: 'by Alex Rivera · Sprint 14',
        timeAgo: '8m ago',
        icon: FontAwesomeIcons.circleCheck,
        iconColor: AppColors.success,
        iconBgColor: AppColors.successSoft,
      ),
      ActivityItem(
        title: 'Comment on',
        highlightText: '“Q2 Report”',
        subtitle: 'Jordan Chen · “Numbers look great!”',
        timeAgo: '15m ago',
        icon: FontAwesomeIcons.comment,
        iconColor: AppColors.info,
        iconBgColor: AppColors.infoSoft,
      ),
      ActivityItem(
        title: 'Low stock:',
        highlightText: 'Wireless Earbuds Pro',
        subtitle: 'Only 5 units remaining · Reorder recommended',
        timeAgo: '32m ago',
        icon: FontAwesomeIcons.triangleExclamation,
        iconColor: AppColors.warn,
        iconBgColor: AppColors.warnSoft,
      ),
      ActivityItem(
        title: 'New user registered:',
        highlightText: 'Emma Wilson',
        subtitle: 'Product Manager · Onboarding email sent',
        timeAgo: '1h ago',
        icon: FontAwesomeIcons.user,
        iconColor: Color(0xFF8B5CF6),
        iconBgColor: Color(0xFFEDE9FE),
      ),
      ActivityItem(
        title: 'Payment failed:',
        highlightText: '#ORD-7820',
        subtitle: 'Visa · 4242 · Insufficient funds',
        timeAgo: '2h ago',
        icon: FontAwesomeIcons.creditCard,
        iconColor: AppColors.danger,
        iconBgColor: AppColors.dangerSoft,
      ),
      ActivityItem(
        title: 'Shipment dispatched:',
        highlightText: '#ORD-7815',
        subtitle: 'FedEx · Est. delivery May 7',
        timeAgo: '3h ago',
        icon: FontAwesomeIcons.box,
        iconColor: Color(0xFF14B8A6),
        iconBgColor: Color(0xFFCCFBF1),
      ),
      ActivityItem(
        title: 'Milestone reached:',
        highlightText: 'Q2 \$250K target',
        subtitle: 'Revenue milestone unlocked · Team notified',
        timeAgo: '5h ago',
        icon: FontAwesomeIcons.flagCheckered,
        iconColor: Color(0xFFEC4899),
        iconBgColor: Color(0xFFFCE7F3),
      ),
    ];
  }

  List<TeamMemberItem> getTeamMembers() {
    return const [
      TeamMemberItem(
        name: 'Alex Rivera',
        role: 'Backend Dev',
        avatarUrl: 'https://i.pravatar.cc/64?img=8',
        taskCount: 5,
        isOnline: true,
        statusColor: AppColors.success,
      ),
      TeamMemberItem(
        name: 'Jordan Chen',
        role: 'UI Designer',
        avatarUrl: 'https://i.pravatar.cc/64?img=15',
        taskCount: 3,
        isOnline: true,
        statusColor: AppColors.success,
      ),
      TeamMemberItem(
        name: 'Emma Wilson',
        role: 'Product Manager',
        avatarUrl: 'https://i.pravatar.cc/64?img=22',
        taskCount: 7,
        isOnline: false,
        statusColor: AppColors.warn,
      ),
      TeamMemberItem(
        name: 'Liam Kumar',
        role: 'Data Analyst',
        avatarUrl: 'https://i.pravatar.cc/64?img=33',
        taskCount: 4,
        isOnline: true,
        statusColor: AppColors.success,
      ),
      TeamMemberItem(
        name: 'Priya Nair',
        role: 'DevOps Engineer',
        avatarUrl: 'https://i.pravatar.cc/64?img=47',
        taskCount: 2,
        isOnline: false,
        statusColor: AppColors.lightTextMuted,
      ),
      TeamMemberItem(
        name: 'Marco Rossi',
        role: 'QA Lead',
        avatarUrl: 'https://i.pravatar.cc/64?img=12',
        taskCount: 6,
        isOnline: true,
        statusColor: AppColors.success,
      ),
    ];
  }

  List<TopProductItem> getTopProducts() {
    return const [
      TopProductItem(
        name: 'Wireless Earbuds Pro',
        icon: FontAwesomeIcons.headphones,
        iconGradient: [Color(0xFF5B5BF7), Color(0xFF8B5CF6)],
        category: 'Electronics',
        categoryColor: Color(0xFF5B5BF7),
        categoryBgColor: Color(0xFFEAEAFE),
        unitsSold: '2,840',
        revenue: '\$56,800',
        trend: '22%',
        isTrendUp: true,
        stockPercentage: 0.72,
        stockColor: Color(0xFF5B5BF7),
      ),
      TopProductItem(
        name: 'Lumora Canvas Tote',
        icon: FontAwesomeIcons.bagShopping,
        iconGradient: [Color(0xFFEC4899), Color(0xFFDB2777)],
        category: 'Fashion',
        categoryColor: Color(0xFFEC4899),
        categoryBgColor: Color(0xFFFCE7F3),
        unitsSold: '1,920',
        revenue: '\$28,800',
        trend: '15%',
        isTrendUp: true,
        stockPercentage: 0.45,
        stockColor: Color(0xFFEC4899),
      ),
      TopProductItem(
        name: 'Smart Fitness Band',
        icon: FontAwesomeIcons.dumbbell,
        iconGradient: [Color(0xFF0EA5E9), Color(0xFF0284C7)],
        category: 'Wearables',
        categoryColor: Color(0xFF0EA5E9),
        categoryBgColor: Color(0xFFDDF2FB),
        unitsSold: '1,480',
        revenue: '\$44,400',
        trend: '8%',
        isTrendUp: true,
        stockPercentage: 0.88,
        stockColor: Color(0xFF0EA5E9),
      ),
      TopProductItem(
        name: 'Artisan Coffee Blend',
        icon: FontAwesomeIcons.mugHot,
        iconGradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
        category: 'Food & Bev',
        categoryColor: Color(0xFFF59E0B),
        categoryBgColor: Color(0xFFFEF3DC),
        unitsSold: '3,210',
        revenue: '\$19,260',
        trend: '3%',
        isTrendUp: false,
        stockPercentage: 0.22,
        stockColor: Color(0xFFF59E0B),
      ),
      TopProductItem(
        name: 'Minimalist Notebook',
        icon: FontAwesomeIcons.book,
        iconGradient: [Color(0xFF22C55E), Color(0xFF16A34A)],
        category: 'Stationery',
        categoryColor: Color(0xFF22C55E),
        categoryBgColor: Color(0xFFE4F8EC),
        unitsSold: '890',
        revenue: '\$8,010',
        trend: '41%',
        isTrendUp: true,
        stockPercentage: 0.60,
        stockColor: Color(0xFF22C55E),
      ),
      TopProductItem(
        name: 'Pro Gaming Mouse',
        icon: FontAwesomeIcons.computerMouse,
        iconGradient: [Color(0xFFEF4444), Color(0xFFDC2626)],
        category: 'Electronics',
        categoryColor: Color(0xFFEF4444),
        categoryBgColor: Color(0xFFFDE6E6),
        unitsSold: '680',
        revenue: '\$40,800',
        trend: '29%',
        isTrendUp: true,
        stockPercentage: 0.35,
        stockColor: Color(0xFFEF4444),
      ),
    ];
  }
}
