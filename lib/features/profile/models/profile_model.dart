import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Data models for the Lumora Admin Profile screen
class UserProfile {
  final String firstName;
  final String lastName;
  final String title;
  final String bio;
  final String avatarUrl;
  final String joinedDate;
  final String lastActive;
  final String location;
  final bool isVerified;
  final String roleBadge;
  final ContactInfo contactInfo;
  final List<MetricStat> stats;
  final List<PermissionChipData> permissions;
  final List<ActivityItemData> activities;
  final SecuritySettingsData securitySettings;

  const UserProfile({
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.bio,
    required this.avatarUrl,
    required this.joinedDate,
    required this.lastActive,
    required this.location,
    required this.isVerified,
    required this.roleBadge,
    required this.contactInfo,
    required this.stats,
    required this.permissions,
    required this.activities,
    required this.securitySettings,
  });

  String get fullName => '$firstName $lastName';

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    String? title,
    String? bio,
    String? avatarUrl,
    String? joinedDate,
    String? lastActive,
    String? location,
    bool? isVerified,
    String? roleBadge,
    ContactInfo? contactInfo,
    List<MetricStat>? stats,
    List<PermissionChipData>? permissions,
    List<ActivityItemData>? activities,
    SecuritySettingsData? securitySettings,
  }) {
    return UserProfile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      title: title ?? this.title,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      joinedDate: joinedDate ?? this.joinedDate,
      lastActive: lastActive ?? this.lastActive,
      location: location ?? this.location,
      isVerified: isVerified ?? this.isVerified,
      roleBadge: roleBadge ?? this.roleBadge,
      contactInfo: contactInfo ?? this.contactInfo,
      stats: stats ?? this.stats,
      permissions: permissions ?? this.permissions,
      activities: activities ?? this.activities,
      securitySettings: securitySettings ?? this.securitySettings,
    );
  }
}

class ContactInfo {
  final String email;
  final String phone;
  final String department;
  final String organization;
  final String location;
  final String timezone;

  const ContactInfo({
    required this.email,
    required this.phone,
    required this.department,
    required this.organization,
    required this.location,
    required this.timezone,
  });

  ContactInfo copyWith({
    String? email,
    String? phone,
    String? department,
    String? organization,
    String? location,
    String? timezone,
  }) {
    return ContactInfo(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      department: department ?? this.department,
      organization: organization ?? this.organization,
      location: location ?? this.location,
      timezone: timezone ?? this.timezone,
    );
  }
}

class MetricStat {
  final String value;
  final String label;

  const MetricStat({
    required this.value,
    required this.label,
  });
}

class PermissionChipData {
  final FaIconData icon;
  final String label;

  const PermissionChipData({
    required this.icon,
    required this.label,
  });
}

class ActivityItemData {
  final String time;
  final String prefix;
  final String highlight;
  final String suffix;
  final bool isActive;

  const ActivityItemData({
    required this.time,
    required this.prefix,
    required this.highlight,
    required this.suffix,
    this.isActive = false,
  });
}

class SecuritySettingsData {
  final bool twoFactorActive;
  final int activeSessions;
  final String passwordLastUpdated;
  final bool loginAlertsEnabled;
  final int activeApiKeys;

  const SecuritySettingsData({
    required this.twoFactorActive,
    required this.activeSessions,
    required this.passwordLastUpdated,
    required this.loginAlertsEnabled,
    required this.activeApiKeys,
  });

  SecuritySettingsData copyWith({
    bool? twoFactorActive,
    int? activeSessions,
    String? passwordLastUpdated,
    bool? loginAlertsEnabled,
    int? activeApiKeys,
  }) {
    return SecuritySettingsData(
      twoFactorActive: twoFactorActive ?? this.twoFactorActive,
      activeSessions: activeSessions ?? this.activeSessions,
      passwordLastUpdated: passwordLastUpdated ?? this.passwordLastUpdated,
      loginAlertsEnabled: loginAlertsEnabled ?? this.loginAlertsEnabled,
      activeApiKeys: activeApiKeys ?? this.activeApiKeys,
    );
  }
}
