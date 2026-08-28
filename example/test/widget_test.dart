import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter_example/main.dart';

void main() {
  testWidgets('Nestless example renders', (tester) async {
    await tester.pumpWidget(
      const NestlessExampleApp(),
    );

    expect(
      find.text('Nestless Flutter'),
      findsOneWidget,
    );

    expect(
      find.text('Original Flutter'),
      findsOneWidget,
    );

    expect(
      find.text('Nestless layout'),
      findsOneWidget,
    );

    expect(
      find.text('Short modifier chain'),
      findsOneWidget,
    );
  });
}
