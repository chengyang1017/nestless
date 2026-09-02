import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('NGrid builds a fixed-column grid with configured spacing', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 360,
            height: 360,
            child: NGrid(
              columns: 3,
              gap: 12,
              rowGap: 20,
              children: [
                Text('A'),
                Text('B'),
                Text('C'),
                Text('D'),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
    expect(find.text('D'), findsOneWidget);

    final grid = tester.widget<GridView>(find.byType(GridView));
    final delegate = grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

    expect(delegate.crossAxisCount, 3);
    expect(delegate.crossAxisSpacing, 12);
    expect(delegate.mainAxisSpacing, 20);
  });

  testWidgets('nGrid extension creates NGrid from an iterable', (tester) async {
    final children = [const Text('One'), const Text('Two')];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 300,
            height: 300,
            child: children.nGrid(columns: 2, gap: 8),
          ),
        ),
      ),
    );

    expect(find.byType(NGrid), findsOneWidget);
    expect(find.text('One'), findsOneWidget);
    expect(find.text('Two'), findsOneWidget);
  });
}
