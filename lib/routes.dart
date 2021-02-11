import 'package:flutter/material.dart';

import 'screens/home.dart';

final routes = <String, WidgetBuilder>{
  '/': (BuildContext ctx) => HomeScreen(),
};

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final name = settings.name;
  final isModal = name.contains('|modal');
  return MaterialPageRoute(builder: routes[name], settings: settings, fullscreenDialog: isModal);
}
