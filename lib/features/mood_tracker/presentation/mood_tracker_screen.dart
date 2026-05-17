import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/mood_providers.dart';
import '../domain/mood.dart';
import 'widgets/mood_selector.dart';
import 'widgets/timeline_entry.dart';

class MoodTrackerScreen extends ConsumerWidget {
  const MoodTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(moodEntriesProvider);
    final theme = ref.watch(currentThemeProvider);

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: theme.gradient,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Header(theme: theme),
                    const SizedBox(height: 24),
                    const MoodSelector(),
                    const SizedBox(height: 32),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 600),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.4,
                        color: theme.textSecondary,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4, bottom: 12),
                        child: Text('RECENT ENTRIES'),
                      ),
                    ),
                    SizedBox(
                      height: 170,
                      child: entries.isEmpty
                          ? Center(
                              child: Text(
                                'Tap a face above to log your first mood.',
                                style: TextStyle(
                                  color: theme.textSecondary,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 13,
                                ),
                              ),
                            )
                          : ScrollConfiguration(
                              behavior: _AllInputScrollBehavior(),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: entries.length,
                                itemBuilder: (_, i) =>
                                    TimelineEntry(entry: entries[i]),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AllInputScrollBehavior extends MaterialScrollBehavior {
  const _AllInputScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
  };
}

class _Header extends StatelessWidget {
  final MoodTheme theme;
  const _Header({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 600),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: theme.textPrimary,
              ),
              child: const Text('Mood tracker'),
            ),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 600),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.4,
                color: theme.textSecondary,
              ),
              child: Text(theme.greeting),
            ),
          ],
        ),
        const SizedBox(height: 6),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 600),
          style: TextStyle(fontSize: 14, color: theme.textSecondary),
          child: Text(theme.subtitle),
        ),
      ],
    );
  }
}
