import 'package:flutter/material.dart';

class NBox extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final Clip clipBehavior;

  const NBox({
    super.key,
    this.child,
    this.width,
    this.height,
    this.constraints,
    this.padding,
    this.margin,
    this.alignment,
    this.decoration,
    this.foregroundDecoration,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
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
      child: child,
    );
  }
}
