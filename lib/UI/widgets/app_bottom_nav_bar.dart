import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';

/// A single tab in [AppBottomNavBar].
class AppBottomNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const AppBottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

/// Shared bottom navigation bar used by both the student and teacher tab
/// shells.
///
/// Why this widget exists: a custom `Container` placed in
/// `Scaffold.bottomNavigationBar` does NOT automatically reserve the Android
/// system-navigation inset (gesture pill / 3-button bar). Without that, the
/// bar's content draws *underneath* the OS controls and they overlap.
///
/// The fix is global and lives here so every tab shell inherits it:
/// the decorated white surface (with its top shadow) paints edge-to-edge to
/// the very bottom of the screen, while a `SafeArea(top: false)` pushes the
/// actual tab row up above the system inset. On phones without an inset the
/// SafeArea collapses to zero, so the design is unchanged.
class AppBottomNavBar extends StatelessWidget {
  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color activeColor;

  const AppBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.activeColor = const Color(0xFF4C6FFF),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      // top: false  → keep the status-bar side untouched.
      // bottom: true → reserve the system-nav inset so the row never collides
      //                with gesture / 3-button controls.
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: context.rs(70),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < items.length; i++)
                _buildNavItem(context, items[i], i),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, AppBottomNavItem item, int index) {
    final bool isSelected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
              vertical: context.rs(8), horizontal: context.rs(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? item.activeIcon : item.icon,
                color: isSelected ? activeColor : Colors.grey[400],
                size: context.rs(26),
              ),
              if (isSelected) ...[
                SizedBox(height: context.rs(4)),
                // Shrink-to-fit so long labels (e.g. "Dashboard") never wrap to
                // a second line or clip on narrow phones. Single line always.
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    item.label,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: context.rf(12),
                      fontWeight: FontWeight.w600,
                      color: activeColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
