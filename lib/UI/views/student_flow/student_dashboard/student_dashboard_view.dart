import 'dart:math' as math;
import 'package:englify_app/UI/views/student_flow/student_dashboard/studen_dashboard_viewmodel.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StudentDashboardView extends StatelessWidget {
  const StudentDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;
    final isSmall = context.isShort;
    final isTablet = context.isTablet;

    return ViewModelBuilder<StudentDashboardViewmodel>.reactive(
      viewModelBuilder: () => StudentDashboardViewmodel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/dies_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.25)),
              ),
              SafeArea(
                child: model.isBusy
                    ? const Center(
                        child:
                            CircularProgressIndicator(color: Colors.white))
                    : SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 24 : 16,
                          vertical: isLandscape ? 8 : 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTopBar(context, model, isLandscape,
                                isTablet, isSmall),
                            SizedBox(height: isLandscape ? 12 : 20),
                            _buildStatsGrid(
                                model, isLandscape, isTablet),
                            SizedBox(height: isLandscape ? 12 : 20),

                            // landscape mein side by side
                            isLandscape
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: _buildContinueLearning(
                                              model, isTablet)),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child: _buildRewards(
                                              model, isTablet)),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      _buildContinueLearning(
                                          model, isTablet),
                                      SizedBox(
                                          height: isLandscape ? 12 : 20),
                                      _buildRewards(model, isTablet),
                                    ],
                                  ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context, StudentDashboardViewmodel model,
      bool isLandscape, bool isTablet, bool isSmall) {
    final picked = model.selectedDate;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Welcome back! ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isLandscape
                        ? (isTablet ? 20.0 : 16.0)
                        : (isTablet ? 26.0 : isSmall ? 18.0 : 20.0),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text('👋',
                    style: TextStyle(
                        fontSize: isLandscape ? 16.0 : 20.0)),
              ],
            ),
            const SizedBox(height: 2),
            // Surfaces the active day filter — otherwise the shrunken stats
            // look like a bug rather than a filtered view.
            picked == null
                ? Text(
                    'Learn and grow daily.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.80),
                      fontSize: isTablet ? 14.0 : isSmall ? 11.0 : 13.0,
                    ),
                  )
                : GestureDetector(
                    onTap: model.clearDateFilter,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${picked.day}/${picked.month}/${picked.year}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.90),
                            fontSize:
                                isTablet ? 14.0 : isSmall ? 11.0 : 13.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(Icons.close_rounded,
                            color: Colors.white.withOpacity(0.90),
                            size: isTablet ? 16 : 14),
                      ],
                    ),
                  ),
          ],
        ),
        GestureDetector(
          onTap: () => model.onCalendarTap(context),
          child: Container(
            padding: EdgeInsets.all(isTablet ? 12 : 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.calendar_today_rounded,
              color: const Color(0xFF2F6BFF),
              size: isTablet ? 24 : 22,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(StudentDashboardViewmodel model,
      bool isLandscape, bool isTablet) {
    final crossCount = isTablet
        ? (isLandscape ? 4 : 4)
        : (isLandscape ? 4 : 2);
    final aspectRatio = isTablet
        ? (isLandscape ? 1.4 : 1.2)
        : (isLandscape ? 1.4 : 1.3);

    return GridView.count(
      crossAxisCount: crossCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: isTablet ? 16 : 12,
      mainAxisSpacing: isTablet ? 16 : 12,
      childAspectRatio: aspectRatio,
      children: [
        _StatCard(
          topWidget: Icon(Icons.bar_chart_rounded,
              color: const Color(0xFF2F6BFF),
              size: isTablet ? 40 : 36),
          value: 'Level ${model.level}',
          label: 'Current Level',
        ),
        _StatCard(
          topWidget: Image.asset('assets/images/coins.png',
              height: isTablet ? 40 : 36,
              width: isTablet ? 40 : 36),
          value: '${model.totalPoints} pts',
          label: 'Total Points',
        ),
        _StatCard(
          topWidget: Icon(Icons.menu_book_rounded,
              color: const Color(0xFF7C3AED),
              size: isTablet ? 40 : 36),
          value: '${model.completedLessons}/${model.totalLessons}',
          label: 'Lessons Done',
        ),
        _StatCard(
          topWidget: Icon(Icons.star_rounded,
              color: const Color(0xFF16A34A),
              size: isTablet ? 40 : 36),
          value: '${model.performance.toStringAsFixed(0)}%',
          label: 'Performance',
        ),
      ],
    );
  }

  Widget _buildContinueLearning(
      StudentDashboardViewmodel model, bool isTablet) {
    final hasClass = model.topClassName.isNotEmpty;
    final score = model.topClassScore;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CONTINUE LEARNING',
            style: TextStyle(
              fontSize: isTablet ? 15 : 13,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            hasClass
                ? 'Resume and access new levels.'
                : 'No class joined yet.',
            style: TextStyle(
                fontSize: isTablet ? 13 : 12,
                color: Colors.grey[600]),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _PieChart(percentage: score / 100),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (hasClass)
                      Text(
                        model.topClassName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: isTablet ? 16 : 14,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: hasClass ? model.onContinueTap : null,
                      child: Row(
                        children: [
                          Icon(
                            Icons.play_arrow_rounded,
                            color: hasClass
                                ? const Color(0xFF2F6BFF)
                                : Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Continue',
                            style: TextStyle(
                              color: hasClass
                                  ? const Color(0xFF2F6BFF)
                                  : Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: isTablet ? 15 : 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRewards(
      StudentDashboardViewmodel model, bool isTablet) {
    final nextLevelPoints = model.level * 500;
    final progress =
        (model.totalPoints % nextLevelPoints) / nextLevelPoints;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 22 : 18),
      decoration: BoxDecoration(
        color: const Color(0xFF2F6BFF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REWARDS & MOTIVATION',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: isTablet ? 17 : 15,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• Level ${model.level + 1} Unlocked at $nextLevelPoints pts',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: isTablet ? 14 : 13),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: progress.clamp(0.0, 1.0),
                        minHeight: 8,
                        backgroundColor: Colors.white30,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${model.totalPoints} / $nextLevelPoints pts',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: isTablet ? 12 : 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final Widget topWidget;
  final String value;
  final String label;

  const _StatCard({
    required this.topWidget,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            topWidget,
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PieChart extends StatelessWidget {
  final double percentage;
  const _PieChart({required this.percentage});

  @override
  Widget build(BuildContext context) {
    final display = (percentage * 100).toStringAsFixed(0);
    return SizedBox(
      height: 72,
      width: 72,
      child: CustomPaint(
        painter: _PieChartPainter(percentage: percentage),
        child: Center(
          child: Text(
            '$display%',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final double percentage;
  _PieChartPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    const strokeWidth = 9.0;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.grey.shade200
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * percentage,
      false,
      Paint()
        ..color = const Color(0xFF2F6BFF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}