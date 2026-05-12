import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pf/home.dart';

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

        // --- 라이트 모드 컬러 정의 ---
    const lightBg = Color(0xFFF8FAFC); // 매우 밝은 블루그레이 (배경)
    const lightSurface = Colors.white; // 카드 및 앱바 배경
    const lightPrimary = Color(0xFF6366F1); // 인디고 (포인트)
    const lightTextPrimary = Color(0xFF1E293B); // 진한 슬레이트 (주요 텍스트)
    const lightTextSecondary = Color(0xFF64748B); // 중간 슬레이트 (보조 텍스트)

    // --- 다크 모드 컬러 정의 ---
    const darkBg = Color(0xFF0F172A);
    const darkPrimary = Color(0xFF22D3EE); // 시안 (포인트)


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Dev Portfolio',
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: isDarkMode ? darkBg : lightBg,
        primaryColor: isDarkMode ? darkPrimary : lightPrimary,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: isDarkMode ? Colors.white : lightTextPrimary),
          titleTextStyle: TextStyle(
            color: isDarkMode ? Colors.white : lightTextPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

