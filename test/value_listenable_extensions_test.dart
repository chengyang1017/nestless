import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('nValue renders current value', (tester) async {
    final notifier = ValueNotifier<int>(1);

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: notifier.nValue(
          data: (value) => Text('$value'),
        ),
      ),
    );

    expect(find.text('1'), findsOneWidget);

    notifier.dispose();
  });

  testWidgets('nValue rebuilds when value changes', (tester) async {
    final notifier = ValueNotifier<int>(1);

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: notifier.nValue(
          data: (value) => Text('$value'),
        ),
      ),
    );

    notifier.value = 2;

    await tester.pump();

    expect(find.text('1'), findsNothing);
    expect(find.text('2'), findsOneWidget);

    notifier.dispose();
  });
}
