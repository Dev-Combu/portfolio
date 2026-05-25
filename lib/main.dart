import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pf/home.dart';
import 'package:pf/theme.dart';

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatefulWidget {
  const MyPortfolio({super.key});

  @override
  State<MyPortfolio> createState() => _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> {
  bool isDarkMode = SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Dev Portfolio',
      theme: getLightTheme(),
      darkTheme: getDarkTheme(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomePage(),
    );
  }
}
