import 'package:flutter/cupertino.dart';

import 'app_colors.dart';

abstract class AppStyle {
static const appBarTextStyle = TextStyle(fontSize: 30, fontWeight:FontWeight.bold,color: AppColors.white);
static const titlesTextStyle = TextStyle(fontSize: 27, fontWeight:FontWeight.bold,color: AppColors.primary);
static const bottomSheetTitle = TextStyle(fontSize: 18, fontWeight:FontWeight.w700,color: AppColors.black);
static const bodyTextStyle = TextStyle(fontSize: 12, fontWeight:FontWeight.w600,color: AppColors.black);
static const normalGreyTextStyle = TextStyle(fontSize: 14, fontWeight:FontWeight.w500,color: AppColors.grey);
static const selectedCalenderStyle = TextStyle(fontSize: 15, fontWeight:FontWeight.bold,color: AppColors.primary);
static TextStyle unselectedCalenderStyle = selectedCalenderStyle.copyWith(color: AppColors.black);
}