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

  testWidgets('builder creates grid items lazily', (tester) async {
    var buildCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 220,
            child: CustomScrollView(
              slivers: [
                NSliverGrid.builder(
                  columns: 2,
                  itemCount: 100,
                  gap: 8,
                  mainAxisExtent: 80,
                  itemBuilder: (context, index) {
                    buildCount++;
                    return Text('Item $index');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Item 0'), findsOneWidget);
    expect(find.byType(SliverGrid), findsOneWidget);
    expect(buildCount, lessThan(100));
  });

  testWidgets('builder supports padding and configured columns', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CustomScrollView(
          slivers: [
            NSliverGrid.builder(
              columns: 3,
              itemCount: 6,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) => Text('Item $index'),
            ),
          ],
        ),
      ),
    );

    expect(find.byType(SliverPadding), findsOneWidget);

    final grid = tester.widget<SliverGrid>(find.byType(SliverGrid));
    final delegate =
        grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

    expect(delegate.crossAxisCount, 3);
  });
}
