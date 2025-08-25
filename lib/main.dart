import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/auth/login/login.dart';
import 'package:todo_app/ui/auth/register/register.dart';
import 'package:todo_app/ui/providers/language_provider.dart';
import 'package:todo_app/ui/providers/list_provider.dart';
import 'package:todo_app/ui/providers/theme_provider.dart';
import 'package:todo_app/ui/screens/home/home.dart';
import 'package:todo_app/ui/screens/splash/splash.dart';
import 'package:todo_app/ui/screens/tabs/settings_tab.dart';
import 'package:todo_app/ui/screens/task_edit/task_edit.dart';
import 'package:todo_app/ui/utils/app_theme.dart';

import 'l10n/app_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCujE8vTH6oGe-2Sa-MdXpbHgjmG3F1GcI",
        appId: "1:953563613665:android:7d66cb67ccd935bf982aa0",
        messagingSenderId: "todo-app-fe8b8",
        projectId: "todo-app-fe8b8"),
  );
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>
        ThemeProvider()
          ..getTheme()),
        ChangeNotifierProvider(create: (_) => ListProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of(context);
    ThemeProvider themeProvider = Provider.of(context);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      locale: Locale(languageProvider.selectedLanguage),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightMode,
      darkTheme: AppTheme.darkMode,
      themeMode: themeProvider.currentTheme,
      routes: {
        Splash.routeName : (_) => Splash(),
        Home.routeName :  (_) => Home(),
        Login.routeName: (_) => Login(),
        Register.routeName: (_) => Register(),
        TaskEdit.routeName: (_) => TaskEdit(),
        SettingsTab.routeName: (_) => SettingsTab()
      },
      initialRoute: Splash.routeName,
    );
  }
}

