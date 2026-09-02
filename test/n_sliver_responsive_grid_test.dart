import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('NSliverResponsiveGrid derives columns from viewport width', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(700, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: CustomScrollView(
          slivers: [
            NSliverResponsiveGrid(
              minItemWidth: 200,
              gap: 16,
              children: [
                Text('A'),
                Text('B'),
                Text('C'),
                Text('D'),
              ],
            ),
          ],
        ),
      ),
    );

    final grid = tester.widget<SliverGrid>(find.byType(SliverGrid));
    final delegate =
        grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

    expect(delegate.crossAxisCount, 3);
    expect(delegate.crossAxisSpacing, 16);
    expect(delegate.mainAxisSpacing, 16);
  });

  testWidgets('NSliverResponsiveGrid respects maxColumns and padding', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: CustomScrollView(
          slivers: [
            NSliverResponsiveGrid(
              minItemWidth: 180,
              maxColumns: 4,
              gap: 12,
              padding: EdgeInsets.symmetric(horizontal: 24),
              children: [
                Text('A'),
                Text('B'),
                Text('C'),
                Text('D'),
              ],
            ),
          ],
        ),
      ),
    );

    expect(find.byType(SliverPadding), findsOneWidget);

    final grid = tester.widget<SliverGrid>(find.byType(SliverGrid));
    final delegate =
        grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

    expect(delegate.crossAxisCount, 4);
  });

  testWidgets('nSliverResponsiveGrid extension creates the layout', (
    tester,
  ) async {
    final children = [const Text('One'), const Text('Two')];

    await tester.pumpWidget(
      MaterialApp(
        home: CustomScrollView(
          slivers: [
            children.nSliverResponsiveGrid(
              minItemWidth: 180,
              gap: 8,
            ),
          ],
        ),
      ),
    );

    expect(find.byType(NSliverResponsiveGrid), findsOneWidget);
    expect(find.text('One'), findsOneWidget);
    expect(find.text('Two'), findsOneWidget);
  });
}
