import "package:flutter/material.dart";

class MaterialTheme {
  const MaterialTheme();

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2f628c),
      surfaceTint: Color(0xff2f628c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffcee5ff),
      onPrimaryContainer: Color(0xff0d4a73),
      secondary: Color(0xff51606f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd5e4f7),
      onSecondaryContainer: Color(0xff3a4857),
      tertiary: Color(0xff68587a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffeedbff),
      onTertiaryContainer: Color(0xff4f4061),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff181c20),
      onSurfaceVariant: Color(0xff42474e),
      outline: Color(0xff72777f),
      outlineVariant: Color(0xffc2c7cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xff9bcbfa),
      primaryFixed: Color(0xffcee5ff),
      onPrimaryFixed: Color(0xff001d32),
      primaryFixedDim: Color(0xff9bcbfa),
      onPrimaryFixedVariant: Color(0xff0d4a73),
      secondaryFixed: Color(0xffd5e4f7),
      onSecondaryFixed: Color(0xff0e1d2a),
      secondaryFixedDim: Color(0xffb9c8da),
      onSecondaryFixedVariant: Color(0xff3a4857),
      tertiaryFixed: Color(0xffeedbff),
      onTertiaryFixed: Color(0xff231533),
      tertiaryFixedDim: Color(0xffd3bfe6),
      onTertiaryFixedVariant: Color(0xff4f4061),
      surfaceDim: Color(0xffd8dae0),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f3f9),
      surfaceContainer: Color(0xffeceef3),
      surfaceContainerHigh: Color(0xffe6e8ee),
      surfaceContainerHighest: Color(0xffe0e2e8),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9bcbfa),
      surfaceTint: Color(0xff9bcbfa),
      onPrimary: Color(0xff003353),
      primaryContainer: Color(0xff0d4a73),
      onPrimaryContainer: Color(0xffcee5ff),
      secondary: Color(0xffb9c8da),
      onSecondary: Color(0xff233240),
      secondaryContainer: Color(0xff3a4857),
      onSecondaryContainer: Color(0xffd5e4f7),
      tertiary: Color(0xffd3bfe6),
      onTertiary: Color(0xff382a49),
      tertiaryContainer: Color(0xff4f4061),
      onTertiaryContainer: Color(0xffeedbff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff101418),
      onSurface: Color(0xffe0e2e8),
      onSurfaceVariant: Color(0xffc2c7cf),
      outline: Color(0xff8c9198),
      outlineVariant: Color(0xff42474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e8),
      inversePrimary: Color(0xff2f628c),
      primaryFixed: Color(0xffcee5ff),
      onPrimaryFixed: Color(0xff001d32),
      primaryFixedDim: Color(0xff9bcbfa),
      onPrimaryFixedVariant: Color(0xff0d4a73),
      secondaryFixed: Color(0xffd5e4f7),
      onSecondaryFixed: Color(0xff0e1d2a),
      secondaryFixedDim: Color(0xffb9c8da),
      onSecondaryFixedVariant: Color(0xff3a4857),
      tertiaryFixed: Color(0xffeedbff),
      onTertiaryFixed: Color(0xff231533),
      tertiaryFixedDim: Color(0xffd3bfe6),
      onTertiaryFixedVariant: Color(0xff4f4061),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff36393e),
      surfaceContainerLowest: Color(0xff0b0f12),
      surfaceContainerLow: Color(0xff181c20),
      surfaceContainer: Color(0xff1c2024),
      surfaceContainerHigh: Color(0xff272a2f),
      surfaceContainerHighest: Color(0xff323539),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    fontFamily: 'FiraSans',
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
