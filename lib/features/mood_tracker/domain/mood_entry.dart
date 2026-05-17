import 'mood.dart';

class MoodEntry {
  final String id;
  final Mood mood;
  final DateTime loggedAt;

  const MoodEntry({
    required this.id,
    required this.mood,
    required this.loggedAt,
  });
}
