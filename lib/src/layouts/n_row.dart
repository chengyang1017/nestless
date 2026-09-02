import 'package:flutter/material.dart';

import '../extensions/widget_list_extensions.dart';
import '../extensions/widget_modifiers.dart';

class NRow extends StatelessWidget {
  final List<Widget> children;
  final double gap;

  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Decoration? decoration;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final Clip clipBehavior;

  const NRow({
    super.key,
    required this.children,
    this.gap = 0,
    this.width,
    this.height,
    this.constraints,
    this.padding,
    this.margin,
    this.alignment,
    this.decoration,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children.nWithGap(
        gap,
        axis: NGapAxis.horizontal,
      ),
    ).nBox(
      width: width,
      height: height,
      constraints: constraints,
      padding: padding,
      margin: margin,
      alignment: alignment,
      decoration: decoration,
      clipBehavior: clipBehavior,
    );
  }
}

extension NestlessRowExtensions on Iterable<Widget> {
  Widget nRow({
    double gap = 0,
    double? width,
    double? height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    AlignmentGeometry? alignment,
    Decoration? decoration,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.min,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    Clip clipBehavior = Clip.none,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: nWithGap(
        gap,
        axis: NGapAxis.horizontal,
      ),
    ).nBox(
      width: width,
      height: height,
      constraints: constraints,
      padding: padding,
      margin: margin,
      alignment: alignment,
      decoration: decoration,
      clipBehavior: clipBehavior,
    );
  }
}
