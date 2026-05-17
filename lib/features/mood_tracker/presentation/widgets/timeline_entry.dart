import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/mood_providers.dart';
import '../../domain/mood.dart';
import '../../domain/mood_entry.dart';
import 'mood_face_painter.dart';

class TimelineEntry extends ConsumerStatefulWidget {
  final MoodEntry entry;
  const TimelineEntry({super.key, required this.entry});

  @override
  ConsumerState<TimelineEntry> createState() => _TimelineEntryState();
}

class _TimelineEntryState extends ConsumerState<TimelineEntry>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final globalTheme = ref.watch(currentThemeProvider);
    final moodTheme = widget.entry.mood.theme;
    final dateLabel = DateFormat('MMM d').format(widget.entry.loggedAt);
    final timeLabel = DateFormat('h:mm a').format(widget.entry.loggedAt);

    return GestureDetector(
      onTap: () => _controller.forward(from: 0.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 108,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.fromLTRB(8, 14, 8, 12),
          decoration: BoxDecoration(
            color: moodTheme.faceFill.withOpacity(0.35),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: moodTheme.accent.withOpacity(0.4),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (_, __) => SizedBox(
                  width: 64,
                  height: 64,
                  child: CustomPaint(
                    painter: MoodFacePainter(
                      mood: widget.entry.mood,
                      animationValue: _controller.value,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                dateLabel,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: globalTheme.textPrimary,
                ),
              ),
              Text(
                timeLabel,
                style: TextStyle(
                  color: globalTheme.textSecondary,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 2,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: moodTheme.accent.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}