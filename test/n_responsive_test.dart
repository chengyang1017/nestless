import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  Widget appWithWidth(double width) {
    return MaterialApp(
      home: Center(
        child: SizedBox(
          width: width,
          child: const NResponsive(
            mobile: Text('mobile'),
            tablet: Text('tablet'),
            desktop: Text('desktop'),
          ),
        ),
      ),
    );
  }

  testWidgets('shows mobile layout below tablet breakpoint', (tester) async {
    await tester.pumpWidget(appWithWidth(599));

    expect(find.text('mobile'), findsOneWidget);
    expect(find.text('tablet'), findsNothing);
    expect(find.text('desktop'), findsNothing);
  });

  testWidgets('shows tablet layout between tablet and desktop breakpoints', (tester) async {
    await tester.pumpWidget(appWithWidth(800));

    expect(find.text('mobile'), findsNothing);
    expect(find.text('tablet'), findsOneWidget);
    expect(find.text('desktop'), findsNothing);
  });

  testWidgets('shows desktop layout at desktop breakpoint and above', (tester) async {
    await tester.pumpWidget(appWithWidth(1200));

    expect(find.text('mobile'), findsNothing);
    expect(find.text('tablet'), findsNothing);
    expect(find.text('desktop'), findsOneWidget);
  });

  testWidgets('supports custom breakpoints', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 700,
            child: const NResponsive(
              breakpoints: NBreakpoints(
                tablet: 500,
                desktop: 700,
              ),
              mobile: Text('mobile'),
              tablet: Text('tablet'),
              desktop: Text('desktop'),
            ),
          ),
        ),
      ),
    );

    expect(find.text('desktop'), findsOneWidget);
  });
}
