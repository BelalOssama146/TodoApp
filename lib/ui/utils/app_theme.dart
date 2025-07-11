import 'package:flutter/material.dart';
import 'package:todo_app/ui/utils/app_styles.dart';

import 'app_colors.dart';

abstract class AppTheme{

  static ThemeData lightMode  = ThemeData(
    appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primary,
    elevation: 0,
    centerTitle: false,
    titleTextStyle:AppStyle.appBarTextStyle,
  ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      selectedIconTheme: IconThemeData(size: 33),
      unselectedIconTheme: IconThemeData(size: 33),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    )
  ) ;


}