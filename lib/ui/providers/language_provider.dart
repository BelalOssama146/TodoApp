import 'package:flutter/widgets.dart';

class LanguageProvider extends ChangeNotifier {
  String selectedLanguage = "en";

  set appLanguage(String language) {
    selectedLanguage = language;
    notifyListeners();
  }
}
