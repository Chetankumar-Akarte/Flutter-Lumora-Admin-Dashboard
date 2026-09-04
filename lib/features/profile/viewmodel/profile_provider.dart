import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/profile_model.dart';

class ProfileNotifier extends StateNotifier<UserProfile> {
  ProfileNotifier() : super(_initialProfile);

  static final UserProfile _initialProfile = UserProfile(
    firstName: 'Chetankumar',
    lastName: 'Akarte',
    title: 'Senior Solution Architect - Flutter Expert',
    bio:
        'Seasoned Software Architect specializing in Flutter, Dart, and Mobile solutions. Author of "The Flutter Foundation" book. Created Shabdakosh app with 1M+ downloads. Passionate about mentoring and open-source contributions.',
    avatarUrl: 'https://avatars.githubusercontent.com/u/27378345?v=4',
    joinedDate: 'Feb 1, 2018',
    lastActive: '1 hour ago',
    location: 'Nagpur, India',
    isVerified: true,
    roleBadge: 'Senior Solution Architect',
    contactInfo: const ContactInfo(
      email: 'chetan.akarte@gmail.com',
      phone: '+91 (98) 2345-6789',
      department: 'Architecture & Solutions',
      organization: 'Renuka Technologies',
      location: 'Nagpur, India',
      timezone: 'IST (UTC+5:30)',
    ),
    stats: const [
      MetricStat(value: '50+', label: 'Projects'),
      MetricStat(value: '1M+', label: 'App Downloads'),
      MetricStat(value: '18+', label: 'Years Experience'),
      MetricStat(value: '4.9', label: 'Rating'),
    ],
    permissions: const [
      PermissionChipData(
        icon: FontAwesomeIcons.mobileScreen,
        label: 'Mobile Architecture',
      ),
      PermissionChipData(
        icon: FontAwesomeIcons.code,
        label: 'Flutter Expertise',
      ),
      PermissionChipData(
        icon: FontAwesomeIcons.cube,
        label: 'Software Design',
      ),
      PermissionChipData(
        icon: FontAwesomeIcons.graduationCap,
        label: 'Mentoring',
      ),
      PermissionChipData(
        icon: FontAwesomeIcons.book,
        label: 'Tech Authoring',
      ),
      PermissionChipData(
        icon: FontAwesomeIcons.github,
        label: 'Open Source',
      ),
    ],
    activities: const [
      ActivityItemData(
        time: 'Today at 2:14 PM',
        prefix: 'Reviewed ',
        highlight: 'Flutter Architecture',
        suffix: ' for Shabdakosh app',
        isActive: true,
      ),
      ActivityItemData(
        time: 'Yesterday at 10:30 AM',
        prefix: 'Completed ',
        highlight: 'Flutter Foundation',
        suffix: ' book documentation',
      ),
      ActivityItemData(
        time: '2 days ago',
        prefix: 'Contributed ',
        highlight: 'XTools Flutter Package',
        suffix: ' to open source',
      ),
      ActivityItemData(
        time: '5 days ago',
        prefix: 'Mentored team on ',
        highlight: 'Mobile Architecture Best Practices',
        suffix: '',
      ),
    ],
    securitySettings: const SecuritySettingsData(
      twoFactorActive: true,
      activeSessions: 1,
      passwordLastUpdated: '2 months ago',
      loginAlertsEnabled: true,
      activeApiKeys: 2,
    ),
  );

  void updateProfile({
    required String firstName,
    required String lastName,
    required String title,
    required String bio,
  }) {
    state = state.copyWith(
      firstName: firstName,
      lastName: lastName,
      title: title,
      bio: bio,
    );
  }

  void updateContactInfo({
    required String email,
    required String phone,
    required String department,
    required String organization,
    required String location,
    required String timezone,
  }) {
    state = state.copyWith(
      contactInfo: state.contactInfo.copyWith(
        email: email,
        phone: phone,
        department: department,
        organization: organization,
        location: location,
        timezone: timezone,
      ),
      location: location,
    );
  }

  void toggleLoginAlerts(bool value) {
    state = state.copyWith(
      securitySettings: state.securitySettings.copyWith(
        loginAlertsEnabled: value,
      ),
    );
  }
}

final profileProvider =
    StateNotifierProvider<ProfileNotifier, UserProfile>((ref) {
  return ProfileNotifier();
});
