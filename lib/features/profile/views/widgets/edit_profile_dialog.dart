import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../models/profile_model.dart';
import '../../viewmodel/profile_provider.dart';

class EditProfileDialog extends ConsumerStatefulWidget {
  final UserProfile profile;

  const EditProfileDialog({
    super.key,
    required this.profile,
  });

  static Future<void> show(BuildContext context, UserProfile profile) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => EditProfileDialog(profile: profile),
    );
  }

  @override
  ConsumerState<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends ConsumerState<EditProfileDialog> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _titleController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.profile.firstName);
    _lastNameController = TextEditingController(text: widget.profile.lastName);
    _titleController = TextEditingController(text: widget.profile.title);
    _bioController = TextEditingController(text: widget.profile.bio);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _titleController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      shape: RoundedRectangleBorder(
        borderRadius: AppDimensions.rLg,
        side: BorderSide(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 540),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit Profile',
                      style: AppTypography.heading(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                      color: theme.textTheme.bodySmall?.color,
                      splashRadius: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(
                  height: 1,
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
                const SizedBox(height: 20),

                // Form Fields
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'First Name',
                        controller: _firstNameController,
                        isDark: isDark,
                        theme: theme,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildTextField(
                        label: 'Last Name',
                        controller: _lastNameController,
                        isDark: isDark,
                        theme: theme,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Title',
                  controller: _titleController,
                  isDark: isDark,
                  theme: theme,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Bio',
                  controller: _bioController,
                  maxLines: 4,
                  hintText: 'Tell us about yourself...',
                  isDark: isDark,
                  theme: theme,
                ),
                const SizedBox(height: 24),

                // Footer Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButton(
                      text: 'Cancel',
                      variant: AppButtonVariant.outline,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 10),
                    AppButton(
                      text: 'Save Changes',
                      variant: AppButtonVariant.primary,
                      onPressed: () {
                        ref.read(profileProvider.notifier).updateProfile(
                              firstName: _firstNameController.text.trim(),
                              lastName: _lastNameController.text.trim(),
                              title: _titleController.text.trim(),
                              bio: _bioController.text.trim(),
                            );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Profile updated successfully!'),
                            backgroundColor: AppColors.success,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: AppDimensions.rMd,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required bool isDark,
    required ThemeData theme,
    int maxLines = 1,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.heading(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: AppTypography.body(
            fontSize: 14,
            color: theme.colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTypography.body(
              fontSize: 13,
              color: isDark ? AppColors.darkTextSoft : AppColors.lightTextSoft,
            ),
            filled: true,
            fillColor: isDark ? AppColors.darkSurface2 : AppColors.lightSurface2,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: AppDimensions.rMd,
              borderSide: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppDimensions.rMd,
              borderSide: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppDimensions.rMd,
              borderSide: BorderSide(
                color: isDark ? AppColors.brandDark : AppColors.brand,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
