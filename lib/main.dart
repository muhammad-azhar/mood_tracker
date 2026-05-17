import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/mood_tracker/presentation/mood_tracker_screen.dart';

void main() {
  runApp(const ProviderScope(child: MoodTrackerApp()));
}

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'Inter',
      ),
      home: const MoodTrackerScreen(),
    );
  }
}