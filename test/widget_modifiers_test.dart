import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('modifier order wraps inner to outer', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: const Text('Content').nPadAll(8).nWidth(200),
      ),
    );

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));

    expect(sizedBox.width, 200);
    expect(find.byType(Padding), findsOneWidget);
    expect(find.text('Content'), findsOneWidget);
  });

  testWidgets('nIf applies transform conditionally', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: const Text('Content').nIf(
          true,
          (child) => Padding(
            padding: const EdgeInsets.all(8),
            child: child,
          ),
        ),
      ),
    );

    expect(find.byType(Padding), findsOneWidget);
  });

  testWidgets('nOpacity wraps widget with Opacity', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: const Text('Hello').nOpacity(0.5),
      ),
    );

    final opacity = tester.widget<Opacity>(
      find.byType(Opacity),
    );

    expect(opacity.opacity, 0.5);
    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('nAspectRatio wraps widget with AspectRatio', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: const Text('Video').nAspectRatio(16 / 9),
      ),
    );

    final aspectRatio = tester.widget<AspectRatio>(
      find.byType(AspectRatio),
    );

    expect(aspectRatio.aspectRatio, 16 / 9);
    expect(find.text('Video'), findsOneWidget);
  });

  testWidgets('nTooltip wraps widget with Tooltip', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: const Text('Info').nTooltip(
            'More information',
          ),
        ),
      ),
    );

    final tooltip = tester.widget<Tooltip>(
      find.byType(Tooltip),
    );

    expect(tooltip.message, 'More information');
    expect(find.text('Info'), findsOneWidget);
  });
  testWidgets('nSafeArea wraps widget with SafeArea', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: const Text('Content').nSafeArea(),
      ),
    );

    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.text('Content'), findsOneWidget);
  });
}
