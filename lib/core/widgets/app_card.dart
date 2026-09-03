import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_typography.dart';

class AppCard extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? subtitle;
  final Widget? headerAction;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? headerPadding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Border? border;
  final bool showDivider;

  const AppCard({
    super.key,
    this.child,
    this.title,
    this.subtitle,
    this.headerAction,
    this.padding,
    this.headerPadding,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardBorder = border ?? Border.all(color: theme.colorScheme.outline);
    final cardBg = backgroundColor ?? theme.cardTheme.color ?? theme.colorScheme.surface;
    final radius = borderRadius ?? AppDimensions.rLg;

    final hasHeader = title != null || headerAction != null;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: radius,
        border: cardBorder,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: theme.brightness == Brightness.dark ? 0.25 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasHeader) ...[
            Padding(
              padding: headerPadding ?? const EdgeInsets.fromLTRB(20, 18, 20, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null)
                          Text(
                            title!,
                            style: AppTypography.heading(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 3),
                          Text(
                            subtitle!,
                            style: AppTypography.body(
                              fontSize: 12,
                              color: theme.textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  ?headerAction,
                ],
              ),
            ),
            if (showDivider)
              Divider(height: 1, color: theme.colorScheme.outline),
          ],
          if (child case final c?)
            Padding(
              padding: padding ?? const EdgeInsets.all(20),
              child: c,
            ),
        ],
      ),
    );
  }
}
