import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_typography.dart';
import 'dashed_border_container.dart';

enum AppButtonVariant { primary, outline, soft, ghost }

enum AppButtonSize { sm, md, lg }

class AppButton extends StatefulWidget {
  final String text;
  final Widget? icon;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool fullWidth;

  const AppButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.fullWidth = false,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final fontSize = switch (widget.size) {
      AppButtonSize.sm => 12.0,
      AppButtonSize.md => 13.0,
      AppButtonSize.lg => 14.0,
    };

    final padding = switch (widget.size) {
      AppButtonSize.sm => const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      AppButtonSize.md => const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      AppButtonSize.lg => const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    };

    Color bgColor = Colors.transparent;
    Color fgColor = theme.colorScheme.onSurface;
    BorderSide borderSide = BorderSide.none;

    switch (widget.variant) {
      case AppButtonVariant.primary:
        bgColor = _isHovered
            ? (isDark ? AppColors.brandDark : AppColors.brandHover)
            : (isDark ? AppColors.brandDark : AppColors.brand);
        fgColor = Colors.white;
        break;
      case AppButtonVariant.outline:
        bgColor = _isHovered
            ? (isDark ? AppColors.darkSurface2 : AppColors.lightSurface2)
            : Colors.transparent;
        fgColor = theme.colorScheme.onSurface;
        borderSide = BorderSide(
          color: _isHovered
              ? (_isDarkOrLightBorder(isDark, theme))
              : theme.colorScheme.outline,
        );
        break;
      case AppButtonVariant.soft:
        bgColor = _isHovered
            ? (isDark ? AppColors.brandDark : AppColors.brand)
            : (isDark ? AppColors.brandDarkSoft : AppColors.brandSoft);
        fgColor = _isHovered
            ? Colors.white
            : (isDark ? AppColors.brandDark : AppColors.brand);
        break;
      case AppButtonVariant.ghost:
        bgColor = _isHovered
            ? (isDark
                ? AppColors.darkSurface2.withValues(alpha: 0.6)
                : AppColors.lightSurface2.withValues(alpha: 0.9))
            : Colors.transparent;
        fgColor = _isHovered
            ? theme.colorScheme.onSurface
            : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted);
        break;
    }

    // Animated icon with subtle nudge on hover
    Widget iconContent = widget.icon ?? const SizedBox.shrink();
    if (widget.icon != null) {
      iconContent = AnimatedSlide(
        offset: _isHovered ? const Offset(0.18, 0) : Offset.zero,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        child: AnimatedTheme(
          data: theme,
          child: widget.icon!,
        ),
      );
    }

    Widget content = Row(
      mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: AppTypography.heading(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: fgColor,
          ),
          child: Text(widget.text),
        ),
        if (widget.icon != null) ...[
          const SizedBox(width: 6),
          iconContent,
        ],
      ],
    );

    // Ghost Variant with Polished Hover Darker Dashed Border & Micro-Animation
    if (widget.variant == AppButtonVariant.ghost) {
      final dashedBorderColor = _isHovered
          ? (isDark ? Colors.white70 : theme.colorScheme.onSurface.withValues(alpha: 0.85))
          : (isDark ? AppColors.darkBorder : theme.colorScheme.outline.withValues(alpha: 0.75));

      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: widget.onPressed,
          child: AnimatedScale(
            scale: _isPressed ? 0.97 : (_isHovered ? 1.02 : 1.0),
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOutQuad,
            child: TweenAnimationBuilder<Color?>(
              tween: ColorTween(begin: dashedBorderColor, end: dashedBorderColor),
              duration: const Duration(milliseconds: 180),
              builder: (context, animatedColor, child) {
                return CustomPaint(
                  painter: DashedBorderPainter(
                    color: animatedColor ?? dashedBorderColor,
                    borderRadius: 8.0,
                    dashWidth: 4.0,
                    dashSpace: 3.0,
                    strokeWidth: _isHovered ? 1.2 : 1.0,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutQuad,
                    padding: padding,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: AppDimensions.rMd,
                    ),
                    child: content,
                  ),
                );
              },
            ),
          ),
        ),
      );
    }

    // Standard Variants (Primary, Outline, Soft)
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onPressed,
        child: AnimatedScale(
          scale: _isPressed ? 0.97 : (_isHovered ? 1.01 : 1.0),
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOutQuad,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutQuad,
            padding: padding,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: AppDimensions.rMd,
              border: borderSide != BorderSide.none ? Border.fromBorderSide(borderSide) : null,
              boxShadow: (_isHovered && widget.variant == AppButtonVariant.primary)
                  ? [
                      BoxShadow(
                        color: (isDark ? AppColors.brandDark : AppColors.brand).withValues(alpha: 0.28),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: content,
          ),
        ),
      ),
    );
  }

  Color _isDarkOrLightBorder(bool isDark, ThemeData theme) {
    return isDark ? Colors.white60 : theme.colorScheme.onSurface.withValues(alpha: 0.6);
  }
}
