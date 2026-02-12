import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);
}

class AppRadius {
  static const double sm = 8.0;
  static const double md = 10.0;
  static const double lg = 12.0;
  static const double xl = 16.0;
  static const double full = 999.0;
}

// Colors from JSON
class LightModeColors {
  static const primary = Color(0xFF1A1A1A);
  static const onPrimary = Color(0xFFFFFFFF);
  static const secondary = Color(0xFF7C9CB4);
  static const onSecondary = Color(0xFFFFFFFF);
  static const tertiary = Color(0xFFC4836A); // Accent
  static const onTertiary = Color(0xFFFFFFFF);
  static const background = Color(0xFFFFFFFF);
  static const surface = Color(0xFFF5F5F5);
  static const onSurface = Color(0xFF1A1A1A); // Primary Text
  static const onSurfaceVariant = Color(0xFF666666); // Secondary Text
  static const outline = Color(0xFFE0E0E0); // Divider
  static const error = Color(0xFFB00020);
  static const onError = Color(0xFFFFFFFF);
  static const success = Color(0xFF4A6741);
  static const hint = Color(0xFFA0A0A0);
}

class DarkModeColors {
  static const primary = Color(0xFFFFFFFF);
  static const onPrimary = Color(0xFF1A1A1A);
  static const secondary = Color(0xFF7C9CB4);
  static const onSecondary = Color(0xFFFFFFFF);
  static const tertiary = Color(0xFFC4836A); // Accent
  static const onTertiary = Color(0xFFFFFFFF);
  static const background = Color(0xFF09637E);
  static const surface = Color(0xFF1E1E1E);
  static const onSurface = Color(0xFFF5F5F5); // Primary Text
  static const onSurfaceVariant = Color(0xFFA0A0A0); // Secondary Text
  static const outline = Color(0xFF2C2C2C); // Divider
  static const error = Color(0xFFCF6679);
  static const onError = Color(0xFF1A1A1A);
  static const success = Color(0xFF7BA36D);
  static const hint = Color(0xFF666666);
}

class FontSizes {
  static const double headlineLarge = 32.0;
  static const double headlineMedium = 26.0;
  static const double titleLarge = 20.0;
  static const double titleMedium = 16.0;
  static const double titleSmall = 14.0;
  static const double labelLarge = 14.0;
  static const double labelMedium = 12.0;
  static const double labelSmall = 10.0;
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;
}

ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: LightModeColors.primary,
    onPrimary: LightModeColors.onPrimary,
    secondary: LightModeColors.secondary,
    onSecondary: LightModeColors.onSecondary,
    tertiary: LightModeColors.tertiary,
    onTertiary: LightModeColors.onTertiary,
    error: LightModeColors.error,
    onError: LightModeColors.onError,
    surface: LightModeColors.surface,
    onSurface: LightModeColors.onSurface,
    onSurfaceVariant: LightModeColors.onSurfaceVariant,
    outline: LightModeColors.outline,
  ),
  scaffoldBackgroundColor: LightModeColors.background,
  dividerColor: LightModeColors.outline,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: LightModeColors.onSurface,
    elevation: 0,
  ),
  cardTheme: CardThemeData(
    color: LightModeColors.surface,
    elevation: 2, // sm/md
    shadowColor: Color(0x0D000000),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      side: const BorderSide(color: LightModeColors.outline, width: 1),
    ),
  ),
  textTheme: _buildTextTheme(),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: LightModeColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: LightModeColors.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: LightModeColors.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: LightModeColors.primary, width: 2),
    ),
    hintStyle: GoogleFonts.inter(color: LightModeColors.hint),
    labelStyle: GoogleFonts.inter(color: LightModeColors.onSurfaceVariant),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightModeColors.primary,
      foregroundColor: LightModeColors.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
);

ThemeData get darkTheme => ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: DarkModeColors.primary,
    onPrimary: DarkModeColors.onPrimary,
    secondary: DarkModeColors.secondary,
    onSecondary: DarkModeColors.onSecondary,
    tertiary: DarkModeColors.tertiary,
    onTertiary: DarkModeColors.onTertiary,
    error: DarkModeColors.error,
    onError: DarkModeColors.onError,
    surface: DarkModeColors.surface,
    onSurface: DarkModeColors.onSurface,
    onSurfaceVariant: DarkModeColors.onSurfaceVariant,
    outline: DarkModeColors.outline,
  ),
  scaffoldBackgroundColor: DarkModeColors.background,
  dividerColor: DarkModeColors.outline,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: DarkModeColors.onSurface,
    elevation: 0,
  ),
  cardTheme: CardThemeData(
    color: DarkModeColors.surface,
    elevation: 2,
    shadowColor: Color(0x0D000000),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      side: const BorderSide(color: DarkModeColors.outline, width: 1),
    ),
  ),
  textTheme: _buildTextTheme(),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: DarkModeColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: DarkModeColors.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: DarkModeColors.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: DarkModeColors.primary, width: 2),
    ),
    hintStyle: GoogleFonts.inter(color: DarkModeColors.hint),
    labelStyle: GoogleFonts.inter(color: DarkModeColors.onSurfaceVariant),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: DarkModeColors.primary,
      foregroundColor: DarkModeColors.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
);

TextTheme _buildTextTheme() {
  return TextTheme(
    headlineLarge: GoogleFonts.inter(fontSize: FontSizes.headlineLarge, fontWeight: FontWeight.w700, height: 1.2),
    headlineMedium: GoogleFonts.inter(fontSize: FontSizes.headlineMedium, fontWeight: FontWeight.w600, height: 1.2),
    titleLarge: GoogleFonts.inter(fontSize: FontSizes.titleLarge, fontWeight: FontWeight.w600, height: 1.3),
    titleMedium: GoogleFonts.inter(fontSize: FontSizes.titleMedium, fontWeight: FontWeight.w600, height: 1.4),
    titleSmall: GoogleFonts.inter(fontSize: FontSizes.titleSmall, fontWeight: FontWeight.w500),
    bodyLarge: GoogleFonts.inter(fontSize: FontSizes.bodyLarge, fontWeight: FontWeight.w400, height: 1.5),
    bodyMedium: GoogleFonts.inter(fontSize: FontSizes.bodyMedium, fontWeight: FontWeight.w400, height: 1.5),
    bodySmall: GoogleFonts.inter(fontSize: FontSizes.bodySmall, fontWeight: FontWeight.w400, height: 1.4),
    labelLarge: GoogleFonts.inter(fontSize: FontSizes.labelLarge, fontWeight: FontWeight.w600, height: 1.2),
    labelMedium: GoogleFonts.inter(fontSize: FontSizes.labelMedium, fontWeight: FontWeight.w600, height: 1.2),
    labelSmall: GoogleFonts.inter(fontSize: FontSizes.labelSmall, fontWeight: FontWeight.w600, height: 1.2),
  );
}

extension CustomColors on ThemeData {
  Color get success => brightness == Brightness.light ? LightModeColors.success : DarkModeColors.success;
  Color get hint => brightness == Brightness.light ? LightModeColors.hint : DarkModeColors.hint;
}
