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

  void _showProjectDetailModal(
    BuildContext context,
    Project project,
    bool isDark,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) {
        final double screenWidth = MediaQuery.of(context).size.width;
        final bool isModalMobile = screenWidth < 700;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: isDark ? Colors.white10 : Colors.black12,
              width: 1,
            ),
          ),
          backgroundColor: isDark ? AppColors.darkSecondary : Colors.white,
          insetPadding: EdgeInsets.symmetric(
            horizontal: isModalMobile ? 20 : screenWidth * 0.2,
            vertical: 40,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        project.title,
                        style: TextStyle(
                          fontSize: isModalMobile ? 28 : 36,
                          fontWeight: FontWeight.w900,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.close_rounded,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(height: 1, thickness: 1),
                  const SizedBox(height: 32),
                  _buildSectionTitle('📌 프로젝트 소개', isDark),
                  const SizedBox(height: 12),
                  Text(
                    project.description,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.7,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildSectionTitle('🛠️ 사용 기술 및 도구', isDark),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildTechChip('Flutter', isDark),
                      _buildTechChip('Dart', isDark: isDark),
                      _buildTechChip('Firebase', isDark),
                      _buildTechChip('Git / GitHub', isDark),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          context: context,
                          icon: Icons.code_rounded,
                          label: 'GitHub 소스코드',
                          url: project.link,
                          isDark: isDark,
                          isPrimary: false,
                        ),
                      ),
                      if (project.homepage != null &&
                          project.homepage != 'null' &&
                          project.homepage!.isNotEmpty) ...[
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildActionButton(
                            context: context,
                            icon: Icons.language_rounded,
                            label: '라이브 웹 보기',
                            url: project.homepage!,
                            isDark: isDark,
                            isPrimary: true,
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

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: isDark
            ? AppColors.darkAccent
            : AppColors.lightAccent,
      ),
    );
  }

  Widget _buildTechChip(String label, {required bool isDark}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black12,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: isDark
              ? AppColors.darkTextPrimary
              : AppColors.lightTextPrimary,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String url,
    required bool isDark,
    required bool isPrimary,
  }) {
    return ElevatedButton.icon(
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary
            ? AppColors.accentGradient.colors[0]
            : (isDark ? Colors.white10 : Colors.black.withOpacity(0.05)),
        foregroundColor: isPrimary
            ? Colors.white
            : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isPrimary ? Colors.transparent : (isDark ? Colors.white10 : Colors.black12),
          ),
        ),
      ),
      icon: Icon(icon, size: 20),
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
            fontSize: 18,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w900,
            color: isDarkMode
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              color: isDarkMode
                  ? AppColors.darkPrimary.withOpacity(0.7)
                  : AppColors.lightPrimary.withOpacity(0.7),
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white10 : Colors.black.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                color: isDarkMode
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
              onPressed: toggleTheme,
            ),
          ),
          if (!isMobile) ...[
            _navItem('About', isDarkMode),
            _navItem('Projects', isDarkMode),
            _navItem('Contact', isDarkMode),
            const SizedBox(width: 20),
          ],
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Hero section with Spotlight Effect
          SliverToBoxAdapter(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1000),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : screenSize.width * 0.1,
                  vertical: 120,
                ),
                child: Stack(
                  children: [
                    // Spotlight Background
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: const Alignment(0, -0.5),
                            radius: 1.5,
                            colors: [
                              isDarkMode
                                  ? AppColors.darkAccent.withOpacity(0.15)
                                  : AppColors.lightAccent.withOpacity(0.1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '안녕하세요,',
                          style: TextStyle(
                            fontSize: isMobile ? 26 : 36,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? AppColors.darkAccent
                                : AppColors.lightAccent,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '앱 개발자 차부곤입니다!',
                          style: TextStyle(
                            fontSize: isMobile ? 48 : 72,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -2,
                            color: isDarkMode
                               ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: isDarkMode
                               ? Colors.white.withOpacity(0.05)
                                : Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDarkMode ? Colors.white10 : Colors.black12,
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            '사용자 경험을 중시하며, 실제 작동하는 웹 프리뷰를 제공합니다.',
                            style: TextStyle(
                              fontSize: 18,
                              height: 1.5,
                              color: isDarkMode
                                  ? AppColors.darkTextSecondary
                                 : AppColors.lightTextSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                crossAxisCount: isTablet ? 2 : isMobile ? 1 : 3,
                mainAxisSpacing: 32,
                crossAxisSpacing: 32,
                childAspectRatio: isMobile ? 0.85 : (isTablet ? 0.85 : 0.85),
              ),
              delegate: SliverChildBuilderDelegate((context, idx) {
                final Project project = projects[idx];
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 600 + (idx * 200)),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: _buildProjectCard(project, isDarkMode, idx),
                );
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
      ui_web.platformViewRegistry.registerViewFactory(viewLT_viewId(viewId), (int viewId) {
        final element = web.HTMLIFrameElement()
          ..src = project.homepage!
          ..style.border = 'none'
          ..style.width = '1280px'
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
            color: isDark ? AppColors.darkSecondary : AppColors.lightSecondary,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.black12,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      gradient: AppColors.accentGradient,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentGradient.colors[0].withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      hasHomepage ? Icons.language_rounded : Icons.code_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${project.stack.split(',').join(' / ')}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
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
              const SizedBox(height: 12),
              Text(
                project.description,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: isDark
                      ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              // Preview Area
              Container(
                height: 200, // Fixed height for better grid consistency
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? Colors.white10 : Colors.black12,
                    width: 0.5,
                  ),
                  color: isDark ? Colors.black26 : Colors.grey[100],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: hasHomepage
                      ? LayoutBuilder(
                          builder: (context, constraints) {
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
                          }
                        : Center(
                            child: Icon(
                              Icons.visibility_off_outlined,
                              size: 32,
                              color: isDark ? Colors.white24 : Colors.black26,
                            ),
                          ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSmallLink(
                    Icons.link_rounded,
                    project.link,
                    isDark,
                  ),
                  if (hasHomepage)
                    _buildSmallLink(
                      Icons.open_in_new_rounded,
                      'Live Demo',
                      isDark,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyPreview(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.visibility_off_outlined,
            size: 32,
            color: isDark ? Colors.white24 : Colors.black26,
          ),
          const SizedBox(height: 8),
          Text(
            'Preview Unavailable',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white38 : Colors.black338,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallLink(IconData icon, String label, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 14, color: isDark ? Colors.white38 : Colors.black38),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white38 : Colors.black38,
          ),
        ),
      ],
    );
  }

  Widget _navItem(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

// Helper to handle the viewId string formatting
String LT_viewId(String id) => id;
