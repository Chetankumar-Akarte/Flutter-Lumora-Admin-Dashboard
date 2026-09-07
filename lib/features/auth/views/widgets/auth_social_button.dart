import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';

enum AuthSocialType { google, apple, github }

class AuthSocialButton extends StatefulWidget {
  final AuthSocialType type;
  final VoidCallback? onPressed;

  const AuthSocialButton({
    super.key,
    required this.type,
    this.onPressed,
  });

  @override
  State<AuthSocialButton> createState() => _AuthSocialButtonState();
}

class _AuthSocialButtonState extends State<AuthSocialButton> {
  bool _isHovered = false;

  FaIconData get _icon {
    switch (widget.type) {
      case AuthSocialType.google:
        return FontAwesomeIcons.google;
      case AuthSocialType.apple:
        return FontAwesomeIcons.apple;
      case AuthSocialType.github:
        return FontAwesomeIcons.github;
    }
  }

  String get _label {
    switch (widget.type) {
      case AuthSocialType.google:
        return 'Google';
      case AuthSocialType.apple:
        return 'Apple';
      case AuthSocialType.github:
        return 'GitHub';
    }
  }

  Color _getIconColor(ThemeData theme) {
    switch (widget.type) {
      case AuthSocialType.google:
        return const Color(0xFFDB4437);
      case AuthSocialType.apple:
      case AuthSocialType.github:
        return theme.colorScheme.onSurface;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final baseBg = isDark ? const Color(0xFF1E2230) : Colors.white;
    final hoverBg = isDark ? const Color(0xFF262C3D) : const Color(0xFFF3F4F6);
    final borderColor = isDark ? const Color(0xFF2E3447) : const Color(0xFFE5E7EB);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 44,
        decoration: BoxDecoration(
          color: _isHovered ? hoverBg : baseBg,
          borderRadius: AppDimensions.rMd,
          border: Border.all(
            color: _isHovered ? theme.colorScheme.primary.withValues(alpha: 0.4) : borderColor,
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: AppDimensions.rMd,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                _icon,
                size: 15,
                color: _getIconColor(theme),
              ),
              const SizedBox(width: 8),
              Text(
                _label,
                style: AppTypography.heading(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
