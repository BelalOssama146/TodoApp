import 'package:flutter/material.dart';
import 'package:todo_app/ui/utils/app_styles.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData lightMode = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.bgColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.primary,
      titleTextStyle: AppStyle.appBarTextStyle,
    ),
    textTheme: TextTheme(
        displayMedium: AppStyle.appBarDarkTextStyle,
        bodyMedium: AppStyle.listDarkTextStyle,
        bodySmall: AppStyle.normalGreyTextStyle,
        labelMedium: AppStyle.bottomSheetTitle,
        displaySmall: AppStyle.selectedCalenderStyle,
        titleSmall: AppStyle.unselectedCalenderStyle,
        titleMedium: AppStyle.normalGreyTextStyle
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: StadiumBorder(side: BorderSide(
            width: 5,
            color: AppColors.white))
    ),
      bottomAppBarTheme: BottomAppBarThemeData(
        color: AppColors.white,
      )

  );
  static ThemeData darkMode = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.bgDarkColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.primary,
      titleTextStyle: AppStyle.toDoStyle,
    ),
    textTheme: TextTheme(
        displayMedium: AppStyle.appBarDarkTextStyle,
        bodyMedium: AppStyle.listDarkTextStyle,
        bodySmall: AppStyle.detailsTaskTextStyle,
        labelMedium: AppStyle.bottomSheetDarkStyle,
        displaySmall: AppStyle.dateDarkTextStyle,
        titleSmall: AppStyle.dateDarkTextStyle
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.appBarTextDarkColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: StadiumBorder(side: BorderSide(
            width: 5,
            color: AppColors.appBarTextDarkColor))
    ),
    bottomAppBarTheme: BottomAppBarThemeData(
        color: AppColors.appBarTextDarkColor
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
            focusColor: AppColors.appBarTextDarkColor,
            hoverColor: AppColors.white
        )
    ),
  );
}
