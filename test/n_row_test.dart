import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('nRow composes Row directly and inserts horizontal gaps', (
    tester,
  ) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: [
          const Text('Avatar'),
          const Text('Username'),
          const Text('Menu'),
        ].nRow(gap: 10),
      ),
    );

    expect(find.byType(NRow), findsNothing);
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(SizedBox), findsNWidgets(2));
    expect(find.text('Avatar'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Menu'), findsOneWidget);
  });

  testWidgets('nRow keeps wrapper options without requiring NRow', (
    tester,
  ) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: [
          const Text('A'),
          const Text('B'),
        ].nRow(
          gap: 8,
          width: 240,
          padding: const EdgeInsets.all(16),
        ),
      ),
    );

    expect(find.byType(NRow), findsNothing);
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Padding), findsOneWidget);
    expect(find.byType(SizedBox), findsWidgets);
  });
}
