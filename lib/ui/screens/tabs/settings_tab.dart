import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/extension/build_context_extension.dart';
import 'package:todo_app/ui/providers/language_provider.dart';
import 'package:todo_app/ui/providers/theme_provider.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});
  static String routeName = "setting";

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late LanguageProvider languageProvider;
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    languageProvider = Provider.of(context);
    themeProvider = Provider.of(context);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 105,
          title: Padding(
            padding: const EdgeInsets.only(left: 52, bottom: 61),
            child: Text(context.locale.settings,),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.only(left: 38),
                  child: Text(context.locale.language, style: Theme
                      .of(context)
                      .textTheme
                      .labelMedium,),
                ),
                SizedBox(height: 17,),
                buildLanguageButton(),
                SizedBox(height: 19,),
                Padding(
                  padding: const EdgeInsets.only(left: 38),
                  child: Text(context.locale.mode, style: Theme
                      .of(context)
                      .textTheme
                      .labelMedium,),
                ),
                SizedBox(height: 17,),
                buildModeButton(),
              ],
            )));
  }

  Widget buildLanguageButton() =>
      Padding(
        padding: const EdgeInsets.only(left: 56, right: 37),
        child: Container(
          width: 319,
          padding: const EdgeInsets.symmetric(horizontal: 16,),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
              color: themeProvider.easyDatePicker
          ),
          child: DropdownButton(
            value: languageProvider.selectedLanguage,
            menuWidth: 266,
            isExpanded: true,
            items: [
              DropdownMenuItem<String>(value: "en",
                  child: Text("English", style: AppStyle.languageTextStyle,)),
              DropdownMenuItem<String>(value: "ar",
                  child: Text("العربية", style: AppStyle.languageTextStyle,)),
            ],
            onChanged: (value) {
              languageProvider.appLanguage =
                  value ?? languageProvider.selectedLanguage;
              setState(() {});
            },
          ),
        ),
      );
  Widget buildModeButton() =>
      Padding(
        padding: const EdgeInsets.only(left: 56, right: 37),
        child: Container(
          width: 319,
          padding: const EdgeInsets.symmetric(horizontal: 16,),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
              color: themeProvider.easyDatePicker
          ),
          child: DropdownButton<ThemeMode>(

              value: themeProvider.currentTheme,
              menuWidth: 266,
              isExpanded: true,
              items: [
                DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text(context.locale.light,
                      style: AppStyle.languageTextStyle,)),
                DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text(
                      context.locale.dark, style: AppStyle.languageTextStyle,)),
              ],
              onChanged: (ThemeMode? newValue) async {
                if (newValue != null) {
                  await themeProvider.newTheme(newValue); // بدل themeMode
                }
              }
          ),
        ),
      );


}