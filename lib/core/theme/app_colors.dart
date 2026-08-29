import 'package:flutter/material.dart';

class AppColors {
  // Brand / Accents
  static const Color primary = Color(0xFFE50914);
  static const Color primaryLight = Color(0xFFFF3849);
  static const Color primaryDark = Color(0xFFB80710);
  static const Color secondary = Color(0xFF6C5CE7);
  static const Color accent = Color(0xFF00D2D3);
  static const Color ratingYellow = Color(0xFFFFB800);

  // Backgrounds & Surfaces (Dark Theme Default)
  static const Color background = Color(0xFF090A0F);
  static const Color backgroundSecondary = Color(0xFF0F111A);
  static const Color surface = Color(0xFF151822);
  static const Color surfaceLight = Color(0xFF1E2333);
  static const Color surfaceElevated = Color(0xFF262C3E);

  // Borders & Dividers
  static const Color border = Color(0xFF23293D);
  static const Color borderLight = Color(0xFF333B56);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA0AEC0);
  static const Color textMuted = Color(0xFF64748B);

  // State Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Shimmer Colors
  static const Color shimmerBase = Color(0xFF1E2333);
  static const Color shimmerHighlight = Color(0xFF2E364E);

  // Gradients
  static const LinearGradient posterOverlayGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Color(0x80000000),
      Color(0xFF090A0F),
    ],
    stops: [0.0, 0.6, 1.0],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1E2333),
      Color(0xFF151822),
    ],
  );
}
