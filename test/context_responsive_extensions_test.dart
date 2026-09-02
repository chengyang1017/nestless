import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestless_flutter/nestless_flutter.dart';

void main() {
  testWidgets('reports responsive breakpoint from MediaQuery width', (tester) async {
    NBreakpoint? breakpoint;
    bool? isMobile;
    bool? isTablet;
    bool? isDesktop;

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(
            size: Size(800, 600),
          ),
          child: Builder(
            builder: (context) {
              breakpoint = context.nBreakpoint();
              isMobile = context.nIsMobile;
              isTablet = context.nIsTablet;
              isDesktop = context.nIsDesktop;
              return const SizedBox();
            },
          ),
        ),
      ),
    );

    expect(breakpoint, NBreakpoint.tablet);
    expect(isMobile, isFalse);
    expect(isTablet, isTrue);
    expect(isDesktop, isFalse);
  });

  testWidgets('supports custom breakpoint resolution from context', (tester) async {
    NBreakpoint? breakpoint;

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(
            size: Size(700, 600),
          ),
          child: Builder(
            builder: (context) {
              breakpoint = context.nBreakpoint(
                breakpoints: const NBreakpoints(
                  tablet: 500,
                  desktop: 700,
                ),
              );
              return const SizedBox();
            },
          ),
        ),
      ),
    );

    expect(breakpoint, NBreakpoint.desktop);
  });
}
