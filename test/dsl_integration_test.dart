import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('Nestless DSL composes stream list layout and navigation', (
    tester,
  ) async {
    final controller = StreamController<List<String>>();

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: [
                const Text('People').nPadAll(20),
                controller.stream
                    .nStream(
                      loading: const Text('Loading').nCenter(),
                      data: (users) => users
                          .where(
                            (user) => user.startsWith('A'),
                          )
                          .nList(
                            empty: const Text('No users').nCenter(),
                            item: (user) => ListTile(
                              title: Text(user),
                              onTap: () => context.nReplace(
                                _DetailPage(name: user),
                              ),
                            ),
                          ),
                    )
                    .nExpanded(),
              ].nColumn(),
            );
          },
        ),
      ),
    );

    expect(find.text('People'), findsOneWidget);
    expect(find.text('Loading'), findsOneWidget);

    controller.add([
      'Alice',
      'Bob',
      'Alex',
    ]);

    await tester.pump();
    await tester.pump();

    expect(find.text('Alice'), findsOneWidget);
    expect(find.text('Alex'), findsOneWidget);
    expect(find.text('Bob'), findsNothing);

    await controller.close();
    await tester.pump();

    await tester.tap(find.text('Alice'));
    await tester.pumpAndSettle();

    expect(find.text('Alice detail'), findsOneWidget);
    expect(find.text('People'), findsNothing);
  });
}

class _DetailPage extends StatelessWidget {
  final String name;

  const _DetailPage({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('$name detail'),
    );
  }
}
