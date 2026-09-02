import 'package:flutter/material.dart';

extension NestlessWidgetModifiers on Widget {
  Widget nWidth(double width) => SizedBox(width: width, child: this);

  Widget nHeight(double height) => SizedBox(height: height, child: this);

  Widget nSize({double? width, double? height}) {
    if (width == null && height == null) {
      return this;
    }

    return SizedBox(width: width, height: height, child: this);
  }

  Widget nConstrained(BoxConstraints constraints) {
    return ConstrainedBox(constraints: constraints, child: this);
  }

  Widget nPadAll(double value) {
    assert(value >= 0, 'padding must not be negative');

    if (value == 0) {
      return this;
    }

    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Widget nPadSymmetric({double horizontal = 0, double vertical = 0}) {
    assert(horizontal >= 0, 'horizontal padding must not be negative');
    assert(vertical >= 0, 'vertical padding must not be negative');

    if (horizontal == 0 && vertical == 0) {
      return this;
    }

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
    assert(left >= 0, 'left padding must not be negative');
    assert(top >= 0, 'top padding must not be negative');
    assert(right >= 0, 'right padding must not be negative');
    assert(bottom >= 0, 'bottom padding must not be negative');

    if (left == 0 && top == 0 && right == 0 && bottom == 0) {
      return this;
    }

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

  Widget nExpanded({int flex = 1}) {
    assert(flex > 0, 'flex must be greater than 0');
    return Expanded(flex: flex, child: this);
  }

  Widget nFlexible({int flex = 1, FlexFit fit = FlexFit.loose}) {
    assert(flex > 0, 'flex must be greater than 0');
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
    final needsBox = width != null ||
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
    AlignmentGeometry alignment = Alignment.topCenter,
  }) {
    if (maxWidth == null) return this;

    assert(maxWidth >= 0, 'maxWidth must not be negative');

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
    EdgeInsetsGeometry padding = EdgeInsets.zero,
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

  Widget nSafeArea({
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
    EdgeInsets minimum = EdgeInsets.zero,
    bool maintainBottomViewPadding = false,
  }) {
    return SafeArea(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      minimum: minimum,
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: this,
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

    return nSafeArea(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      minimum: minimum,
      maintainBottomViewPadding: maintainBottomViewPadding,
    );
  }

  Widget nClipRRect({
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
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

  Widget nOpacity(
    double opacity, {
    bool alwaysIncludeSemantics = false,
  }) {
    assert(opacity >= 0 && opacity <= 1, 'opacity must be between 0 and 1');

    if (opacity == 1 && !alwaysIncludeSemantics) {
      return this;
    }

    return Opacity(
      opacity: opacity,
      alwaysIncludeSemantics: alwaysIncludeSemantics,
      child: this,
    );
  }

  Widget nAspectRatio(double aspectRatio) {
    assert(aspectRatio > 0, 'aspectRatio must be greater than 0');

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: this,
    );
  }

  Widget nTooltip(
    String message, {
    BoxConstraints? constraints,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? verticalOffset,
    bool? preferBelow,
    bool? excludeFromSemantics,
    Decoration? decoration,
    TextStyle? textStyle,
    TextAlign? textAlign,
    Duration? waitDuration,
    Duration? showDuration,
    Duration? exitDuration,
    bool enableTapToDismiss = true,
    TooltipTriggerMode? triggerMode,
    bool? enableFeedback,
    TooltipTriggeredCallback? onTriggered,
    MouseCursor? mouseCursor,
    bool? ignorePointer,
  }) {
    return Tooltip(
      message: message,
      constraints: constraints,
      padding: padding,
      margin: margin,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
      excludeFromSemantics: excludeFromSemantics,
      decoration: decoration,
      textStyle: textStyle,
      textAlign: textAlign,
      waitDuration: waitDuration,
      showDuration: showDuration,
      exitDuration: exitDuration,
      enableTapToDismiss: enableTapToDismiss,
      triggerMode: triggerMode,
      enableFeedback: enableFeedback,
      onTriggered: onTriggered,
      mouseCursor: mouseCursor,
      ignorePointer: ignorePointer,
      child: this,
    );
  }

  Widget nHero(
    Object tag, {
    CreateRectTween? createRectTween,
    HeroFlightShuttleBuilder? flightShuttleBuilder,
    HeroPlaceholderBuilder? placeholderBuilder,
    bool transitionOnUserGestures = false,
  }) {
    return Hero(
      tag: tag,
      createRectTween: createRectTween,
      flightShuttleBuilder: flightShuttleBuilder,
      placeholderBuilder: placeholderBuilder,
      transitionOnUserGestures: transitionOnUserGestures,
      child: this,
    );
  }
}
