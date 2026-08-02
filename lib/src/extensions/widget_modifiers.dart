import 'package:flutter/material.dart';

extension NestlessWidgetModifiers on Widget {
  Widget nWidth(double width) => SizedBox(width: width, child: this);

  Widget nHeight(double height) => SizedBox(height: height, child: this);

  Widget nSize({double? width, double? height}) {
    return SizedBox(width: width, height: height, child: this);
  }

  Widget nConstrained(BoxConstraints constraints) {
    return ConstrainedBox(constraints: constraints, child: this);
  }

  Widget nPadAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Widget nPadSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: this,
    );
  }

  Widget nPadOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  Widget nAlign(AlignmentGeometry alignment) {
    return Align(alignment: alignment, child: this);
  }

  Widget nCenter({double? widthFactor, double? heightFactor}) {
    return Center(
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }

  Widget nScrollY({
  ScrollController? controller,
  ScrollPhysics? physics,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
  bool reverse = false,
  Clip clipBehavior = Clip.hardEdge,
}) {
  return SingleChildScrollView(
    controller: controller,
    physics: physics,
    padding: padding,
    reverse: reverse,
    clipBehavior: clipBehavior,
    child: this,
  );
}

  Widget nScrollX({
  ScrollController? controller,
  ScrollPhysics? physics,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
  bool reverse = false,
  Clip clipBehavior = Clip.hardEdge,
}) {
  return SingleChildScrollView(
    controller: controller,
    physics: physics,
    padding: padding,
    reverse: reverse,
    clipBehavior: clipBehavior,
    scrollDirection: Axis.horizontal,
    child: this,
  );
}

  Widget nExpanded({int flex = 1}) => Expanded(flex: flex, child: this);

  Widget nFlexible({int flex = 1, FlexFit fit = FlexFit.loose}) {
    return Flexible(flex: flex, fit: fit, child: this);
  }

  Widget nOnTap(
    VoidCallback? onTap, {
    HitTestBehavior behavior = HitTestBehavior.opaque,
  }) {
    return GestureDetector(
      behavior: behavior,
      onTap: onTap,
      child: this,
    );
  }

  Widget nVisible(
    bool visible, {
    Widget replacement = const SizedBox.shrink(),
  }) {
    return Visibility(
      visible: visible,
      replacement: replacement,
      child: this,
    );
  }

  Widget nIf(
    bool condition,
    Widget Function(Widget child) transform,
  ) {
    return condition ? transform(this) : this;
  }

  Widget nBox({
  double? width,
  double? height,
  BoxConstraints? constraints,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  AlignmentGeometry? alignment,
  Decoration? decoration,
  Decoration? foregroundDecoration,
  Clip clipBehavior = Clip.none,
}) {
  final needsBox =
      width != null ||
      height != null ||
      constraints != null ||
      padding != null ||
      margin != null ||
      alignment != null ||
      decoration != null ||
      foregroundDecoration != null ||
      clipBehavior != Clip.none;

  if (!needsBox) {
    return this;
  }

  return Container(
    width: width,
    height: height,
    constraints: constraints,
    padding: padding,
    margin: margin,
    alignment: alignment,
    decoration: decoration,
    foregroundDecoration: foregroundDecoration,
    clipBehavior: clipBehavior,
    child: this,
  );
}

Widget nMaxWidth(
  double? maxWidth, {
  AlignmentGeometry alignment =
      Alignment.topCenter,
}) {
  if (maxWidth == null) return this;

  return ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: maxWidth,
    ),
    child: this,
  ).nAlign(alignment);
}

Widget nScrollYIf(
  bool enabled, {
  ScrollController? controller,
  ScrollPhysics? physics,
  EdgeInsetsGeometry padding =
      EdgeInsets.zero,
  bool reverse = false,
  Clip clipBehavior = Clip.hardEdge,
}) {
  if (!enabled) return this;

  return nScrollY(
    controller: controller,
    physics: physics,
    padding: padding,
    reverse: reverse,
    clipBehavior: clipBehavior,
  );
}

Widget nSafeAreaIf(
  bool enabled, {
  bool left = true,
  bool top = true,
  bool right = true,
  bool bottom = true,
  EdgeInsets minimum = EdgeInsets.zero,
  bool maintainBottomViewPadding = false,
}) {
  if (!enabled) return this;

  return SafeArea(
    left: left,
    top: top,
    right: right,
    bottom: bottom,
    minimum: minimum,
    maintainBottomViewPadding:
        maintainBottomViewPadding,
    child: this,
  );
}

Widget nClipRRect({
  BorderRadiusGeometry borderRadius =
      BorderRadius.zero,
  Clip clipBehavior = Clip.antiAlias,
}) {
  return ClipRRect(
    borderRadius: borderRadius,
    clipBehavior: clipBehavior,
    child: this,
  );
}

Widget nPositioned({
  double? left,
  double? top,
  double? right,
  double? bottom,
  double? width,
  double? height,
}) {
  return Positioned(
    left: left,
    top: top,
    right: right,
    bottom: bottom,
    width: width,
    height: height,
    child: this,
  );
}
}
