import 'package:flutter/material.dart';

enum Mood { happy, neutral, sad }

class MoodTheme {
  final List<Color> gradient;
  final Color accent;
  final Color faceFill;
  final Color textPrimary;
  final Color textSecondary;
  final Color cardBg;
  final Color cardBorder;
  final Color tileHover;
  final String greeting;
  final String subtitle;

  const MoodTheme({
    required this.gradient,
    required this.accent,
    required this.faceFill,
    required this.textPrimary,
    required this.textSecondary,
    required this.cardBg,
    required this.cardBorder,
    required this.tileHover,
    required this.greeting,
    required this.subtitle,
  });
}

const restTheme = MoodTheme(
  gradient: [Color(0xFFEEF2F7), Color(0xFFE4EBF3)],
  accent: Color(0xFF5F7A92),
  faceFill: Color(0xFFC7D4E0),
  textPrimary: Color(0xFF1F2937),
  textSecondary: Color(0xFF5B6573),
  cardBg: Color(0x8CFFFFFF),
  cardBorder: Color(0xD9FFFFFF),
  tileHover: Color(0x80FFFFFF),
  greeting: 'TAP TO LOG',
  subtitle: 'A small daily check-in',
);

extension MoodX on Mood {
  String get label {
    switch (this) {
      case Mood.happy: return 'Happy';
      case Mood.neutral: return 'Okay';
      case Mood.sad: return 'Sad';
    }
  }

  MoodTheme get theme {
    switch (this) {
      case Mood.happy:
        return const MoodTheme(
          gradient: [Color(0xFFFFE9A8), Color(0xFFFFC267), Color(0xFFFF9D63)],
          accent: Color(0xFFF2933B),
          faceFill: Color(0xFFFFD891),
          textPrimary: Color(0xFF5B3A0E),
          textSecondary: Color(0xFF7E5418),
          cardBg: Color(0x8CFFFCF5),
          cardBorder: Color(0xB3FFFFFF),
          tileHover: Color(0x73FFFFFF),
          greeting: 'FEELING BRIGHT',
          subtitle: 'A spark of warmth today',
        );
      case Mood.neutral:
        return const MoodTheme(
          gradient: [Color(0xFFD9E4ED), Color(0xFFB8C9D7), Color(0xFF97AEC2)],
          accent: Color(0xFF5F7A92),
          faceFill: Color(0xFFC7D4E0),
          textPrimary: Color(0xFF28323D),
          textSecondary: Color(0xFF4D5A68),
          cardBg: Color(0x80FFFFFF),
          cardBorder: Color(0xBFFFFFFF),
          tileHover: Color(0x66FFFFFF),
          greeting: 'STEADY',
          subtitle: 'An even-keeled moment',
        );
      case Mood.sad:
        return const MoodTheme(
          gradient: [Color(0xFF4A5A8C), Color(0xFF5F71A8), Color(0xFF7A8FC4)],
          accent: Color(0xFF3D4F8C),
          faceFill: Color(0xFFA8B5D9),
          textPrimary: Color(0xFFEEF1F8),
          textSecondary: Color(0xFFC5CEE5),
          cardBg: Color(0x1FFFFFFF),
          cardBorder: Color(0x38FFFFFF),
          tileHover: Color(0x24FFFFFF),
          greeting: 'HEAVIER TODAY',
          subtitle: 'That is okay — it passes',
        );
    }
  }
}