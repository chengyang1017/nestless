import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'n_grid.dart';

class NResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double minItemWidth;
  final int? maxColumns;
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

  const NResponsiveGrid({
    super.key,
    required this.children,
    required this.minItemWidth,
    this.maxColumns,
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
  }) : assert(minItemWidth > 0, 'minItemWidth must be greater than 0'),
       assert(maxColumns == null || maxColumns > 0, 'maxColumns must be greater than 0'),
       assert(gap >= 0, 'gap must not be negative'),
       assert(rowGap == null || rowGap >= 0, 'rowGap must not be negative'),
       assert(childAspectRatio > 0, 'childAspectRatio must be greater than 0');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final resolvedPadding = padding?.resolve(Directionality.of(context));
        final horizontalPadding =
            (resolvedPadding?.left ?? 0) + (resolvedPadding?.right ?? 0);
        final availableWidth = constraints.maxWidth.isFinite
            ? math.max(0.0, constraints.maxWidth - horizontalPadding)
            : minItemWidth;

        var columns = math.max(
          1,
          ((availableWidth + gap) / (minItemWidth + gap)).floor(),
        );

        if (maxColumns != null) {
          columns = math.min(columns, maxColumns!);
        }

        return NGrid(
          columns: columns,
          gap: gap,
          rowGap: rowGap,
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
      },
    );
  }
}

extension NestlessResponsiveGridExtensions on Iterable<Widget> {
  Widget nResponsiveGrid({
    required double minItemWidth,
    int? maxColumns,
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
    return NResponsiveGrid(
      minItemWidth: minItemWidth,
      maxColumns: maxColumns,
      gap: gap,
      rowGap: rowGap,
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
