import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('NColumn inserts vertical gaps', (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: NColumn(
          gap: 12,
          children: [
            Text('A'),
            Text('B'),
            Text('C'),
          ],
        ),
      ),
    );

    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(SizedBox), findsNWidgets(2));
  });

  testWidgets('NColumn skips gaps for one child', (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: NColumn(
          gap: 12,
          children: [Text('Only')],
        ),
      ),
    );

    expect(find.byType(SizedBox), findsNothing);
  });

  testWidgets('nColumn composes Flutter widgets directly', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: [
          const Text('A'),
          const Text('B'),
          const Text('C'),
        ].nColumn(
          gap: 12,
        ),
      ),
    );

    expect(find.byType(NColumn), findsNothing);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(SizedBox), findsNWidgets(2));

    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
    expect(find.text('C'), findsOneWidget);
  });
}
