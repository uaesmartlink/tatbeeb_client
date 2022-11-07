import 'dart:ui';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/translation/ar.dart';
import '../translation/en_US.dart';

class LocalizationService extends Translations {
  static final locale = Locale('en', "US");

  static final langs = ['English', "Arabic",];

  static final locales = [
    Locale('en', 'US'),
    Locale('ar', null),
  ];
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>
      {'en_US': en, 'ar': ar,};

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  Locale _getLocaleFromLanguage(String lang) {
    int index = langs.indexOf(lang);
    return locales[index];
  }
}
