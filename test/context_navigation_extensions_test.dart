import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('nPush pushes a new page', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: TextButton(
                onPressed: () {
                  context.nPush(
                    const _SecondPage(),
                  );
                },
                child: const Text('Push'),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Push'));
    await tester.pumpAndSettle();

    expect(find.text('Second page'), findsOneWidget);
  });

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
                child: const Text('Replace'),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Replace'));
    await tester.pumpAndSettle();

    expect(find.text('Replace'), findsNothing);
    expect(find.text('Second page'), findsOneWidget);
  });

  testWidgets('nPop pops current page', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: _PushAndPopPage(),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text('Close'), findsOneWidget);

    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    expect(find.text('Open'), findsOneWidget);
    expect(find.text('Close'), findsNothing);
  });

  testWidgets('nCanPop reports navigator state', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: _CanPopPage(),
      ),
    );

    expect(find.text('Can pop: false'), findsOneWidget);

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text('Can pop: true'), findsOneWidget);
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

class _PushAndPopPage extends StatelessWidget {
  const _PushAndPopPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            context.nPush(
              Builder(
                builder: (context) {
                  return Scaffold(
                    body: Center(
                      child: TextButton(
                        onPressed: context.nPop,
                        child: const Text('Close'),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          child: const Text('Open'),
        ),
      ),
    );
  }
}

class _CanPopPage extends StatelessWidget {
  const _CanPopPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Can pop: ${context.nCanPop}',
            ),
            TextButton(
              onPressed: () {
                context.nPush(
                  Builder(
                    builder: (context) {
                      return Scaffold(
                        body: Center(
                          child: Text(
                            'Can pop: ${context.nCanPop}',
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              child: const Text('Open'),
            ),
          ],
        ),
      ),
    );
  }
}
