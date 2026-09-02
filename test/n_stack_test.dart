import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('nStack builds Flutter Stack directly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: <Widget>[
            const Text('Background'),
            const Text('Badge').nPositioned(top: 8, right: 8),
          ].nStack(
            width: 240,
            height: 160,
          ),
        ),
      ),
    );

    expect(find.byType(NStack), findsNothing);
    expect(find.byType(Stack), findsOneWidget);
    expect(find.text('Background'), findsOneWidget);
    expect(find.text('Badge'), findsOneWidget);
  });

  testWidgets('nStack forwards Stack configuration', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: <Widget>[
            const Text('A'),
            const Text('B'),
          ].nStack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            clipBehavior: Clip.none,
          ),
        ),
      ),
    );

    final stack = tester.widget<Stack>(find.byType(Stack));
    expect(stack.alignment, Alignment.center);
    expect(stack.fit, StackFit.expand);
    expect(stack.clipBehavior, Clip.none);
  });

  testWidgets('nStack does not create a Container only for Stack clipping', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: <Widget>[
            const Text('A'),
            const Text('B'),
          ].nStack(),
        ),
      ),
    );

    final stack = tester.widget<Stack>(find.byType(Stack));
    expect(stack.clipBehavior, Clip.hardEdge);
    expect(find.byType(Container), findsNothing);
  });
}
