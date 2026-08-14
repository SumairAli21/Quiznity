import 'package:flutter/material.dart';

/// App-wide responsive helpers.
///
/// One consistent pattern for every screen: read the device class from
/// [BuildContext] and derive sizes from it instead of hardcoding pixels.
/// This replaces the per-screen `MediaQuery` boilerplate that used to be
/// copy-pasted across the project.
///
/// Usage:
/// ```dart
/// Text('Hi', style: TextStyle(fontSize: context.rf(18)));
/// Padding(padding: EdgeInsets.all(context.rs(16)), child: ...);
/// final cols = context.responsive(phone: 2, tablet: 3, landscape: 3);
/// ```
extension Responsive on BuildContext {
  // ── Raw metrics ────────────────────────────────────────────────────────
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  double get _shortestSide => screenSize.shortestSide;

  Orientation get deviceOrientation => MediaQuery.orientationOf(this);
  bool get isLandscape => deviceOrientation == Orientation.landscape;
  bool get isPortrait => !isLandscape;

  /// Bottom inset of the on-screen keyboard (0 when hidden).
  double get keyboardInset => MediaQuery.viewInsetsOf(this).bottom;
  bool get isKeyboardOpen => keyboardInset > 0;

  /// Height of the Android/iOS system navigation area at the bottom
  /// (gesture pill or 3-button bar). 0 on devices without one.
  ///
  /// Use this to keep bottom-anchored content that sits OUTSIDE a `SafeArea`
  /// — e.g. a `Positioned` FAB in a full-bleed `Stack` — clear of the OS
  /// navigation controls. Content already inside a `SafeArea` does not need
  /// it (the SafeArea has already reserved this inset).
  double get bottomSafeInset => MediaQuery.viewPaddingOf(this).bottom;

  // ── Device classes ─────────────────────────────────────────────────────

  /// Tablet or larger. Based on the shortest side, so a phone held in
  /// landscape is still treated as a phone (not a tablet).
  bool get isTablet => _shortestSide >= 600;

  /// Large tablet / desktop-class width.
  bool get isLargeTablet => _shortestSide >= 840;

  /// Height-constrained: small phones, or any phone in landscape.
  bool get isShort => screenHeight < 600;

  // ── Value pickers ──────────────────────────────────────────────────────

  /// Picks a value per device class. [tablet] and [landscape] fall back to
  /// [phone] when not supplied. [landscape] takes priority over [tablet].
  T responsive<T>({required T phone, T? tablet, T? landscape}) {
    if (isLandscape && landscape != null) return landscape;
    if (isTablet && tablet != null) return tablet;
    return phone;
  }

  /// Percentage (0-100) of screen width / height.
  double widthPercent(double percent) => screenWidth * (percent / 100);
  double heightPercent(double percent) => screenHeight * (percent / 100);

  // ── Scaled sizes ───────────────────────────────────────────────────────

  /// Responsive font size: grows gently on tablets, shrinks a little on
  /// height-constrained screens. Use for any `fontSize`.
  double rf(double base) {
    double scale;
    if (isLargeTablet) {
      scale = 1.22;
    } else if (isTablet) {
      scale = 1.14;
    } else if (isShort) {
      scale = 0.94;
    } else {
      scale = 1.0;
    }
    return base * scale;
  }

  /// Responsive spacing / padding: same idea as [rf] with a wider curve.
  /// Use for `SizedBox` gaps, `EdgeInsets`, icon sizes and small dimensions.
  double rs(double base) {
    double scale;
    if (isLargeTablet) {
      scale = 1.3;
    } else if (isTablet) {
      scale = 1.2;
    } else if (isShort) {
      scale = 0.82;
    } else {
      scale = 1.0;
    }
    return base * scale;
  }

  // ── Common layout values ───────────────────────────────────────────────

  /// Standard horizontal page padding.
  double get hPad {
    if (isTablet) return 32.0;
    return isLandscape ? 28.0 : 20.0;
  }

  /// Max width for forms / reading content so it stays comfortable and
  /// doesn't stretch edge-to-edge on tablets and wide landscape screens.
  double get contentMaxWidth => isTablet ? 640.0 : double.infinity;
}

/// Centers [child] and caps its width via [BuildContext.contentMaxWidth]
/// (overridable with [maxWidth]) so forms and reading content stay
/// comfortable on tablets and wide landscape screens. On phones it is a
/// transparent pass-through.
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;

  const ResponsiveContainer({super.key, required this.child, this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? context.contentMaxWidth,
        ),
        child: child,
      ),
    );
  }
}
