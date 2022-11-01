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
        case NavigatorPage.routeName:
        return SlideLeftRoute(NavigatorPage());
      case OrderPage.routeName:
        return SlideLeftRoute(OrderPage());
      case ProfilePage.routeName:
        return SlideLeftRoute(ProfilePage());
      case NotificationPage.routeName:
        return SlideLeftRoute(NotificationPage());
      case SettingPage.routeName:
        return SlideLeftRoute(SettingPage());
      case InfoPage.routeName:
        return SlideLeftRoute(InfoPage());
      default:
        throw ('this route name does not exist');
    }
  }
}
