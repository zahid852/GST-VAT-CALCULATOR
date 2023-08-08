import 'package:flutter/material.dart';
import 'package:vat_calculator/screens/history_screen.dart';
import 'package:vat_calculator/screens/home_screen.dart';
import 'package:vat_calculator/screens/settings.dart';
import 'package:vat_calculator/screens/vat_screen.dart';

class routes {
  static const String SettingsRoute = '/settings';
  static const String vatRoute = '/vatRoute';
  static const String home = '/homeRoute';
  static const String history = '/history';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case routes.history:
        return MaterialPageRoute(builder: (ctx) => historyScreen());
      case routes.home:
        return MaterialPageRoute(builder: (ctx) => homeScreen());
      case routes.vatRoute:
        return MaterialPageRoute(builder: (ctx) => vatScreen());
      case routes.SettingsRoute:
        return MaterialPageRoute(builder: (ctx) => settings());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => Scaffold(
              appBar: AppBar(
                title: Text('No Record Found'),
              ),
              body: Center(
                child: Container(
                  child: Text('No Record Found'),
                ),
              ),
            )));
  }
}
