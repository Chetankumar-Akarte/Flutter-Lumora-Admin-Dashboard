import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/segmented_control.dart';
import '../../viewmodel/register_provider.dart';

enum LegalDocumentType {
  terms('Terms of Service'),
  privacy('Privacy Policy');

  final String label;
  const LegalDocumentType(this.label);
}

class TermsAndPrivacyDialog extends ConsumerStatefulWidget {
  final LegalDocumentType initialDocument;

  const TermsAndPrivacyDialog({
    super.key,
    this.initialDocument = LegalDocumentType.terms,
  });

  static Future<void> show(
    BuildContext context, {
    LegalDocumentType initialDocument = LegalDocumentType.terms,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => TermsAndPrivacyDialog(initialDocument: initialDocument),
    );
  }

  @override
  ConsumerState<TermsAndPrivacyDialog> createState() => _TermsAndPrivacyDialogState();
}

class _TermsAndPrivacyDialogState extends ConsumerState<TermsAndPrivacyDialog> {
  late LegalDocumentType _selectedDoc;

  @override
  void initState() {
    super.initState();
    _selectedDoc = widget.initialDocument;
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
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 640,
          maxHeight: 700,
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.brand.withValues(alpha: 0.12),
                      borderRadius: AppDimensions.rMd,
                    ),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.fileContract,
                        size: 16,
                        color: AppColors.brand,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Legal Information',
                          style: AppTypography.heading(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          'Last updated: September 2026',
                          style: AppTypography.body(
                            fontSize: 12,
                            color: theme.textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
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
            ),

            // Segmented Tab Switcher
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SegmentedControl<LegalDocumentType>(
                  items: LegalDocumentType.values,
                  selectedValue: _selectedDoc,
                  labelBuilder: (doc) => doc.label,
                  onValueChanged: (doc) {
                    setState(() => _selectedDoc = doc);
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),
            Divider(
              height: 1,
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),

            // Document Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: _selectedDoc == LegalDocumentType.terms
                    ? _buildTermsOfService(theme, isDark)
                    : _buildPrivacyPolicy(theme, isDark),
              ),
            ),

            Divider(
              height: 1,
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),

            // Actions Footer
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Lumora Inc. · All rights reserved.',
                      style: AppTypography.body(
                        fontSize: 12,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  AppButton(
                    text: 'Close',
                    variant: AppButtonVariant.outline,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 10),
                  AppButton(
                    text: 'Accept & Agree',
                    variant: AppButtonVariant.primary,
                    onPressed: () {
                      final registerState = ref.read(registerProvider);
                      if (!registerState.agreeToTerms) {
                        ref.read(registerProvider.notifier).toggleAgreeToTerms();
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsOfService(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('1. Acceptance of Terms', theme),
        _buildParagraph(
          'By creating an account or accessing Lumora Admin Dashboard, you agree to be bound by these Terms of Service. If you do not agree to all terms and conditions, you must not access or use our services.',
          theme,
        ),
        const SizedBox(height: 18),

        _buildSectionTitle('2. User Accounts & Workspace Security', theme),
        _buildParagraph(
          'You are responsible for safeguarding the credentials used to access your workspace. You agree not to disclose your password to any third party. You must notify us immediately upon becoming aware of any breach of security or unauthorized use of your account.',
          theme,
        ),
        const SizedBox(height: 18),

        _buildSectionTitle('3. 14-Day Free Trial & Subscriptions', theme),
        _buildParagraph(
          'Your Lumora workspace begins with an unrestricted 14-day free trial. No credit card is required to begin. You may cancel your subscription at any time prior to the trial expiration without incurring charges.',
          theme,
        ),
        const SizedBox(height: 18),

        _buildSectionTitle('4. Acceptable Use Policy', theme),
        _buildParagraph(
          'You agree not to misuse the Lumora services or assist anyone else in doing so. This includes attempting to disrupt service integrity, probe network vulnerabilities, or transmit unauthorized automated queries.',
          theme,
        ),
        const SizedBox(height: 18),

        _buildSectionTitle('5. Limitation of Liability', theme),
        _buildParagraph(
          'To the fullest extent permitted by applicable law, Lumora and its affiliates shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use of the platform.',
          theme,
        ),
      ],
    );
  }

  Widget _buildPrivacyPolicy(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('1. Information We Collect', theme),
        _buildParagraph(
          'We collect information you provide directly to us when creating your account, including your full name, work email address, organization name, and authentication credentials. We also automatically collect telemetry and performance diagnostics.',
          theme,
        ),
        const SizedBox(height: 18),

        _buildSectionTitle('2. How We Protect Your Data', theme),
        _buildParagraph(
          'Lumora enforces end-to-end TLS 1.3 encryption in transit and AES-256 encryption at rest. We adhere to strict role-based access control (RBAC) protocols and perform regular third-party security audits.',
          theme,
        ),
        const SizedBox(height: 18),

        _buildSectionTitle('3. Data Sharing & Third Parties', theme),
        _buildParagraph(
          'We never sell, rent, or trade your personal data with third-party advertisers. Information is only shared with trusted infrastructure providers (such as cloud hosting and transaction services) under strict confidentiality agreements.',
          theme,
        ),
        const SizedBox(height: 18),

        _buildSectionTitle('4. Your Rights & Data Portability', theme),
        _buildParagraph(
          'You have full control over your data. You may request a complete export of your workspace records, update your preferences, or permanently delete your account and associated assets at any time.',
          theme,
        ),
        const SizedBox(height: 18),

        _buildSectionTitle('5. Cookies & Local Storage', theme),
        _buildParagraph(
          'We use essential cookies and session tokens strictly necessary for secure authentication and remembering your theme preferences across sessions.',
          theme,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: AppTypography.heading(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text, ThemeData theme) {
    return Text(
      text,
      style: AppTypography.body(
        fontSize: 13,
        color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.85),
      ).copyWith(height: 1.6),
    );
  }
}
