import 'package:flutter/material.dart';

class SparklinePainter extends CustomPainter {
  final List<double> dataPoints;
  final Color lineColor;
  final Color fillColor;
  final double strokeWidth;

  SparklinePainter({
    required this.dataPoints,
    this.lineColor = const Color(0xD9FFFFFF),
    this.fillColor = const Color(0x33FFFFFF),
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (dataPoints.length < 2) return;

    final width = size.width;
    final height = size.height;

    final minY = dataPoints.reduce((a, b) => a < b ? a : b);
    final maxY = dataPoints.reduce((a, b) => a > b ? a : b);
    final rangeY = (maxY - minY) == 0 ? 1.0 : (maxY - minY);

    final points = <Offset>[];
    final stepX = width / (dataPoints.length - 1);

    for (int i = 0; i < dataPoints.length; i++) {
      final x = i * stepX;
      // Invert Y so highest value is at top (y = 0) with padding
      final normalizedY = (dataPoints[i] - minY) / rangeY;
      final y = height - (normalizedY * (height - 8)) - 4;
      points.add(Offset(x, y));
    }

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlPointX = (p0.dx + p1.dx) / 2;
      path.cubicTo(
        controlPointX,
        p0.dy,
        controlPointX,
        p1.dy,
        p1.dx,
        p1.dy,
      );
    }

    // Fill Path
    final fillPath = Path.from(path);
    fillPath.lineTo(points.last.dx, height);
    fillPath.lineTo(0, height);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          fillColor,
          fillColor.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, width, height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // Stroke Paint
    final strokePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant SparklinePainter oldDelegate) {
    return oldDelegate.dataPoints != dataPoints ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.fillColor != fillColor;
  }
}
