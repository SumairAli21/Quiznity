import 'dart:math' as math;

import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';

/// Which Quiznity wordmark to draw.
enum AppLogoVariant {
  /// White wordmark. For dark backgrounds (splash, photo backdrops).
  light,

  /// Blue wordmark. For light backgrounds (white form screens).
  blue,
}

/// The Quiznity wordmark, sized responsively and never distorted.
///
/// Why this widget exists
/// ----------------------
/// Both brand assets are 500x500 canvases with the wordmark sitting in a
/// centred band that is only **73.6% wide and 24.4% tall**. Sizing them the
/// obvious way — `Image.asset(logo, height: 65)` — therefore produced a
/// wordmark barely 16 logical pixels tall inside a 65px square, with the rest
/// dead space. Screens compensated with heights like 150, which then ate the
/// viewport on small phones and overflowed rows in landscape.
///
/// [AppLogo] instead treats the asset as a sprite sheet: it renders a
/// wordmark-shaped box and uses `BoxFit.cover` to crop the empty canvas away.
/// `cover` on a box wider than the (square) source scales purely by width, so
/// the aspect ratio is preserved exactly — the image is only ever cropped
/// vertically into the dead margin, never stretched, and the wordmark itself
/// is never touched.
///
/// Size is derived from the screen width rather than a hardcoded height, and
/// clamped to whatever space the parent actually offers, so the logo tracks
/// the device across small phones, tablets and landscape without per-screen
/// branching.
///
/// ```dart
/// const AppLogo(variant: AppLogoVariant.blue)                  // header
/// const AppLogo.splash()                                       // splash
/// AppLogo(widthFactor: 0.4, maxWidth: 240)                     // compact
/// ```
class AppLogo extends StatelessWidget {
  /// Fraction of the available width the logo should occupy, before clamping.
  final double widthFactor;

  /// Lower bound so the wordmark stays legible on narrow phones.
  final double minWidth;

  /// Upper bound so the wordmark does not balloon on tablets.
  final double maxWidth;

  final AppLogoVariant variant;

  const AppLogo({
    super.key,
    this.variant = AppLogoVariant.light,
    this.widthFactor = 0.46,
    this.minWidth = 132,
    this.maxWidth = 260,
  });

  /// Large, centred treatment for the splash screen. The factor is tuned so the
  /// wordmark renders at least as large as the old fixed 250px square did,
  /// while shedding the ~190px of empty canvas that square carried.
  const AppLogo.splash({super.key})
    : variant = AppLogoVariant.light,
      widthFactor = 0.70,
      minWidth = 200,
      maxWidth = 480;

  /// Compact treatment for screen headers that share a row with a button.
  ///
  /// The factor looks large next to [splash] because only 73.6% of the drawn
  /// box is wordmark — the rest is the source canvas the `cover` crop keeps as
  /// margin. A 0.47 box yields a wordmark about 35% of the screen wide.
  const AppLogo.header({super.key, this.variant = AppLogoVariant.light})
    : widthFactor = 0.47,
      minWidth = 150,
      maxWidth = 220;

  // ── Asset geometry ───────────────────────────────────────────────────────
  // Measured from the shipped 500x500 PNGs: the wordmark occupies a 368x122
  // band centred at (0.499, 0.513) of the canvas.

  /// Width : height of the box we draw. Slightly wider than the wordmark's own
  /// 3.02 ratio so a little of the canvas is kept as breathing room instead of
  /// the crop shaving the glyph edges.
  static const double _boxAspect = 3.28;

  /// Vertical alignment that puts the wordmark band in the centre of the box.
  /// The visible band is 1/3.28 = 30.5% of the source height, so its centre
  /// sits at `0.5 + y * (1 - 0.305) / 2`; solving for 0.513 gives 0.037.
  static const double _alignY = 0.037;

  static const double _wordmarkWidthFraction = 0.736;

  String get _asset => switch (variant) {
    AppLogoVariant.light => 'assets/images/applogo.png',
    AppLogoVariant.blue => 'assets/images/applogo_blue.png',
  };

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Inside a Row/Stack the incoming width can be unbounded; fall back to
        // the screen so we never try to size against infinity.
        final available = constraints.maxWidth.isFinite && constraints.maxWidth > 0
            ? constraints.maxWidth
            : context.screenWidth;

        // The target tracks the SCREEN, not the slot we were handed. Inside a
        // `Flexible` beside a button the slot is only the leftover width, so
        // sizing from it made the logo depend on how wide that button happened
        // to be — which pinned every phone from 360dp to 430dp to the same
        // `minWidth` floor instead of scaling.
        final target = context.screenWidth * widthFactor;

        // `available` still acts as the ceiling, so a genuinely narrow parent
        // shrinks the logo rather than overflowing it.
        final upper = math.min(context.rs(maxWidth), available);
        final lower = math.min(context.rs(minWidth), upper);
        final width = target.clamp(lower, upper);

        return SizedBox(
          width: width,
          height: width / _boxAspect,
          child: Image.asset(
            _asset,
            fit: BoxFit.cover,
            alignment: const Alignment(0, _alignY),
            semanticLabel: 'Quiznity',
          ),
        );
      },
    );
  }

  /// Width the wordmark itself will occupy for a given box [width]. Exposed for
  /// callers that need to reserve space around it.
  static double wordmarkWidth(double width) => width * _wordmarkWidthFraction;
}
