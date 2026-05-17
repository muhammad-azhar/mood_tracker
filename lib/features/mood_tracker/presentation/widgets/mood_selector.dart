import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/mood_providers.dart';
import '../../domain/mood.dart';
import 'mood_face.dart';

class MoodSelector extends ConsumerWidget {
  const MoodSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(currentThemeProvider);

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: theme.cardBg,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: theme.cardBorder, width: 0.5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 600),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: theme.textPrimary,
                ),
                child: const Text('How are you feeling?'),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: Mood.values.map((mood) {
                  return _SelectorTile(
                    mood: mood,
                    theme: theme,
                    onTap: () => ref
                        .read(moodEntriesProvider.notifier)
                        .logMood(mood),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectorTile extends StatefulWidget {
  final Mood mood;
  final MoodTheme theme;
  final VoidCallback onTap;
  const _SelectorTile({
    required this.mood,
    required this.theme,
    required this.onTap,
  });

  @override
  State<_SelectorTile> createState() => _SelectorTileState();
}

class _SelectorTileState extends State<_SelectorTile> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: _hovering ? widget.theme.tileHover : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          transform: _hovering
              ? (Matrix4.identity()..translate(0.0, -3.0))
              : Matrix4.identity(),
          child: Column(
            children: [
              MoodFace(mood: widget.mood, size: 88),
              const SizedBox(height: 8),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 600),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                  color: widget.theme.textSecondary,
                ),
                child: Text(widget.mood.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}