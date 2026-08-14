import 'package:englify_app/UI/views/teacher_flow/teacher_dashboard/teacher_dashboad_viewmodel.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'dart:math' as math;

class TeacherDashboardView extends StatelessWidget {
  const TeacherDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;

    return ViewModelBuilder<TeacherDashboadViewmodel>.reactive(
      viewModelBuilder: () => TeacherDashboadViewmodel(),
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
                child:
                    Container(color: Colors.black.withOpacity(0.25)),
              ),
              SafeArea(
                child: model.isBusy
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: Colors.white))
                    : SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: isLandscape ? 8 : 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTopBar(context, model, isLandscape),
                            SizedBox(height: isLandscape ? 12 : 20),
                            _buildStatsGrid(context, model, isLandscape),
                            SizedBox(height: isLandscape ? 12 : 20),
                            // landscape mein side by side
                            isLandscape
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: _buildTopClassCard(
                                              model, isLandscape)),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child: _buildActivitySummary(
                                              model)),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      _buildTopClassCard(
                                          model, isLandscape),
                                      const SizedBox(height: 20),
                                      _buildActivitySummary(model),
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

  Widget _buildTopBar(
      BuildContext context, TeacherDashboadViewmodel model, bool isLandscape) {
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
                    fontFamily: 'heading',
                    fontSize: isLandscape ? 20 : 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text('👋',
                    style: TextStyle(
                        fontSize: isLandscape ? 20 : 26)),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Learn and grow daily.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.80),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => model.onCalendarTap(context),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_today_rounded,
              color: Color(0xFF2F6BFF),
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context,
      TeacherDashboadViewmodel model, bool isLandscape) {
    return GridView.count(
      crossAxisCount: isLandscape ? 4 : 2, // ✅ landscape mein 4 columns
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: isLandscape ? 1.4 : 1.3,
      children: [
        _StatCard(
          icon: Icons.class_rounded,
          iconColor: const Color(0xFF2F6BFF),
          value: '${model.totalClassrooms}',
          label: 'Total Classrooms',
          onTap: model.onClassroomsTap,
        ),
        _StatCard(
          icon: Icons.people_alt_rounded,
          iconColor: const Color(0xFFFFAA00),
          value: '${model.totalStudents}',
          label: 'Total Students',
          onTap: model.onStudentsTap,
        ),
        _StatCard(
          icon: Icons.group_rounded,
          iconColor: const Color(0xFF9B59B6),
          value: '${model.avgAttendance.toStringAsFixed(0)}%',
          label: 'Avg Attendance',
        ),
        _StatCard(
          icon: Icons.grade_rounded,
          iconColor: const Color(0xFF27AE60),
          value: '${model.avgScore.toStringAsFixed(0)}%',
          label: 'Avg Score',
          iconBgColor: const Color(0xFF27AE60),
          showBadge: true,
        ),
      ],
    );
  }

  Widget _buildTopClassCard(
      TeacherDashboadViewmodel model, bool isLandscape) {
    final topClass = model.topClass;
    final score = topClass?.averageScore ?? 0.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TOP PERFORMING CLASS',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            topClass?.className ?? '—',
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _PieChart(percentage: score / 100),
              const SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: model.onViewClassDetails,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F6BFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'View Class Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySummary(TeacherDashboadViewmodel model) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF2F6BFF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ACTIVITY SUMMARY',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 15,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          _summaryRow(
              '• Total Students', '${model.totalStudents}'),
          const SizedBox(height: 6),
          _summaryRow(
              '• Total Classrooms', '${model.totalClassrooms}'),
          const SizedBox(height: 6),
          _summaryRow('• Avg Attendance',
              '${model.avgAttendance.toStringAsFixed(0)}%'),
          const SizedBox(height: 6),
          _summaryRow('• Top Performing Class',
              model.topClass?.className ?? '—'),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style:
                const TextStyle(color: Colors.white70, fontSize: 13)),
        Flexible(
          child: Text(value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final VoidCallback? onTap;
  final Color? iconBgColor;
  final bool showBadge;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    this.onTap,
    this.iconBgColor,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    final isTappable = onTap != null;

    final card = Container(
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
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showBadge
                ? _buildBadgeIcon()
                : Icon(icon, color: iconColor, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            // The chevron is what tells these two cards apart from the inert
            // ones — without it they are pixel-identical and users tap the
            // dead ones expecting to navigate.
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isTappable) ...[
                  const SizedBox(width: 2),
                  Icon(Icons.chevron_right_rounded,
                      size: 16, color: Colors.grey[500]),
                ],
              ],
            ),
          ],
        ),
      ),
    );

    // No handler → no tap target at all, so an inert card cannot swallow a
    // press and pretend to be a button.
    if (!isTappable) return card;

    return GestureDetector(onTap: onTap, child: card);
  }

  Widget _buildBadgeIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF27AE60),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'A+',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 18,
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
      height: 80,
      width: 80,
      child: CustomPaint(
        painter: _PieChartPainter(percentage: percentage),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$display%',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const Text(
                'Avg Score',
                style: TextStyle(fontSize: 8, color: Colors.grey),
              ),
            ],
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
    const strokeWidth = 10.0;

    final bgPaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    final fgPaint = Paint()
      ..color = const Color(0xFF2F6BFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * percentage,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}