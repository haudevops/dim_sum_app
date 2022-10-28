import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:dim_sum_app/res/colors.dart';
import 'package:dim_sum_app/utils/prefs_util.dart';

import '../prefs_const.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  ThemeProvider() {
    getThemeLocal();
  }

  getThemeLocal() async {
    final isDarkMode = PrefsUtil.getBool(PrefsCache.THEME_APP);

    if (isDarkMode != null) {
      themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      AppColor().switchMode(isDarkTheme: isDarkMode);
    } else {
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      PrefsUtil.putBool(PrefsCache.THEME_APP, brightness == Brightness.dark);
      AppColor().switchMode(isDarkTheme: brightness == Brightness.dark);
    }
    notifyListeners();
  }

  void toggleTheme(bool isDarkMode) {
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    PrefsUtil.putBool(PrefsCache.THEME_APP, isDarkMode);
    AppColor().switchMode(isDarkTheme: isDarkMode);
    notifyListeners();
  }
}
