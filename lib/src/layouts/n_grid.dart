import 'package:flutter/material.dart';

class NGrid extends StatelessWidget {
  final List<Widget> children;
  final int columns;
  final double gap;
  final double? rowGap;
  final EdgeInsetsGeometry? padding;
  final double childAspectRatio;
  final double? mainAxisExtent;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final bool primary;
  final bool reverse;

  const NGrid({
    super.key,
    required this.children,
    required this.columns,
    this.gap = 0,
    this.rowGap,
    this.padding,
    this.childAspectRatio = 1,
    this.mainAxisExtent,
    this.shrinkWrap = false,
    this.physics,
    this.controller,
    this.primary = false,
    this.reverse = false,
  }) : assert(columns > 0, 'columns must be greater than 0'),
       assert(gap >= 0, 'gap must not be negative'),
       assert(rowGap == null || rowGap >= 0, 'rowGap must not be negative'),
       assert(childAspectRatio > 0, 'childAspectRatio must be greater than 0');

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: columns,
      crossAxisSpacing: gap,
      mainAxisSpacing: rowGap ?? gap,
      padding: padding,
      childAspectRatio: childAspectRatio,
      mainAxisExtent: mainAxisExtent,
      shrinkWrap: shrinkWrap,
      physics: physics,
      controller: controller,
      primary: primary,
      reverse: reverse,
      children: children,
    );
  }
}

Widget nGridBuilder({
  required int columns,
  required int itemCount,
  required NullableIndexedWidgetBuilder itemBuilder,
  double gap = 0,
  double? rowGap,
  EdgeInsetsGeometry? padding,
  double childAspectRatio = 1,
  double? mainAxisExtent,
  bool shrinkWrap = false,
  ScrollPhysics? physics,
  ScrollController? controller,
  bool primary = false,
  bool reverse = false,
}) {
  assert(columns > 0, 'columns must be greater than 0');
  assert(itemCount >= 0, 'itemCount must not be negative');
  assert(gap >= 0, 'gap must not be negative');
  assert(rowGap == null || rowGap >= 0, 'rowGap must not be negative');
  assert(childAspectRatio > 0, 'childAspectRatio must be greater than 0');

  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: columns,
      crossAxisSpacing: gap,
      mainAxisSpacing: rowGap ?? gap,
      childAspectRatio: childAspectRatio,
      mainAxisExtent: mainAxisExtent,
    ),
    itemCount: itemCount,
    itemBuilder: itemBuilder,
    padding: padding,
    shrinkWrap: shrinkWrap,
    physics: physics,
    controller: controller,
    primary: primary,
    reverse: reverse,
  );
}

extension NestlessGridExtensions on Iterable<Widget> {
  Widget nGrid({
    required int columns,
    double gap = 0,
    double? rowGap,
    EdgeInsetsGeometry? padding,
    double childAspectRatio = 1,
    double? mainAxisExtent,
    bool shrinkWrap = false,
    ScrollPhysics? physics,
    ScrollController? controller,
    bool primary = false,
    bool reverse = false,
  }) {
    assert(columns > 0, 'columns must be greater than 0');
    assert(gap >= 0, 'gap must not be negative');
    assert(rowGap == null || rowGap >= 0, 'rowGap must not be negative');
    assert(childAspectRatio > 0, 'childAspectRatio must be greater than 0');

    return GridView.count(
      crossAxisCount: columns,
      crossAxisSpacing: gap,
      mainAxisSpacing: rowGap ?? gap,
      padding: padding,
      childAspectRatio: childAspectRatio,
      mainAxisExtent: mainAxisExtent,
      shrinkWrap: shrinkWrap,
      physics: physics,
      controller: controller,
      primary: primary,
      reverse: reverse,
      children: toList(growable: false),
    );
  }
}
