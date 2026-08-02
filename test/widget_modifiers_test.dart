import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('modifier order wraps inner to outer', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: const Text('Content')
            .nPadAll(8)
            .nWidth(200),
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
}
