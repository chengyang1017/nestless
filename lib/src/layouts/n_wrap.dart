import 'package:flutter/material.dart';

import '../extensions/widget_modifiers.dart';

class NWrap extends StatelessWidget {
  final List<Widget> children;

  final double spacing;
  final double runSpacing;

  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;

  final Axis direction;
  final WrapAlignment alignment;
  final WrapAlignment runAlignment;
  final WrapCrossAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final Clip clipBehavior;

  const NWrap({
    super.key,
    required this.children,
    this.spacing = 0,
    this.runSpacing = 0,
    this.width,
    this.height,
    this.constraints,
    this.padding,
    this.margin,
    this.decoration,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: direction,
      alignment: alignment,
      runAlignment: runAlignment,
      spacing: spacing,
      runSpacing: runSpacing,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
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

// import 'package:flutter/material.dart';

// import 'n_box.dart';

// class NWrap extends StatelessWidget {
//   final List<Widget> children;
//   final double spacing;
//   final double runSpacing;
//   final double? width;
//   final double? height;
//   final BoxConstraints? constraints;
//   final EdgeInsetsGeometry? padding;
//   final EdgeInsetsGeometry? margin;
//   final Decoration? decoration;
//   final Axis direction;
//   final WrapAlignment alignment;
//   final WrapAlignment runAlignment;
//   final WrapCrossAlignment crossAxisAlignment;
//   final TextDirection? textDirection;
//   final VerticalDirection verticalDirection;
//   final Clip clipBehavior;

//   const NWrap({
//     super.key,
//     required this.children,
//     this.spacing = 0,
//     this.runSpacing = 0,
//     this.width,
//     this.height,
//     this.constraints,
//     this.padding,
//     this.margin,
//     this.decoration,
//     this.direction = Axis.horizontal,
//     this.alignment = WrapAlignment.start,
//     this.runAlignment = WrapAlignment.start,
//     this.crossAxisAlignment = WrapCrossAlignment.start,
//     this.textDirection,
//     this.verticalDirection = VerticalDirection.down,
//     this.clipBehavior = Clip.none,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return NBox(
//       width: width,
//       height: height,
//       constraints: constraints,
//       padding: padding,
//       margin: margin,
//       decoration: decoration,
//       clipBehavior: clipBehavior,
//       child: Wrap(
//         direction: direction,
//         alignment: alignment,
//         runAlignment: runAlignment,
//         spacing: spacing,
//         runSpacing: runSpacing,
//         crossAxisAlignment: crossAxisAlignment,
//         textDirection: textDirection,
//         verticalDirection: verticalDirection,
//         clipBehavior: clipBehavior,
//         children: children,
//       ),
//     );
//   }
// }
