import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../models/profile_model.dart';
import '../../viewmodel/profile_provider.dart';

class EditContactDialog extends ConsumerStatefulWidget {
  final ContactInfo contactInfo;

  const EditContactDialog({
    super.key,
    required this.contactInfo,
  });

  static Future<void> show(BuildContext context, ContactInfo contactInfo) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => EditContactDialog(contactInfo: contactInfo),
    );
  }

  @override
  ConsumerState<EditContactDialog> createState() => _EditContactDialogState();
}

class _EditContactDialogState extends ConsumerState<EditContactDialog> {
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _departmentController;
  late final TextEditingController _organizationController;
  late final TextEditingController _locationController;
  late final TextEditingController _timezoneController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.contactInfo.email);
    _phoneController = TextEditingController(text: widget.contactInfo.phone);
    _departmentController = TextEditingController(text: widget.contactInfo.department);
    _organizationController = TextEditingController(text: widget.contactInfo.organization);
    _locationController = TextEditingController(text: widget.contactInfo.location);
    _timezoneController = TextEditingController(text: widget.contactInfo.timezone);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _departmentController.dispose();
    _organizationController.dispose();
    _locationController.dispose();
    _timezoneController.dispose();
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
                      'Edit Contact Information',
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

                // Form Fields Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Email',
                        controller: _emailController,
                        isDark: isDark,
                        theme: theme,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildTextField(
                        label: 'Phone',
                        controller: _phoneController,
                        isDark: isDark,
                        theme: theme,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Department',
                        controller: _departmentController,
                        isDark: isDark,
                        theme: theme,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildTextField(
                        label: 'Organization',
                        controller: _organizationController,
                        isDark: isDark,
                        theme: theme,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Location',
                        controller: _locationController,
                        isDark: isDark,
                        theme: theme,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildTextField(
                        label: 'Timezone',
                        controller: _timezoneController,
                        isDark: isDark,
                        theme: theme,
                      ),
                    ),
                  ],
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
                        ref.read(profileProvider.notifier).updateContactInfo(
                              email: _emailController.text.trim(),
                              phone: _phoneController.text.trim(),
                              department: _departmentController.text.trim(),
                              organization: _organizationController.text.trim(),
                              location: _locationController.text.trim(),
                              timezone: _timezoneController.text.trim(),
                            );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Contact information updated!'),
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
          style: AppTypography.body(
            fontSize: 14,
            color: theme.colorScheme.onSurface,
          ),
          decoration: InputDecoration(
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
