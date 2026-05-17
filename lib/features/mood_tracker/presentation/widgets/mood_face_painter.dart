import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../domain/mood.dart';

class MoodFacePainter extends CustomPainter {
  final Mood mood;
  final double animationValue; // 0.0 (rest) → 1.0 (peak animation)
  // final Color accent;

  MoodFacePainter({
    required this.mood,
    // required this.accent,
    this.animationValue = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 4;

    // A subtle scale pulse during animation — face grows ~10% then settles.
    final scale = 1.0 + 0.1 * math.sin(animationValue * math.pi);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scale);
    canvas.translate(-center.dx, -center.dy);

    _drawFaceBackground(canvas, center, radius);
    _drawEyes(canvas, center, radius);
    _drawEyebrows(canvas, center, radius);
    _drawMouth(canvas, center, radius);

    canvas.restore();
  }

  void _drawFaceBackground(Canvas canvas, Offset center, double radius) {
    final theme = mood.theme;
    final fill = Paint()
      ..color = theme.faceFill
      ..style = PaintingStyle.fill;
    final stroke = Paint()
      ..color = theme.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawCircle(center, radius, fill);
    canvas.drawCircle(center, radius, stroke);
  }

  void _drawEyes(Canvas canvas, Offset center, double radius) {
    final eyePaint = Paint()..color = const Color(0xFF2D2D2D);
    final eyeOffsetX = radius * 0.35;
    final eyeOffsetY = radius * 0.25;
    final eyeRadius = radius * 0.1;

    final leftEye  = Offset(center.dx - eyeOffsetX, center.dy - eyeOffsetY);
    final rightEye = Offset(center.dx + eyeOffsetX, center.dy - eyeOffsetY);

    if (mood == Mood.happy) {
      // Happy eyes are arcs curving upward (^ ^ shape).
      final arcPaint = Paint()
        ..color = const Color(0xFF2D2D2D)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..strokeCap = StrokeCap.round;

      for (final eye in [leftEye, rightEye]) {
        final rect = Rect.fromCenter(
          center: eye,
          width: eyeRadius * 2.5,
          height: eyeRadius * 2.5,
        );
        // Arc from pi (left) to 2*pi (right) = top half of circle, curving up.
        canvas.drawArc(rect, math.pi, math.pi, false, arcPaint);
      }
    } else {
      // Neutral and sad use solid round eyes.
      canvas.drawCircle(leftEye, eyeRadius, eyePaint);
      canvas.drawCircle(rightEye, eyeRadius, eyePaint);
    }
  }

  void _drawEyebrows(Canvas canvas, Offset center, double radius) {
    if (mood == Mood.neutral) return; // neutral has no eyebrows

    final browPaint = Paint()
      ..color = const Color(0xFF2D2D2D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    final browY = center.dy - radius * 0.45;
    final browOffsetX = radius * 0.35;
    final browLength = radius * 0.28;

    if (mood == Mood.happy) {
      // Eyebrows slope upward outward (relaxed/raised).
      _drawAngledBrow(canvas, browPaint,
          centerX: center.dx - browOffsetX, y: browY, length: browLength,
          angle: -0.25);
      _drawAngledBrow(canvas, browPaint,
          centerX: center.dx + browOffsetX, y: browY, length: browLength,
          angle: 0.25);
    } else {
      // Sad: eyebrows angle inward (︶ shape, frowning brow).
      _drawAngledBrow(canvas, browPaint,
          centerX: center.dx - browOffsetX, y: browY, length: browLength,
          angle: 0.4);
      _drawAngledBrow(canvas, browPaint,
          centerX: center.dx + browOffsetX, y: browY, length: browLength,
          angle: -0.4);
    }
  }

  void _drawAngledBrow(Canvas canvas, Paint paint,
      {required double centerX,
        required double y,
        required double length,
        required double angle}) {
    final dx = math.cos(angle) * length / 2;
    final dy = math.sin(angle) * length / 2;
    canvas.drawLine(
      Offset(centerX - dx, y - dy),
      Offset(centerX + dx, y + dy),
      paint,
    );
  }

  void _drawMouth(Canvas canvas, Offset center, double radius) {
    final mouthPaint = Paint()
      ..color = const Color(0xFF2D2D2D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    final mouthY = center.dy + radius * 0.3;
    final mouthWidth = radius * 0.7;
    final mouthHeight = radius * 0.4;

    // Animation exaggerates curvature: when animating, the smile gets smilier
    // and the frown gets frownier.
    final curveBoost = 1.0 + 0.3 * math.sin(animationValue * math.pi);

    final rect = Rect.fromCenter(
      center: Offset(center.dx, mouthY),
      width: mouthWidth,
      height: mouthHeight * curveBoost,
    );

    switch (mood) {
      case Mood.happy:
      // Smile: arc from 0 (east) sweeping pi radians clockwise = bottom curve.
        canvas.drawArc(rect, 0, math.pi, false, mouthPaint);
        break;
      case Mood.neutral:
      // Straight line.
        canvas.drawLine(
          Offset(center.dx - mouthWidth / 2, mouthY),
          Offset(center.dx + mouthWidth / 2, mouthY),
          mouthPaint,
        );
        break;
      case Mood.sad:
      // Frown: arc on a rect positioned LOWER, sweeping pi from pi (west)
      // backwards = top curve, which reads as a frown.
        final frownRect = Rect.fromCenter(
          center: Offset(center.dx, mouthY + mouthHeight * 0.4),
          width: mouthWidth,
          height: mouthHeight * curveBoost,
        );
        canvas.drawArc(frownRect, math.pi, math.pi, false, mouthPaint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant MoodFacePainter old) {
    return old.mood != mood ||
        old.animationValue != animationValue;
  }
}