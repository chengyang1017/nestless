import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('NResponsiveGrid derives columns from available width', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 700,
            child: NResponsiveGrid(
              minItemWidth: 200,
              gap: 16,
              children: const [
                Text('1'),
                Text('2'),
                Text('3'),
              ],
            ),
          ),
        ),
      ),
    );

    final grid = tester.widget<GridView>(find.byType(GridView));
    final delegate = grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

    expect(delegate.crossAxisCount, 3);
    expect(delegate.crossAxisSpacing, 16);
    expect(delegate.mainAxisSpacing, 16);
  });

  testWidgets('NResponsiveGrid respects maxColumns', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 1200,
            child: NResponsiveGrid(
              minItemWidth: 200,
              maxColumns: 4,
              gap: 16,
              children: const [
                Text('1'),
                Text('2'),
                Text('3'),
                Text('4'),
              ],
            ),
          ),
        ),
      ),
    );

    final grid = tester.widget<GridView>(find.byType(GridView));
    final delegate = grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

    expect(delegate.crossAxisCount, 4);
  });

  testWidgets('NResponsiveGrid.builder derives columns and builds lazily', (tester) async {
    var builtCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 700,
            height: 300,
            child: NResponsiveGrid.builder(
              minItemWidth: 200,
              gap: 16,
              itemCount: 100,
              itemBuilder: (context, index) {
                builtCount++;
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

    final grid = tester.widget<GridView>(find.byType(GridView));
    final delegate = grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

    expect(delegate.crossAxisCount, 3);
    expect(builtCount, lessThan(100));
    expect(find.text('Item 0'), findsOneWidget);
  });

  testWidgets('NResponsiveGrid.builder respects maxColumns and padding', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 1200,
            height: 400,
            child: NResponsiveGrid.builder(
              minItemWidth: 180,
              maxColumns: 4,
              gap: 12,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Text('Product $index');
              },
            ),
          ),
        ),
      ),
    );

    final grid = tester.widget<GridView>(find.byType(GridView));
    final delegate = grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

    expect(delegate.crossAxisCount, 4);
    expect(grid.padding, const EdgeInsets.symmetric(horizontal: 24));
  });
}
