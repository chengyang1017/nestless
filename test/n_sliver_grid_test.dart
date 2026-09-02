import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('NSliverGrid renders as a SliverGrid', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CustomScrollView(
          slivers: [
            NSliverGrid(
              columns: 2,
              gap: 12,
              children: [
                Text('A'),
                Text('B'),
                Text('C'),
              ],
            ),
          ],
        ),
      ),
    );

    expect(find.byType(SliverGrid), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
    expect(find.text('C'), findsOneWidget);
  });

  testWidgets('NSliverGrid wraps with SliverPadding when padding is set', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CustomScrollView(
          slivers: [
            NSliverGrid(
              columns: 2,
              padding: EdgeInsets.all(16),
              children: [Text('A')],
            ),
          ],
        ),
      ),
    );

    expect(find.byType(SliverPadding), findsOneWidget);
    expect(find.byType(SliverGrid), findsOneWidget);
  });

  testWidgets('nSliverGrid extension builds NSliverGrid', (tester) async {
    final children = <Widget>[
      const Text('A'),
      const Text('B'),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: CustomScrollView(
          slivers: [
            children.nSliverGrid(
              columns: 2,
              gap: 8,
            ),
          ],
        ),
      ),
    );

    expect(find.byType(NSliverGrid), findsOneWidget);
    expect(find.byType(SliverGrid), findsOneWidget);
  });
}
