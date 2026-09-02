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

  testWidgets('nGrid extension returns GridView directly', (tester) async {
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

    expect(find.byType(NGrid), findsNothing);
    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('One'), findsOneWidget);
    expect(find.text('Two'), findsOneWidget);
  });

  testWidgets('nGridBuilder returns GridView.builder with configured delegate', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 360,
            height: 360,
            child: nGridBuilder(
              columns: 3,
              itemCount: 6,
              gap: 12,
              rowGap: 20,
              itemBuilder: (context, index) {
                return Text('Item $index');
              },
            ),
          ),
        ),
      ),
    );

    expect(find.byType(NGrid), findsNothing);
    expect(find.byType(GridView), findsOneWidget);

    final grid = tester.widget<GridView>(find.byType(GridView));
    final delegate = grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

    expect(delegate.crossAxisCount, 3);
    expect(delegate.crossAxisSpacing, 12);
    expect(delegate.mainAxisSpacing, 20);
  });

  testWidgets('nGridBuilder builds items lazily', (tester) async {
    var buildCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 320,
            height: 240,
            child: nGridBuilder(
              columns: 2,
              itemCount: 100,
              itemBuilder: (context, index) {
                buildCount += 1;
                return SizedBox(
                  height: 100,
                  child: Text('Item $index'),
                );
              },
            ),
          ),
        ),
      ),
    );

    expect(buildCount, lessThan(100));
    expect(find.text('Item 0'), findsOneWidget);
  });
}
