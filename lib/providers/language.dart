import 'package:anime_app/l10n/ln10.dart';
import 'package:anime_app/main.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _lang = language;
  Locale? _locale;

  Locale? get locale => _locale;

  getLanguage() {
    return _lang;
  }

  setLanguage(String lang) {
    _lang = lang;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }

  String tBirthday() {
    if (getLanguage() == 'AR') {
      return 'تاريخ الميلاد';
    } else {
      return 'Birthday';
    }
  }

  String tCreatePassword() {
    if (getLanguage() == 'AR') {
      return 'إنشاء كلمة مرورك';
    } else {
      return 'Create your password';
    }
  }

  String tAbout() {
    if (getLanguage() == 'AR') {
      return 'معلومات';
    } else {
      return 'About';
    }
  }

  String tChangeLanguage() {
    if (getLanguage() == 'AR') {
      return 'تغير اللغه';
    } else {
      return 'Change Language';
    }
  }

  String tLogOut() {
    if (getLanguage() == 'AR') {
      return 'تسجيل الخروج';
    } else {
      return 'Log out';
    }
  }

  String tThemeMode() {
    if (getLanguage() == 'AR') {
      return 'الوضع المظلم';
    } else {
      return 'Dark Mode';
    }
  }
}
