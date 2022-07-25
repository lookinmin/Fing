import 'package:fing/category/example.dart';
import 'package:fing/main.dart';
import 'package:flutter/material.dart';
import './constants/router.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => MainPage());
      case goods:
        return MaterialPageRoute(
            settings: RouteSettings(name: settings.name),
            builder: (_) => SplashRoute());
      default:
        return MaterialPageRoute(builder: (context) => MainPage());
    }
  }
}
