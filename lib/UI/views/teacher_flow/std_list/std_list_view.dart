import 'package:englify_app/UI/views/teacher_flow/std_list/std_viewmodel.dart';
import 'package:englify_app/services/dashboard_service.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StudentsListView extends StatelessWidget {
  final String teacherId;
  const StudentsListView({super.key, required this.teacherId});

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;

    return ViewModelBuilder<StudentsListViewmodel>.reactive(
      viewModelBuilder: () => StudentsListViewmodel(teacherId: teacherId),
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
                child: Column(
                  children: [
                    // App bar
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: isLandscape ? 6 : 12,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: model.onBack,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.arrow_back,
                                  color: Colors.black, size: 20),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Students',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: context.rf(20)),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: model.togglesearch,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                model.issearching
                                    ? Icons.close_rounded
                                    : Icons.tune_rounded,
                                color: const Color(0xFF2F6BFF),
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Name filter — revealed by the tune button above
                    if (model.issearching)
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            16, 0, 16, isLandscape ? 6 : 10),
                        child: TextField(
                          controller: model.searchcontroller,
                          onChanged: model.onsearchchanged,
                          autofocus: true,
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 15),
                          decoration: InputDecoration(
                            hintText: 'Search students by name',
                            hintStyle: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                            prefixIcon: const Icon(Icons.search,
                                color: Colors.grey, size: 20),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.95),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            // BorderSide.none opts a field out of the themed
                            // focus ring entirely, so it is set explicitly here.
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                  color: Color(0xFF2F6BFF), width: 1.6),
                            ),
                          ),
                        ),
                      ),

                    // List
                    Expanded(
                      child: model.isBusy
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white))
                          : model.students.isEmpty
                              ? Center(
                                  child: Text(
                                      model.hasnomatches
                                          ? 'No students match that name.'
                                          : 'No students yet.',
                                      style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15)),
                                )
                              : isLandscape
                                  // ✅ landscape mein 2 column grid
                                  ? GridView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 12,
                                        childAspectRatio: 2.8,
                                      ),
                                      itemCount: model.students.length,
                                      itemBuilder: (context, index) {
                                        return _StudentCard(
                                          student: model.students[index],
                                          isLandscape: true,
                                          onTap: () => model.onStudentTap(
                                              model.students[index].studentId),
                                        );
                                      },
                                    )
                                  // portrait mein normal list
                                  : ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      itemCount: model.students.length,
                                      itemBuilder: (context, index) {
                                        return _StudentCard(
                                          student: model.students[index],
                                          isLandscape: false,
                                          onTap: () => model.onStudentTap(
                                              model.students[index].studentId),
                                        );
                                      },
                                    ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StudentCard extends StatelessWidget {
  final StudentSummary student;
  final VoidCallback onTap;
  final bool isLandscape;

  const _StudentCard({
    required this.student,
    required this.onTap,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: isLandscape ? 0 : 12),
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: isLandscape ? 10 : 14,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 8,
                offset: const Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: isLandscape ? 28 : 42,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: student.profileImage.isNotEmpty
                  ? NetworkImage(student.profileImage)
                  : null,
              child: student.profileImage.isEmpty
                  ? Icon(Icons.person,
                      color: Colors.grey,
                      size: isLandscape ? 24 : 36)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    student.name,
                    style: TextStyle(
                      fontSize: isLandscape ? 14 : 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    student.classNames.join(', '),
                    style: TextStyle(
                        fontSize: 12, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (!isLandscape) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _InfoChip(
                          icon: Icons.bar_chart_rounded,
                          iconColor: const Color(0xFF2F6BFF),
                          label: 'Lvl ${student.level}',
                        ),
                        const SizedBox(width: 12),
                        _CoinsChip(points: student.totalPoints),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: Colors.grey, size: 22),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;

  const _InfoChip(
      {required this.icon,
      required this.iconColor,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 16),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(
                fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}

class _CoinsChip extends StatelessWidget {
  final int points;
  const _CoinsChip({required this.points});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/coins.png', height: 16, width: 16),
        const SizedBox(width: 4),
        Text('$points Points',
            style: const TextStyle(
                fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}