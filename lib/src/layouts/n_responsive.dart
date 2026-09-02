import 'package:flutter/material.dart';

import '../responsive/n_breakpoint.dart';

class NResponsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final NBreakpoints breakpoints;

  const NResponsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
    this.breakpoints = const NBreakpoints(),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        switch (breakpoints.resolve(constraints.maxWidth)) {
          case NBreakpoint.mobile:
            return mobile;
          case NBreakpoint.tablet:
            return tablet;
          case NBreakpoint.desktop:
            return desktop;
        }
      },
    );
  }
}
