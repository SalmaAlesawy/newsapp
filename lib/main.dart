import 'package:flutter/material.dart';
import 'package:newsapp/core/routes/AppRouter.dart';
import 'package:newsapp/core/routes/PageRoutNames.dart';
import 'package:newsapp/core/themes/ThemeManager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: PageRouteNames.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.getLightTheme(),
    );
  }
}
