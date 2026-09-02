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
}
