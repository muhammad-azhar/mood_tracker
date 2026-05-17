# Mood Tracker

A single-screen Flutter web app for logging daily mood. Faces are hand-drawn with `CustomPainter` (no images or emojis). The interface theme — gradient background, glassmorphism cards, text colors — shifts to match your most recent mood.

**Live demo:** https://your-app.web.app

## Features

- Tap a face to log how you're feeling
- Horizontal scrollable timeline of recent entries
- Tap any past entry to replay its animation
- Three distinct expressions (happy, neutral, sad) — drawn from circles, arcs, and lines
- Mood-driven theme: the whole UI fades to match the active mood

## Architecture

- **State management:** Riverpod (`StateNotifierProvider` for mutable entry list, `Provider` for derived theme)
- **Drawing:** `CustomPainter` using `drawCircle`, `drawArc`, `drawLine`
- **Animation:** `AnimationController` per timeline tile (independent pulse animations) + `AnimatedContainer` for theme transitions
- **Structure:** feature-first layout (`domain` / `application` / `presentation`)

## Run locally

```bash
flutter pub get
flutter run -d chrome
```

## Project structure