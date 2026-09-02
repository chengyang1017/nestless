import 'package:flutter/material.dart';

import '../responsive/n_breakpoint.dart';

extension NestlessContextResponsiveExtensions on BuildContext {
  double get nWidth => MediaQuery.sizeOf(this).width;

  NBreakpoint nBreakpoint({
    NBreakpoints breakpoints = const NBreakpoints(),
  }) {
    return breakpoints.resolve(nWidth);
  }

  bool get nIsMobile => nBreakpoint() == NBreakpoint.mobile;

  bool get nIsTablet => nBreakpoint() == NBreakpoint.tablet;

  bool get nIsDesktop => nBreakpoint() == NBreakpoint.desktop;
}
