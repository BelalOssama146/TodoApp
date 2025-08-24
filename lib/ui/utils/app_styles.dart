import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppStyle {
  ///light
  static const appBarTextStyle = TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.white);
  static const titlesTextStyle = TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary);
  static const bottomSheetTitle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.black);
  static const loginTitle = TextStyle(
      fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.black);
  static const toDoLight = TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.white);
  static const settingsTextStyle = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.black);
  static const languageTextStyle = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.primary);
  static const normalGreyTextStyle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.grey);
static const listTextStyle = TextStyle(fontSize: 15, fontWeight:FontWeight.w500,color: AppColors.primary);
  static const listDateTextStyle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.black);
static const selectedCalenderStyle = TextStyle(fontSize: 15, fontWeight:FontWeight.bold,color: AppColors.primary);
static TextStyle unselectedCalenderStyle = selectedCalenderStyle.copyWith(color: AppColors.black);

  ///Dark
  static const appBarDarkTextStyle = TextStyle(fontSize: 22,
      fontWeight: FontWeight.bold,
      color: AppColors.appBarTextDarkColor);
  static const toDoStyle = TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.toDoDark);
  static const listDarkTextStyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary);
  static const bottomSheetDarkStyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white);
  static const detailsTaskTextStyle = TextStyle(fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.greyDarkColor);
  static const dateDarkTextStyle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.white);

}