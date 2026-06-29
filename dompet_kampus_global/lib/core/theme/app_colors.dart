import 'package:flutter/material.dart';

class AppColors {
  // ── daqi brand palette ──────────────────────────────────────────────────
  // Gradient: midnight navy → royal blue → vivid cyan (sesuai logo daqi)
  static const Color primaryDark   = Color(0xFF050E1F); // midnight navy
  static const Color primary       = Color(0xFF1648C8); // royal electric blue
  static const Color primaryLight  = Color(0xFF3A80EE); // sky blue
  static const Color primarySurface= Color(0xFFEBF3FF); // ice blue
  static const Color primaryBorder = Color(0xFFBDD6FC); // soft blue border

  // Cyan accent — warna "i" di logo daqi
  static const Color cyan          = Color(0xFF00BFD8);
  static const Color cyanLight     = Color(0xFF26D5E8);
  static const Color cyanSurface   = Color(0xFFE0FAFB);

  // ── Semantic ─────────────────────────────────────────────────────────────
  static const Color green         = Color(0xFF16A571);
  static const Color greenSurface  = Color(0xFFE8F8F2);
  static const Color amber         = Color(0xFFD98512);
  static const Color amberSurface  = Color(0xFFFDF3E3);
  static const Color red           = Color(0xFFE5484D);
  static const Color redSurface    = Color(0xFFFDECED);
  static const Color violet        = Color(0xFF7A5AF8);
  static const Color violetSurface = Color(0xFFF0EEFF);

  // ── Neutral ───────────────────────────────────────────────────────────────
  static const Color ink     = Color(0xFF0B1628);
  static const Color slate600= Color(0xFF3D4F68);
  static const Color slate500= Color(0xFF5B6F8A);
  static const Color slate400= Color(0xFF8FA4BE);
  static const Color slate300= Color(0xFFC5D2E0);
  static const Color line    = Color(0xFFDEE8F5);
  static const Color line2   = Color(0xFFEFF4FB);
  static const Color bg      = Color(0xFFF0F5FF); // ice-blue background
  static const Color white   = Color(0xFFFFFFFF);

  // ── Gradient — midnight navy → royal blue → vivid cyan ───────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.52, 1.0],
    colors: [primaryDark, primary, cyan],
  );

  // Gradient lebih ringan untuk card/chip
  static const LinearGradient softGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, cyan],
  );

  // ── Shadows ───────────────────────────────────────────────────────────────
  static List<BoxShadow> shadowCard = [
    BoxShadow(
      color: Color(0x181648C8),
      blurRadius: 28,
      spreadRadius: 0,
      offset: Offset(0, 6),
    ),
  ];
  static List<BoxShadow> shadowSoft = [
    BoxShadow(
      color: Color(0x0C1648C8),
      blurRadius: 14,
      spreadRadius: 0,
      offset: Offset(0, 3),
    ),
  ];
  static List<BoxShadow> shadowPrimary = [
    BoxShadow(
      color: Color(0x481648C8),
      blurRadius: 24,
      spreadRadius: 0,
      offset: Offset(0, 10),
    ),
  ];

  // ── Tone map for FeatureIcon ──────────────────────────────────────────────
  static Map<String, List<Color>> tones = {
    'blue'  : [primarySurface, primary],
    'cyan'  : [cyanSurface, cyan],
    'green' : [greenSurface, green],
    'amber' : [amberSurface, amber],
    'red'   : [redSurface, red],
    'violet': [violetSurface, violet],
    'slate' : [bg, slate600],
  };

  static List<Color> tone(String name) => tones[name] ?? tones['blue']!;
}
