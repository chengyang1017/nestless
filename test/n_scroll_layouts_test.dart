import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('NScrollColumn composes Column and vertical scroll view', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SizedBox(
          width: 320,
          height: 240,
          child: NScrollColumn(
            gap: 12,
            clipBehavior: Clip.none,
            children: [
              Text('A'),
              Text('B'),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(NColumn), findsNothing);

    final scrollView = tester.widget<SingleChildScrollView>(
      find.byType(SingleChildScrollView),
    );

    expect(scrollView.scrollDirection, Axis.vertical);
    expect(scrollView.clipBehavior, Clip.none);
  });

  testWidgets('NScrollRow composes Row and horizontal scroll view', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SizedBox(
          width: 320,
          height: 120,
          child: NScrollRow(
            gap: 12,
            children: [
              Text('A'),
              Text('B'),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(NRow), findsNothing);

    final scrollView = tester.widget<SingleChildScrollView>(
      find.byType(SingleChildScrollView),
    );

    expect(scrollView.scrollDirection, Axis.horizontal);
  });
}
