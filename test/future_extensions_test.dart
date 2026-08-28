import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('nFuture shows loading before future completes', (
    tester,
  ) async {
    final completer = Completer<String>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: completer.future.nFuture(
          loading: const Text('Loading'),
          data: (value) => Text(value),
        ),
      ),
    );

    expect(find.text('Loading'), findsOneWidget);

    completer.complete('Done');

    await tester.pump();
  });

  testWidgets('nFuture renders completed data', (
    tester,
  ) async {
    final completer = Completer<String>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: completer.future.nFuture(
          loading: const Text('Loading'),
          data: (value) => Text(value),
        ),
      ),
    );

    completer.complete('Hello Future');

    await tester.pump();
    await tester.pump();

    expect(
      find.text('Hello Future'),
      findsOneWidget,
    );

    expect(
      find.text('Loading'),
      findsNothing,
    );
  });

  testWidgets('nFuture renders custom error widget', (
    tester,
  ) async {
    final completer = Completer<String>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: completer.future.nFuture(
          data: (value) => Text(value),
          error: (error, stackTrace) {
            return const Text('Failed');
          },
        ),
      ),
    );

    completer.completeError(
      Exception('Boom'),
    );

    await tester.pump();
    await tester.pump();

    expect(
      find.text('Failed'),
      findsOneWidget,
    );
  });
}
