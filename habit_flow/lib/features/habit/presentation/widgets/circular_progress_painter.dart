import 'dart:math';

import 'package:flutter/material.dart';

class CircularProgressPainter extends CustomPainter {
  final double percentage; // 0.0 to 1.0
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;

  CircularProgressPainter({
    required this.percentage,
    required this.backgroundColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: Implement painting logic
    // 1. Define center and radius
    // 2. Draw background circle (drawCircle or drawArc)
    // 3. Draw progress arc (drawArc)
    //    - Start angle: -pi / 2 (top)
    //    - Sweep angle: 2 * pi * percentage
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    const startAngle = -pi / 2;
    final sweepAngle = 2 * pi * percentage;
    final paint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, paint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CircularProgressPainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor;
  }
}
