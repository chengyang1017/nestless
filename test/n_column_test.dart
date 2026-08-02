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
}
