// Generates the source images consumed by `flutter_launcher_icons`.
//
// Run with:  dart run tool/generate_launcher_icon_sources.dart
// Then with: dart run flutter_launcher_icons
//
// Why this step exists
// -------------------
// `assets/images/App_Icon.png` is a wide "QUIZNITY" wordmark centred on a
// square canvas. Dropping it straight into an Android adaptive icon would clip
// it: Android renders the 108dp foreground behind a mask that only guarantees
// the centre 72dp (66.6%) is visible, and the wordmark spans ~86% of the
// canvas width.
//
// So we:
//   1. Sample the flat canvas colour from the corners -> adaptive background.
//   2. Find the bounding box of the actual artwork (everything that is not
//      that canvas colour).
//   3. Re-lay the artwork out at a safe scale, preserving aspect ratio, onto
//      fresh square canvases:
//        - ic_launcher_foreground.png : artwork inside the centre 66% safe
//          zone, transparent elsewhere.
//        - ic_launcher_source.png     : artwork at 72% on the solid canvas
//          colour, for legacy (pre-API-26) square/round icons.
//
// Nothing here is ever stretched: a single uniform scale factor is applied to
// both axes.

import 'dart:io';

import 'package:image/image.dart' as img;

/// Edge length of the generated square sources. 1024 is the largest size any
/// launcher density needs (xxxhdpi foreground is 432px), so downscaling from
/// here is always lossless-enough.
const int kCanvas = 1024;

/// Fraction of the adaptive canvas Android guarantees to be visible.
const double kAdaptiveSafeZone = 0.66;

/// Fraction of the legacy canvas the artwork occupies. Legacy masks can be
/// circular too, so we stay comfortably inside.
const double kLegacyScale = 0.72;

const String kSource = 'assets/images/App_Icon.png';
const String kOutDir = 'assets/launcher_icon';

void main() {
  final sourceFile = File(kSource);
  if (!sourceFile.existsSync()) {
    stderr.writeln('Source icon not found: $kSource');
    exitCode = 1;
    return;
  }

  final decoded = img.decodeImage(sourceFile.readAsBytesSync());
  if (decoded == null) {
    stderr.writeln('Could not decode $kSource');
    exitCode = 1;
    return;
  }

  // Work in RGBA so alpha compositing below is well defined.
  final src = decoded.convert(numChannels: 4);
  stdout.writeln('Source: ${src.width}x${src.height}');

  final canvasColour = _sampleCanvasColour(src);
  stdout.writeln('Canvas colour: ${_toHex(canvasColour)}');

  final bounds = _artworkBounds(src, canvasColour);
  stdout.writeln(
    'Artwork bounds: x=${bounds.x} y=${bounds.y} '
    'w=${bounds.width} h=${bounds.height}',
  );

  final artwork = img.copyCrop(
    src,
    x: bounds.x,
    y: bounds.y,
    width: bounds.width,
    height: bounds.height,
  );

  Directory(kOutDir).createSync(recursive: true);

  _write(
    '$kOutDir/ic_launcher_foreground.png',
    _compose(artwork, kAdaptiveSafeZone, null),
  );
  _write(
    '$kOutDir/ic_launcher_source.png',
    _compose(artwork, kLegacyScale, canvasColour),
  );

  // Emitted so the value can be pasted into the adaptive background colour
  // resource; keeps the icon seamless where the foreground is transparent.
  stdout.writeln('\nAdaptive background colour: ${_toHex(canvasColour)}');
}

/// The flat colour the artwork sits on, taken as the median-ish sample of the
/// four corners. Corners are used because every launcher icon source pads its
/// artwork away from the edges.
img.Color _sampleCanvasColour(img.Image src) {
  final inset = (src.width * 0.01).round().clamp(1, src.width - 1);
  final samples = <img.Color>[
    src.getPixel(inset, inset),
    src.getPixel(src.width - 1 - inset, inset),
    src.getPixel(inset, src.height - 1 - inset),
    src.getPixel(src.width - 1 - inset, src.height - 1 - inset),
  ];

  var r = 0, g = 0, b = 0;
  for (final s in samples) {
    r += s.r.toInt();
    g += s.g.toInt();
    b += s.b.toInt();
  }
  return img.ColorRgba8(
    (r / samples.length).round(),
    (g / samples.length).round(),
    (b / samples.length).round(),
    255,
  );
}

/// Tightest rectangle containing every pixel that is meaningfully different
/// from [canvas] (or is not fully opaque). Falls back to the whole image when
/// the source has no flat border to trim.
({int x, int y, int width, int height}) _artworkBounds(img.Image src, img.Color canvas) {
  // Generous threshold: the canvas may carry a subtle gradient, which must not
  // be mistaken for artwork.
  const double threshold = 34.0;

  int minX = src.width, minY = src.height, maxX = -1, maxY = -1;

  for (var y = 0; y < src.height; y++) {
    for (var x = 0; x < src.width; x++) {
      final p = src.getPixel(x, y);
      final transparent = p.a < 250;
      final dr = (p.r - canvas.r).abs();
      final dg = (p.g - canvas.g).abs();
      final db = (p.b - canvas.b).abs();
      final differs = dr > threshold || dg > threshold || db > threshold;

      if (!transparent && !differs) continue;

      if (x < minX) minX = x;
      if (y < minY) minY = y;
      if (x > maxX) maxX = x;
      if (y > maxY) maxY = y;
    }
  }

  if (maxX < 0 || maxY < 0) {
    return (x: 0, y: 0, width: src.width, height: src.height);
  }
  return (x: minX, y: minY, width: maxX - minX + 1, height: maxY - minY + 1);
}

/// Places [artwork] centred on a [kCanvas]-square canvas, scaled uniformly so
/// its longest side occupies [scale] of the canvas. Aspect ratio is preserved
/// exactly; nothing is cropped. A null [background] leaves it transparent.
img.Image _compose(img.Image artwork, double scale, img.Color? background) {
  final target = kCanvas * scale;
  final factor = target / (artwork.width > artwork.height
      ? artwork.width
      : artwork.height);

  final w = (artwork.width * factor).round().clamp(1, kCanvas);
  final h = (artwork.height * factor).round().clamp(1, kCanvas);

  final scaled = img.copyResize(
    artwork,
    width: w,
    height: h,
    interpolation: img.Interpolation.cubic,
  );

  final canvas = img.Image(width: kCanvas, height: kCanvas, numChannels: 4);
  if (background == null) {
    img.fill(canvas, color: img.ColorRgba8(0, 0, 0, 0));
  } else {
    img.fill(canvas, color: background);
  }

  img.compositeImage(
    canvas,
    scaled,
    dstX: ((kCanvas - w) / 2).round(),
    dstY: ((kCanvas - h) / 2).round(),
  );
  return canvas;
}

void _write(String path, img.Image image) {
  File(path).writeAsBytesSync(img.encodePng(image));
  stdout.writeln('Wrote $path (${image.width}x${image.height})');
}

String _toHex(img.Color c) =>
    '#${c.r.toInt().toRadixString(16).padLeft(2, '0')}'
    '${c.g.toInt().toRadixString(16).padLeft(2, '0')}'
    '${c.b.toInt().toRadixString(16).padLeft(2, '0')}';
