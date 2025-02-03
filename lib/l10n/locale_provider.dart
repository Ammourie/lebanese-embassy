import 'package:flutter/material.dart';

import 'L10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale("en");
  bool isRTL = true;
  double _scale = 1.0;
  String _country = 'لبنان';

  Locale get locale => _locale;
  String get country => _country;

  double get scale => _scale;

  Locale getLocal(String index) {
    switch (index) {
      case 'en':
        isRTL = true;
        return Locale('en');

      case 'ar':
        isRTL = false;

        return Locale('ar');

      case "de":
        isRTL = true;

        return Locale('de');

      default:
        return Locale('en');
    }
  }
    getcountry(String value) {
    _country=value;
   }

  void setLocale(String locale, {bool shouldUpdate = true}) {
    if (!L10n.all.contains(getLocal(locale))) return;
    _locale = getLocal(locale);
    if (shouldUpdate) notifyListeners();
  }

  void setScale(double scale) {
    _scale = scale;

    notifyListeners();
  }

  void clearLocale() {
    _locale = Locale('en');
    notifyListeners();
  }
}
