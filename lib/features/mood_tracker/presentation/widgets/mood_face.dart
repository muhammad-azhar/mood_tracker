import 'package:flutter/material.dart';
import '../../domain/mood.dart';
import 'mood_face_painter.dart';

class MoodFace extends StatelessWidget {
  final Mood mood;
  final double size;
  final double animationValue;

  const MoodFace({
    super.key,
    required this.mood,
    this.size = 80,
    this.animationValue = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: MoodFacePainter(
          mood: mood,
          // accent: mood.accent,
          animationValue: animationValue,
        ),
      ),
    );
  }
}