import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/widgets/status_badge.dart';

class KpiMetric {
  final String title;
  final String value;
  final double changePercentage;
  final bool isPositive;
  final FaIconData icon;
  final List<Color> gradientColors;
  final List<double> sparklineData;

  const KpiMetric({
    required this.title,
    required this.value,
    required this.changePercentage,
    required this.isPositive,
    required this.icon,
    required this.gradientColors,
    required this.sparklineData,
  });
}

class VisitSalesPoint {
  final String label;
  final double visits;
  final double sales;

  const VisitSalesPoint({
    required this.label,
    required this.visits,
    required this.sales,
  });
}

class TrafficSourceItem {
  final String label;
  final double percentage;
  final Color color;

  const TrafficSourceItem({
    required this.label,
    required this.percentage,
    required this.color,
  });
}

class WeeklyStatItem {
  final String label;
  final String value;
  final String trend;
  final bool isUp;
  final String subLabel;
  final FaIconData icon;
  final Color iconColor;
  final Color iconBgColor;

  const WeeklyStatItem({
    required this.label,
    required this.value,
    required this.trend,
    required this.isUp,
    required this.subLabel,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
  });
}

class GoalItem {
  final String title;
  final String currentFormatted;
  final String targetFormatted;
  final double percentage;
  final FaIconData icon;
  final Color color;
  final List<Color> gradient;

  const GoalItem({
    required this.title,
    required this.currentFormatted,
    required this.targetFormatted,
    required this.percentage,
    required this.icon,
    required this.color,
    required this.gradient,
  });
}

class ChannelSalesItem {
  final String channelName;
  final String amount;
  final String percentageChange;
  final bool isPositive;
  final double progress;
  final FaIconData icon;
  final Color iconColor;
  final List<Color> gradient;

  const ChannelSalesItem({
    required this.channelName,
    required this.amount,
    required this.percentageChange,
    required this.isPositive,
    required this.progress,
    required this.icon,
    required this.iconColor,
    required this.gradient,
  });
}

class RecentOrderItem {
  final String userName;
  final String userAvatar;
  final String subject;
  final OrderStatus status;
  final String date;
  final String trackingId;

  const RecentOrderItem({
    required this.userName,
    required this.userAvatar,
    required this.subject,
    required this.status,
    required this.date,
    required this.trackingId,
  });
}

class ActivityItem {
  final String title;
  final String highlightText;
  final String subtitle;
  final String timeAgo;
  final FaIconData icon;
  final Color iconColor;
  final Color iconBgColor;

  const ActivityItem({
    required this.title,
    required this.highlightText,
    required this.subtitle,
    required this.timeAgo,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
  });
}

class TeamMemberItem {
  final String name;
  final String role;
  final String avatarUrl;
  final int taskCount;
  final bool isOnline;
  final Color statusColor;

  const TeamMemberItem({
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.taskCount,
    required this.isOnline,
    required this.statusColor,
  });
}

class TopProductItem {
  final String name;
  final FaIconData icon;
  final List<Color> iconGradient;
  final String category;
  final Color categoryColor;
  final Color categoryBgColor;
  final String unitsSold;
  final String revenue;
  final String trend;
  final bool isTrendUp;
  final double stockPercentage;
  final Color stockColor;

  const TopProductItem({
    required this.name,
    required this.icon,
    required this.iconGradient,
    required this.category,
    required this.categoryColor,
    required this.categoryBgColor,
    required this.unitsSold,
    required this.revenue,
    required this.trend,
    required this.isTrendUp,
    required this.stockPercentage,
    required this.stockColor,
  });
}
