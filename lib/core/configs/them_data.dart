
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_color.dart';
import 'app_text.dart';


class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
    ),
    textTheme:TextTheme(
        labelLarge: AppText.actionL,
        labelMedium: AppText.actionM,
        labelSmall: AppText.actionS,
        headlineLarge: AppText.headH1,
        headlineMedium: AppText.headH2,
        headlineSmall: AppText.headH3,
        bodyLarge: AppText.bodyL,
        bodyMedium: AppText.bodyM,
        bodySmall: AppText.bodyS
    ) ,
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        centerTitle: true,
        scrolledUnderElevation: 0.0,
        titleTextStyle: TextStyle(fontSize: 16,color: Colors.black87,fontWeight: FontWeight.w300),
        systemOverlayStyle:SystemUiOverlayStyle(
          statusBarColor:AppColors.surface, // Change this color as needed
          statusBarIconBrightness: Brightness.dark, // Set brightness accordingly
          systemNavigationBarColor: AppColors.surface, // Change bottom navigation color
        )
    ),
    scaffoldBackgroundColor: AppColors.surface,
    brightness: Brightness.light,
    fontFamily: 'Inter',
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(12),
      hintStyle: AppText.bodyM.copyWith(color: AppColors.placeholderText),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.lightGrayDark,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.lightGrayDark,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.primary,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        textStyle: AppText.buttonText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  );
}