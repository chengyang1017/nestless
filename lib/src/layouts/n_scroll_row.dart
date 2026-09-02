import 'package:flutter/material.dart';

import '../extensions/widget_modifiers.dart';
import 'n_row.dart';

class NScrollRow extends StatelessWidget {
  final List<Widget> children;
  final double gap;

  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Decoration? decoration;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;

  final ScrollController? controller;
  final ScrollPhysics? physics;
  final bool reverse;
  final Clip clipBehavior;

  const NScrollRow({
    super.key,
    required this.children,
    this.gap = 0,
    this.width,
    this.height,
    this.constraints,
    this.padding = EdgeInsets.zero,
    this.margin,
    this.alignment,
    this.decoration,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.controller,
    this.physics,
    this.reverse = false,
    this.clipBehavior = Clip.hardEdge,
  }) : assert(gap >= 0, 'gap must not be negative');

  @override
  Widget build(BuildContext context) {
    return children
        .nRow(
          gap: gap,
          constraints: constraints,
          margin: margin,
          alignment: alignment,
          decoration: decoration,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
        )
        .nScrollX(
          controller: controller,
          physics: physics,
          padding: padding,
          reverse: reverse,
          clipBehavior: clipBehavior,
        )
        .nSize(
          width: width,
          height: height,
        );
  }
}
