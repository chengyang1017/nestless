import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('nList renders empty widget when iterable is empty', (
    tester,
  ) async {
    final items = <String>[];

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: items.nList(
          empty: const Text('No items'),
          item: (value) => Text(value),
        ),
      ),
    );

    expect(find.text('No items'), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
  });

  testWidgets('nList renders iterable items', (tester) async {
    final items = [
      'A',
      'B',
      'C',
    ];

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: items.nList(
          item: (value) => Text(value),
        ),
      ),
    );

    expect(find.byType(ListView), findsOneWidget);

    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
    expect(find.text('C'), findsOneWidget);
  });

  testWidgets('nList supports filtered iterables directly', (tester) async {
    final items = [
      'Alice',
      'Bob',
      'Alex',
    ];

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: items
            .where(
              (value) => value.startsWith('A'),
            )
            .nList(
              item: (value) => Text(value),
            ),
      ),
    );

    expect(find.text('Alice'), findsOneWidget);
    expect(find.text('Alex'), findsOneWidget);
    expect(find.text('Bob'), findsNothing);
  });

  testWidgets('nSeparated renders separators between items', (tester) async {
    final items = [
      'A',
      'B',
      'C',
    ];

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: items.nSeparated(
          item: (value) => Text(value),
          separator: const SizedBox(
            height: 8,
          ),
        ),
      ),
    );

    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
    expect(find.text('C'), findsOneWidget);

    expect(
      find.byType(SizedBox),
      findsNWidgets(2),
    );
  });

  testWidgets('nSeparated renders empty widget when iterable is empty', (
    tester,
  ) async {
    final items = <String>[];

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: items.nSeparated(
          item: (value) => Text(value),
          separator: const SizedBox(
            height: 8,
          ),
          empty: const Text('Nothing here'),
        ),
      ),
    );

    expect(
      find.text('Nothing here'),
      findsOneWidget,
    );

    expect(
      find.byType(ListView),
      findsNothing,
    );
  });
}
