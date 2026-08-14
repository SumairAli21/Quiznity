import 'package:englify_app/UI/views/student_flow/bottom_navigation/bottom_navi_viewmodel.dart';
import 'package:englify_app/UI/widgets/app_bottom_nav_bar.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BottomNaviView extends StatelessWidget {
  const BottomNaviView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNaviViewmodel>.reactive(
      viewModelBuilder: () => BottomNaviViewmodel(),
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        body: IndexedStack(
          index: model.currentindex,
          children: model.pages,
        ),
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: model.currentindex,
          onTap: model.onindexchange,
          items: const [
            AppBottomNavItem(
              icon: Icons.school_outlined,
              activeIcon: Icons.school,
              label: 'Learning',
            ),
            AppBottomNavItem(
              icon: Icons.bar_chart_outlined,
              activeIcon: Icons.bar_chart,
              label: 'Dashboard',
            ),
            AppBottomNavItem(
              icon: Icons.bookmark_outline,
              activeIcon: Icons.bookmark,
              label: 'Favorites',
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