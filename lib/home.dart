import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pf/theme.dart';
import 'package:url_launcher/url_launcher.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 테마 모드 상태 관리
  bool isDarkMode = SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 800;
    final bool isTablet = screenSize.width >= 800 && screenSize.width < 1200;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? getDarkTheme() : getLightTheme(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("DEV.PORTFOLIO"),
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: toggleTheme,
            ),
            if (!isMobile) ...[
              _navItem("About", isDarkMode ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
              _navItem("Projects", isDarkMode ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
              _navItem("Contact", isDarkMode ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
              const SizedBox(width: 20),
            ],
          ],
        ),
        body: CustomScrollView(
          slivers: [
            // 히어로 섹션
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : screenSize.width * 0.1,
                  vertical: 100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "안녕하세요,",
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 32,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? AppColors.darkAccent : AppColors.lightAccent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "앱 개발자 차부곤입니다!",
                      style: TextStyle(
                        fontSize: isMobile ? 40 : 64,
                        fontWeight: FontWeight.w800,
                        color: isDarkMode ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "사용자 경험을 중시하며, 미려한 UI와 탄탄한 비즈니스 로직을 설계합니다.",
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.6,
                        color: isDarkMode ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 프로젝트 그리드
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : screenSize.width * 0.1,
              ),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 2 : isMobile ? 1 : 3,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  childAspectRatio: isMobile ? 1.4 : 1.1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildProjectCard(index, isDarkMode, "이 프로젝트는 Flutter를 사용하여 개발된 앱입니다. 주요 기능과 기술 스택을 간략히 설명하는 텍스트입니다."),
                  childCount: 6,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(int index, bool isDark, String discription) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: (isDark ? AppColors.darkAccent : AppColors.lightAccent).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.folder_outlined,
              color: isDark ? AppColors.darkAccent : AppColors.lightAccent,
            ),
          ),
          const Spacer(),
          Text(
            "Project ${index + 1}",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            discription,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.link, size: 18, color: isDark ? Colors.white38 : Colors.black38),
              const SizedBox(width: 8),
              Text(
                "GitHub Repository",
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white38 : Colors.black38,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navItem(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}