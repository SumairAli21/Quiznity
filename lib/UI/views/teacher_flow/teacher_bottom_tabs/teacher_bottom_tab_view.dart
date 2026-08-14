import 'package:englify_app/UI/views/teacher_flow/teacher_bottom_tabs/teacher_bottom_tab_viewmodel.dart';
import 'package:englify_app/UI/widgets/app_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TeacherBottomTabView extends StatelessWidget {
  const TeacherBottomTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TeacherBottomTabViewmodel>.reactive(
      viewModelBuilder: () => TeacherBottomTabViewmodel(),
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        body: IndexedStack(index: model.currentindex, children: model.pages),
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: model.currentindex,
          onTap: model.onindexchange,
          items: const [
            AppBottomNavItem(
              icon: Icons.bar_chart_outlined,
              activeIcon: Icons.bar_chart,
              label: 'Dashboard',
            ),
            AppBottomNavItem(
              icon: Icons.school_outlined,
              activeIcon: Icons.school,
              label: 'Classes',
            ),
            AppBottomNavItem(
              icon: Icons.fact_check_outlined,
              activeIcon: Icons.fact_check,
              label: 'Tracker',
            ),
            AppBottomNavItem(
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
