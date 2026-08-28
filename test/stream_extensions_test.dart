import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('nStream shows loading before data arrives', (tester) async {
    final controller = StreamController<String>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: controller.stream.nStream(
          loading: const Text('Loading'),
          data: (value) => Text(value),
        ),
      ),
    );

    expect(find.text('Loading'), findsOneWidget);

    await controller.close();
  });

  testWidgets('nStream renders stream data', (tester) async {
    final controller = StreamController<String>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: controller.stream.nStream(
          loading: const Text('Loading'),
          data: (value) => Text(value),
        ),
      ),
    );

    controller.add('Hello Nestless');

    await tester.pump();
    await tester.pump();

    expect(find.text('Hello Nestless'), findsOneWidget);
    expect(find.text('Loading'), findsNothing);

    await controller.close();
  });

  testWidgets('nStream renders custom error widget', (tester) async {
    final controller = StreamController<String>();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: controller.stream.nStream(
          data: (value) => Text(value),
          error: (error, stackTrace) => const Text('Failed'),
        ),
      ),
    );

    controller.addError(Exception('Boom'));

    await tester.pump();
    await tester.pump();

    expect(find.text('Failed'), findsOneWidget);

    await controller.close();
  });
}
