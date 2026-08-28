import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('nReplace replaces current page', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: TextButton(
                onPressed: () {
                  context.nReplace(
                    const _SecondPage(),
                  );
                },
                child: const Text('Go'),
              ),
            );
          },
        ),
      ),
    );

    expect(find.text('Go'), findsOneWidget);
    expect(find.text('Second page'), findsNothing);

    await tester.tap(find.text('Go'));
    await tester.pumpAndSettle();

    expect(find.text('Go'), findsNothing);
    expect(find.text('Second page'), findsOneWidget);
  });
}

class _SecondPage extends StatelessWidget {
  const _SecondPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Second page'),
      ),
    );
  }
}
