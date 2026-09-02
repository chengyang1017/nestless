enum NBreakpoint {
  mobile,
  tablet,
  desktop,
}

class NBreakpoints {
  final double tablet;
  final double desktop;

  const NBreakpoints({
    this.tablet = 600,
    this.desktop = 1024,
  }) : assert(tablet > 0, 'tablet breakpoint must be greater than 0'),
       assert(desktop > tablet, 'desktop breakpoint must be greater than tablet breakpoint');

  NBreakpoint resolve(double width) {
    if (width < tablet) {
      return NBreakpoint.mobile;
    }

    if (width < desktop) {
      return NBreakpoint.tablet;
    }

    return NBreakpoint.desktop;
  }
}
