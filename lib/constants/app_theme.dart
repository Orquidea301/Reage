import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get light {
    final baseTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'LiberationSerif',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryYellow,
        primary: AppColors.primaryYellow,
        onPrimary: AppColors.onPrimary,
      ),
      scaffoldBackgroundColor: AppColors.pageWhite,
    );

    return baseTheme.copyWith(
      textTheme: baseTheme.textTheme.apply(
        bodyColor: AppColors.textBody,
        displayColor: AppColors.textDark,
      ),
    );
  }
}
