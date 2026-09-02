import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('nWrap builds Flutter Wrap directly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: <Widget>[
            const Chip(label: Text('Dart')),
            const Chip(label: Text('Flutter')),
            const Chip(label: Text('Nestless')),
          ].nWrap(
            spacing: 8,
            runSpacing: 12,
          ),
        ),
      ),
    );

    expect(find.byType(NWrap), findsNothing);
    expect(find.byType(Wrap), findsOneWidget);
    expect(find.text('Dart'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Nestless'), findsOneWidget);
  });

  testWidgets('nWrap forwards Wrap configuration', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: <Widget>[
            const Text('A'),
            const Text('B'),
          ].nWrap(
            spacing: 10,
            runSpacing: 14,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
          ),
        ),
      ),
    );

    final wrap = tester.widget<Wrap>(find.byType(Wrap));
    expect(wrap.spacing, 10);
    expect(wrap.runSpacing, 14);
    expect(wrap.alignment, WrapAlignment.center);
    expect(wrap.runAlignment, WrapAlignment.end);
    expect(wrap.crossAxisAlignment, WrapCrossAlignment.center);
  });
}
