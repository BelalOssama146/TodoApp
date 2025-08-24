import 'package:flutter/material.dart';
import 'package:todo_app/l10n/app_localizations.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get locale {
    return AppLocalizations.of(this)!;
  }
}
