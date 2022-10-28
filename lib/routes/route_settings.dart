import 'package:dim_sum_app/page/page_export.dart';
import 'package:flutter/material.dart';
import 'package:dim_sum_app/routes/slide_left_route.dart';

import 'screen_arguments.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    late ScreenArguments arg;
    final Object? arguments = settings.arguments;
    if (arguments != null) {
      arg = arguments as ScreenArguments;
    }
    switch (settings.name) {
      case SplashPage.routeName:
        return SlideLeftRoute(SplashPage());
      case LoginPage.routeName:
        return SlideLeftRoute(LoginPage());
      case HomePage.routeName:
        return SlideLeftRoute(HomePage());
      default:
        throw ('this route name does not exist');
    }
  }
}
