import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AvatarBadge extends StatelessWidget {
  final String imageUrl;
  final double size;
  final bool isOnline;
  final Color? statusColor;

  const AvatarBadge({
    super.key,
    required this.imageUrl,
    this.size = 36.0,
    this.isOnline = false,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indicatorColor = statusColor ?? AppColors.success;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: Image.network(
            imageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, size: size * 0.6, color: theme.colorScheme.onSurface),
            ),
          ),
        ),
        if (isOnline || statusColor != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size * 0.28,
              height: size * 0.28,
              decoration: BoxDecoration(
                color: indicatorColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colorScheme.surface,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
