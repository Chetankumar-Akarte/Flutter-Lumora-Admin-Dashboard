import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_typography.dart';

class AuthHeroFeatureItem {
  final FaIconData icon;
  final String label;

  const AuthHeroFeatureItem({
    required this.icon,
    required this.label,
  });
}

class AuthHeroSection extends StatelessWidget {
  final VoidCallback? onBrandTap;
  final FaIconData eyebrowIcon;
  final String eyebrowText;
  final String title;
  final String subtitle;
  final List<AuthHeroFeatureItem> features;

  const AuthHeroSection({
    super.key,
    this.onBrandTap,
    this.eyebrowIcon = FontAwesomeIcons.wandMagicSparkles,
    this.eyebrowText = 'WELCOME BACK',
    this.title = 'Run your business,\nbeautifully.',
    this.subtitle =
        'Lumora gives you a complete admin toolkit — analytics, orders, users and apps — in one calm, fast interface designed for teams who care about craft.',
    this.features = const [
      AuthHeroFeatureItem(
        icon: FontAwesomeIcons.bolt,
        label: 'Lightning-fast\nresponsive shell',
      ),
      AuthHeroFeatureItem(
        icon: FontAwesomeIcons.shieldHalved,
        label: 'Secure\nauthentication',
      ),
      AuthHeroFeatureItem(
        icon: FontAwesomeIcons.chartPie,
        label: 'Real-time\ninsights',
      ),
      AuthHeroFeatureItem(
        icon: FontAwesomeIcons.palette,
        label: 'Light & dark\ntheming',
      ),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0E1116),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0E1116),
            Color(0xFF151924),
            Color(0xFF1B1F2C),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Ambient Glow Top-Right
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF5B5BF7).withValues(alpha: 0.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Ambient Glow Bottom-Left
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFA855F7).withValues(alpha: 0.16),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Subtle Grid Pattern Overlay
          Positioned.fill(
            child: CustomPaint(
              painter: _AuthGridPatternPainter(),
            ),
          ),

          // Content Area
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Brand Header
                  InkWell(
                    onTap: onBrandTap,
                    borderRadius: AppDimensions.rMd,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF5B5BF7), Color(0xFFA855F7)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: AppDimensions.rMd,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF5B5BF7).withValues(alpha: 0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'L',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Text(
                            'Lumora',
                            style: AppTypography.heading(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Center Hero Body
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Eyebrow Pill
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06),
                            borderRadius: AppDimensions.rPill,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.15),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FaIcon(
                                eyebrowIcon,
                                size: 11,
                                color: Colors.white.withValues(alpha: 0.85),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                eyebrowText,
                                style: AppTypography.heading(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                  color: Colors.white.withValues(alpha: 0.85),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Title
                        Text(
                          title,
                          style: AppTypography.heading(
                            fontSize: 38,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.8,
                          ).copyWith(height: 1.15),
                        ),
                        const SizedBox(height: 16),

                        // Subtitle
                        Text(
                          subtitle,
                          style: AppTypography.body(
                            fontSize: 15,
                            color: Colors.white.withValues(alpha: 0.72),
                          ).copyWith(height: 1.6),
                        ),
                        const SizedBox(height: 32),

                        // Features Grid (up to 4 items in 2x2)
                        if (features.isNotEmpty) ...[
                          Row(
                            children: [
                              if (features.isNotEmpty)
                                Expanded(
                                  child: _buildFeatureItem(
                                    icon: features[0].icon,
                                    label: features[0].label,
                                  ),
                                ),
                              const SizedBox(width: 20),
                              if (features.length > 1)
                                Expanded(
                                  child: _buildFeatureItem(
                                    icon: features[1].icon,
                                    label: features[1].label,
                                  ),
                                ),
                            ],
                          ),
                          if (features.length > 2) ...[
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildFeatureItem(
                                    icon: features[2].icon,
                                    label: features[2].label,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                if (features.length > 3)
                                  Expanded(
                                    child: _buildFeatureItem(
                                      icon: features[3].icon,
                                      label: features[3].label,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ],
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Bottom Foot
                  Text(
                    '© 2026 Lumora. All rights reserved.',
                    style: AppTypography.body(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.45),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required FaIconData icon,
    required String label,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFF5B5BF7).withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: FaIcon(
              icon,
              size: 13,
              color: const Color(0xFFC7C7FF),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: AppTypography.body(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.88),
            ).copyWith(height: 1.35),
          ),
        ),
      ],
    );
  }
}

class _AuthGridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.035)
      ..strokeWidth = 1.0;

    const double step = 44.0;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
