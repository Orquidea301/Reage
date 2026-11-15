import 'package:flutter/material.dart';
import 'colors.dart';

/// Tema global da aplicação ReAge.
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

/// Estilos de texto padronizados da aplicação.
class AppText {
  static const TextStyle label = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle input = TextStyle(
    fontSize: 18,
    color: AppColors.textDark,
  );

  static const TextStyle eyebrow = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.6,
    color: AppColors.goldDark,
  );

  static const TextStyle title = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.textBody,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
}

/// Decorações de input padronizadas da aplicação.
class AppInput {
  static InputDecoration decoration({String? hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 17,
        color: AppColors.textCaption,
      ),
      filled: true,
      fillColor: const Color(0xF2FFFFFF),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.grayBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.grayBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primaryYellow, width: 2),
      ),
      suffixIcon: suffix,
    );
  }
}
