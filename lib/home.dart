import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pf/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pf/projects.dart';
import 'dart:ui_web' as ui_web;
import 'package:web/web.dart' as web;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode =
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  // 프로젝트 상세 모달창을 띄우는 함수
  void _showProjectDetailModal(
    BuildContext context,
    Project project,
    bool isDark,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) {
        final double screenWidth = MediaQuery.of(context).size.width;
        final bool isModalMobile = screenWidth < 700;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: isDark ? AppColors.darkPrimary : Colors.white,
          insetPadding: EdgeInsets.symmetric(
            horizontal: isModalMobile ? 16 : screenWidth * 0.2,
            vertical: 40,
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.all(32),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          project.title,
                          style: TextStyle(
                            fontSize: isModalMobile ? 24 : 28,
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.close,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32, thickness: 1),
                  Text(
                    '📌 프로젝트 소개',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.darkAccent
                          : AppColors.lightAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.description,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '🛠️ 사용 기술 및 도구',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.darkAccent
                          : AppColors.lightAccent,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildTechChip('Flutter', isDark),
                      _buildTechChip('Dart', isDark),
                      _buildTechChip('Firebase', isDark),
                      _buildTechChip('Git / GitHub', isDark),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final uri = Uri.parse(project.link);
                            if (await canLaunchUrl(uri)) await launchUrl(uri);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark
                                ? Colors.white10
                                : Colors.grey[200],
                            foregroundColor: isDark
                                ? Colors.white
                                : Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          icon: const Icon(Icons.code, size: 20),
                          label: const Text(
                            'GitHub 소스코드',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      if (project.homepage != null &&
                          project.homepage != 'null' &&
                          project.homepage!.isNotEmpty) ...[
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final uri = Uri.parse(project.homepage!);
                              if (await canLaunchUrl(uri)) await launchUrl(uri);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark
                                  ? AppColors.darkAccent
                                  : AppColors.lightAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            icon: const Icon(Icons.launch, size: 20),
                            label: const Text(
                              '라이브 웹 보러가기',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTechChip(String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.08) : Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isDark
              ? AppColors.darkTextPrimary
              : AppColors.lightTextPrimary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 800;
    final bool isTablet = screenSize.width >= 800 && screenSize.width < 1200;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: isDarkMode
          ? AppColors.darkPrimary
          : AppColors.lightPrimary,
      appBar: AppBar(
        title: Text(
          'DEV.PORTFOLIO',
          style: TextStyle(
            fontSize: 20,
            color: isDarkMode ? AppColors.lightPrimary : AppColors.darkPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        // 💡 1. 기본 배경과 오버레이를 완벽히 투명하게 뚫어줍니다.
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,

        // 💡 2. 앱바 뒤에 블러 필터를 장착합니다.
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            // sigmaX, sigmaY 값이 커질수록 뒤가 더 희미(뭉개짐)하게 보입니다. 10~15 사이를 추천합니다.
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              // 💡 3. 블러 필터 위에 아주 살짝 반투명한 베일을 얹어주어야 글래스 효과가 극대화됩니다.
              color: isDarkMode
                  ? AppColors.darkPrimary.withOpacity(0.7) // 다크모드일 때 어두운 반투명
                  : Colors.white.withOpacity(0.6), // 라이트모드일 때 밝은 반투명
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDarkMode
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
            onPressed: toggleTheme,
          ),
          if (!isMobile) ...[
            _navItem(
              'About',
              isDarkMode
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
            _navItem(
              'Projects',
              isDarkMode
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
            _navItem(
              'Contact',
              isDarkMode
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
            const SizedBox(width: 20),
          ],
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Hero section
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
                    '안녕하세요,',
                    style: TextStyle(
                      fontSize: isMobile ? 24 : 32,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode
                          ? AppColors.darkAccent
                          : AppColors.lightAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '앱 개발자 차부곤입니다!',
                    style: TextStyle(
                      fontSize: isMobile ? 40 : 64,
                      fontWeight: FontWeight.w800,
                      color: isDarkMode
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '사용자 경험을 중시하며, 실제 작동하는 웹 프리뷰 뷰어를 제공합니다.',
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.6,
                      color: isDarkMode
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Projects grid
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : screenSize.width * 0.1,
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isTablet
                    ? 2
                    : isMobile
                    ? 1
                    : 3,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                // 💡 수정 1: 웹 프리뷰 높이가 줄어들었으므로, 카드의 종횡비(가로 대비 세로 비율)를 더 늘려 세로를 슬림하게 만듭니다.
                // 값이 커질수록 카드의 세로 길이가 줄어듭니다.
                childAspectRatio: isMobile ? 0.78 : (isTablet ? 0.85 : 0.85),
              ),
              delegate: SliverChildBuilderDelegate((context, idx) {
                final Project project = projects[idx];
                return _buildProjectCard(project, isDarkMode, idx);
              }, childCount: projects.length),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Project project, bool isDark, int index) {
    final bool hasHomepage =
        project.homepage != null &&
        project.homepage!.isNotEmpty &&
        project.homepage != 'null';

    final String viewId = 'iframe-view-$index';

    if (hasHomepage) {
      ui_web.platformViewRegistry.registerViewFactory(viewId, (int viewId) {
        final element = web.HTMLIFrameElement()
          ..src = project.homepage!
          ..style.border = 'none'
          ..style.width = '1280px'
          // 💡 수정 2: 기존 800px에서 600px로 세로 가상 스크린 높이를 대폭 줄였습니다.
          // 이렇게 하면 데스크톱의 얇고 와이드한 모니터 비율로 예시가 축소 렌더링됩니다.
          ..style.height = '600px'
          ..style.transformOrigin = 'top left'
          ..style.pointerEvents = 'none';
        return element;
      });
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _showProjectDetailModal(context, project, isDark),
        child: Container(
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
                    ),
                  ],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. 상단 헤더 영역
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color:
                          (isDark
                                  ? AppColors.darkAccent
                                  : AppColors.lightAccent)
                              .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      hasHomepage ? Icons.language : Icons.code,
                      color: isDark
                          ? AppColors.darkAccent
                          : AppColors.lightAccent,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          "# ${project.stack}",
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // 2. 프로젝트 설명 영역
              Text(
                project.description,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 14),

              // 3. 미니어처 프리뷰 영역 (가로세로 비율 최적화 버전)
              AspectRatio(
                // 💡 가상 가로(1280)와 가상 세로(600)의 비율을 그대로 강제합니다. (약 2.13:1)
                // 이렇게 하면 브라우저 크기가 바뀌어도 이 칸은 언제나 웹사이트와 똑같은 비율로 늘어나고 줄어듭니다.
                aspectRatio: 1280 / 600,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark ? Colors.white10 : Colors.black12,
                    ),
                    color: isDark ? Colors.black26 : Colors.grey[50],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: hasHomepage
                        ? LayoutBuilder(
                            builder: (context, constraints) {
                              // 이제 constraints.maxWidth에 맞춰 scale을 구하면,
                              // AspectRatio 덕분에 높이도 딱 정확한 비율만큼 확보되어 있습니다.
                              final double scale = constraints.maxWidth / 1280;

                              return Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    width: 1280,
                                    height: 600,
                                    child: Transform.scale(
                                      scale: scale,
                                      alignment: Alignment.topLeft,
                                      child: HtmlElementView(viewType: viewId),
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        : Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.public_off,
                                  size: 32, // 카드가 슬림해졌으므로 아이콘 크기 살짝 조절
                                  color: isDark
                                      ? Colors.white24
                                      : Colors.black26,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '라이브 홍보 페이지가\n준비되지 않았습니다.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.4,
                                    color: isDark
                                        ? Colors.white38
                                        : Colors.black38,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isDark
                                          ? AppColors.darkAccent
                                          : AppColors.lightAccent,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        size: 12,
                                        color: isDark
                                            ? AppColors.darkAccent
                                            : AppColors.lightAccent,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '상세 정보 보기',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: isDark
                                              ? AppColors.darkAccent
                                              : AppColors.lightAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // 4. 하단 링크 영역
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // GitHub / repository link
                  Row(
                    children: [
                      Icon(
                        Icons.link,
                        size: 18,
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final uri = Uri.parse(project.link);
                            if (!await launchUrl(uri)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'GitHub 연결을 거부했습니다. URL: ${project.link}',
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            project.link,
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark ? Colors.white38 : Colors.black38,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Homepage link
                  if (hasHomepage) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.public,
                          size: 18,
                          color: isDark ? Colors.white38 : Colors.black38,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final uri = Uri.parse(project.homepage!);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              }
                            },
                            child: Text(
                              project.homepage!,
                              style: TextStyle(
                                fontSize: 13,
                                color: isDark ? Colors.white38 : Colors.black38,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
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
