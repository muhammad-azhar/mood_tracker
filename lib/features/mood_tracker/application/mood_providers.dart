import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../domain/mood.dart';
import '../domain/mood_entry.dart';

class MoodEntriesNotifier extends StateNotifier<List<MoodEntry>> {
  MoodEntriesNotifier() : super(const []);

  void logMood(Mood mood) {
    final entry = MoodEntry(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      mood: mood,
      loggedAt: DateTime.now(),
    );
    // Newest first; cap at 7 so the timeline stays bounded.
    state = [entry, ...state].take(7).toList();
  }
}

final moodEntriesProvider =
StateNotifierProvider<MoodEntriesNotifier, List<MoodEntry>>(
      (ref) => MoodEntriesNotifier(),
);

final currentThemeProvider = Provider<MoodTheme>((ref) {
  final entries = ref.watch(moodEntriesProvider);
  if (entries.isEmpty) return restTheme;
  return entries.first.mood.theme;
});