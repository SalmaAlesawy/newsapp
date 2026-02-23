import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Home/homeScreen.dart';
import 'package:newsapp/core/routes/PageRoutNames.dart';
import 'package:newsapp/splash/SplashScreen.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteNames.splash:
        return MaterialPageRoute(
          builder: (context) => Splashscreen(),
          settings: settings,
        );
      case PageRouteNames.homeScreen:
        return MaterialPageRoute(
          builder: (context) => Homescreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Splashscreen(),
          settings: settings,
        );
    }
  }
}
