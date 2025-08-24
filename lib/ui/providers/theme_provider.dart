import 'package:flutter/material.dart';
import 'package:todo_app/ui/utils/app_assets.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_styles.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.light;

  ThemeMode get currentTheme => _currentTheme;

  bool get isDarkThemeEnabled => _currentTheme == ThemeMode.dark;

  set newTheme(ThemeMode themeMode) {
    _currentTheme = themeMode;
    notifyListeners();
  }

  String get splashScreen =>
      isDarkThemeEnabled ? AppAssets.splashDark : AppAssets.splash;

  Color get floatingButton =>
      isDarkThemeEnabled ? AppColors.primary : AppColors.primary;

  Color get bottomAppBar =>
      isDarkThemeEnabled ? AppColors.appBarTextDarkColor : AppColors.white;

  Color get bgListTab =>
      isDarkThemeEnabled ? AppColors.bgDarkColor : AppColors.bgColor;

  Color get easyDatePicker =>
      isDarkThemeEnabled ? AppColors.appBarTextDarkColor : AppColors.white;

  Color get action => isDarkThemeEnabled ? AppColors.toDoDark : AppColors.white;

  Color get descriptionTitle =>
      isDarkThemeEnabled ? AppColors.white : AppColors.black;

  Color get loginTitle =>
      isDarkThemeEnabled ? AppColors.toDoDark : AppColors.white;

  Color get welcome => isDarkThemeEnabled ? AppColors.white : AppColors.black;

  Color get fieldText => isDarkThemeEnabled ? AppColors.white : AppColors.black;

  TextStyle get date => isDarkThemeEnabled
      ? AppStyle.bottomSheetDarkStyle
      : AppStyle.bottomSheetDarkStyle.copyWith(color: AppColors.white);

  TextStyle get account => isDarkThemeEnabled
      ? AppStyle.bottomSheetDarkStyle.copyWith(fontSize: 16)
      : AppStyle.bottomSheetTitle.copyWith(fontSize: 16);
}
