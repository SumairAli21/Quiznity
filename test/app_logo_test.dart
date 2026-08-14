import 'package:englify_app/UI/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Device sizes the logo has to survive, in logical pixels.
const _devices = <String, Size>{
  'small phone portrait': Size(320, 568),
  'normal phone portrait': Size(390, 844),
  'large phone portrait': Size(430, 932),
  'small phone landscape': Size(568, 320),
  'normal phone landscape': Size(844, 390),
  'tablet portrait': Size(768, 1024),
  'tablet landscape': Size(1024, 768),
  'large tablet portrait': Size(1024, 1366),
};

/// The wordmark occupies a 368x122 band of the 500x500 source, so the drawn
/// box must keep this ratio for the artwork to be undistorted.
const _boxAspect = 3.28;

Future<void> _pump(WidgetTester tester, Size size, Widget child) async {
  tester.view
    ..physicalSize = size
    ..devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(home: Scaffold(body: SafeArea(child: child))),
  );
}

Size _logoSize(WidgetTester tester) =>
    tester.getSize(find.byType(AppLogo).first);

void main() {
  group('AppLogo geometry', () {
    for (final entry in _devices.entries) {
      testWidgets('${entry.key}: aspect preserved and inside viewport', (
        tester,
      ) async {
        await _pump(tester, entry.value, const Center(child: AppLogo()));

        final size = _logoSize(tester);

        // Aspect ratio is fixed, so the artwork can never stretch.
        expect(
          size.width / size.height,
          closeTo(_boxAspect, 0.02),
          reason: 'logo box must keep its aspect ratio',
        );

        // Never wider or taller than the screen it sits on.
        expect(size.width, lessThanOrEqualTo(entry.value.width));
        expect(size.height, lessThanOrEqualTo(entry.value.height));

        // Never collapses to something unreadable.
        expect(size.width, greaterThan(100));
      });
    }

    testWidgets('image is drawn with cover fit and never distorts', (
      tester,
    ) async {
      await _pump(tester, const Size(390, 844), const Center(child: AppLogo()));

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.fit, BoxFit.cover);
      expect(image.semanticLabel, 'Quiznity');
    });

    testWidgets('blue variant selects the blue asset', (tester) async {
      await _pump(
        tester,
        const Size(390, 844),
        const Center(child: AppLogo(variant: AppLogoVariant.blue)),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(
        (image.image as AssetImage).assetName,
        'assets/images/applogo_blue.png',
      );
    });

    testWidgets('splash logo scales up but stays on screen', (tester) async {
      for (final entry in _devices.entries) {
        await _pump(
          tester,
          entry.value,
          const Center(child: AppLogo.splash()),
        );
        final size = _logoSize(tester);
        expect(
          size.width,
          lessThanOrEqualTo(entry.value.width),
          reason: 'splash logo overflowed on ${entry.key}',
        );
        expect(size.width / size.height, closeTo(_boxAspect, 0.02));
      }
    });
  });

  group('AppLogo in a header row', () {
    // Mirrors the real layout: logo on the left, action button on the right.
    Widget headerRow() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(child: AppLogo.header()),
          ElevatedButton(onPressed: () {}, child: const Text('Back')),
        ],
      ),
    );

    for (final entry in _devices.entries) {
      testWidgets('${entry.key}: header row does not overflow', (tester) async {
        await _pump(tester, entry.value, headerRow());

        // A RenderFlex overflow surfaces as a framework exception; assert none
        // was recorded for this frame.
        expect(tester.takeException(), isNull);

        final size = _logoSize(tester);
        expect(size.width, lessThan(entry.value.width));
        expect(size.width / size.height, closeTo(_boxAspect, 0.02));
      });
    }

    testWidgets('shrinks rather than overflowing an extremely narrow row', (
      tester,
    ) async {
      await _pump(
        tester,
        const Size(320, 568),
        const SizedBox(width: 140, child: Row(children: [Flexible(child: AppLogo.header())])),
      );

      expect(tester.takeException(), isNull);
      expect(_logoSize(tester).width, lessThanOrEqualTo(140));
    });
  });
}
