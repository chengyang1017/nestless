import 'package:flutter/material.dart';

import '../extensions/widget_modifiers.dart';

class NStack extends StatelessWidget {
  final List<Widget> children;

  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;

  final AlignmentGeometry alignment;
  final StackFit fit;
  final TextDirection? textDirection;
  final Clip clipBehavior;

  const NStack({
    super.key,
    required this.children,
    this.width,
    this.height,
    this.constraints,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment = AlignmentDirectional.topStart,
    this.fit = StackFit.loose,
    this.textDirection,
    this.clipBehavior = Clip.hardEdge,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: alignment,
      fit: fit,
      textDirection: textDirection,
      clipBehavior: clipBehavior,
      children: children,
    ).nBox(
      width: width,
      height: height,
      constraints: constraints,
      padding: padding,
      margin: margin,
      decoration: decoration,
      clipBehavior: clipBehavior,
    );
  }
}