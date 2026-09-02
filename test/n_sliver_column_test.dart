import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('renders children with vertical gaps inside a CustomScrollView', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              NSliverColumn(
                gap: 12,
                children: [
                  Text('One'),
                  Text('Two'),
                  Text('Three'),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('One'), findsOneWidget);
    expect(find.text('Two'), findsOneWidget);
    expect(find.text('Three'), findsOneWidget);
    expect(find.byType(SizedBox), findsNWidgets(2));
    expect(find.byType(SliverList), findsOneWidget);
  });

  testWidgets('wraps the sliver with padding when padding is provided', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              NSliverColumn(
                padding: EdgeInsets.all(16),
                children: [Text('Item')],
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(SliverPadding), findsOneWidget);
    expect(find.byType(SliverList), findsOneWidget);
  });

  testWidgets('iterable extension builds the same sliver layout', (tester) async {
    final children = <Widget>[
      const Text('A'),
      const Text('B'),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              children.nSliverColumn(gap: 8),
            ],
          ),
        ),
      ),
    );

    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
    expect(find.byType(SliverList), findsOneWidget);
  });

  testWidgets('builder creates items lazily with gaps', (tester) async {
    var buildCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 200,
            child: CustomScrollView(
              slivers: [
                NSliverColumn.builder(
                  itemCount: 100,
                  gap: 8,
                  itemBuilder: (context, index) {
                    buildCount++;
                    return SizedBox(
                      height: 60,
                      child: Text('Item $index'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Item 0'), findsOneWidget);
    expect(find.byType(SliverList), findsOneWidget);
    expect(buildCount, lessThan(100));
  });

  testWidgets('builder supports padding', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CustomScrollView(
          slivers: [
            NSliverColumn.builder(
              itemCount: 2,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) => Text('Item $index'),
            ),
          ],
        ),
      ),
    );

    expect(find.byType(SliverPadding), findsOneWidget);
    expect(find.text('Item 0'), findsOneWidget);
  });
}
