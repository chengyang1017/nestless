import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'n_sliver_grid.dart';

class NSliverResponsiveGrid extends StatelessWidget {
  final List<Widget>? children;
  final NullableIndexedWidgetBuilder? itemBuilder;
  final int? itemCount;
  final double minItemWidth;
  final int? maxColumns;
  final double gap;
  final double? rowGap;
  final EdgeInsetsGeometry? padding;
  final double childAspectRatio;
  final double? mainAxisExtent;

  const NSliverResponsiveGrid({
    super.key,
    required List<Widget> children,
    required this.minItemWidth,
    this.maxColumns,
    this.gap = 0,
    this.rowGap,
    this.padding,
    this.childAspectRatio = 1,
    this.mainAxisExtent,
  })  : children = children,
        itemBuilder = null,
        itemCount = null,
        assert(minItemWidth > 0, 'minItemWidth must be greater than 0'),
        assert(maxColumns == null || maxColumns > 0, 'maxColumns must be greater than 0'),
        assert(gap >= 0, 'gap must not be negative'),
        assert(rowGap == null || rowGap >= 0, 'rowGap must not be negative'),
        assert(childAspectRatio > 0, 'childAspectRatio must be greater than 0');

  const NSliverResponsiveGrid.builder({
    super.key,
    required int itemCount,
    required NullableIndexedWidgetBuilder itemBuilder,
    required this.minItemWidth,
    this.maxColumns,
    this.gap = 0,
    this.rowGap,
    this.padding,
    this.childAspectRatio = 1,
    this.mainAxisExtent,
  })  : children = null,
        itemBuilder = itemBuilder,
        itemCount = itemCount,
        assert(itemCount >= 0, 'itemCount must not be negative'),
        assert(minItemWidth > 0, 'minItemWidth must be greater than 0'),
        assert(maxColumns == null || maxColumns > 0, 'maxColumns must be greater than 0'),
        assert(gap >= 0, 'gap must not be negative'),
        assert(rowGap == null || rowGap >= 0, 'rowGap must not be negative'),
        assert(childAspectRatio > 0, 'childAspectRatio must be greater than 0');

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final resolvedPadding = padding?.resolve(Directionality.of(context));
        final horizontalPadding =
            (resolvedPadding?.left ?? 0) + (resolvedPadding?.right ?? 0);
        final availableWidth = math.max(
          0.0,
          constraints.crossAxisExtent - horizontalPadding,
        );

        var columns = math.max(
          1,
          ((availableWidth + gap) / (minItemWidth + gap)).floor(),
        );

        if (maxColumns != null) {
          columns = math.min(columns, maxColumns!);
        }

        if (itemBuilder != null) {
          return NSliverGrid.builder(
            columns: columns,
            itemCount: itemCount!,
            itemBuilder: itemBuilder!,
            gap: gap,
            rowGap: rowGap,
            padding: padding,
            childAspectRatio: childAspectRatio,
            mainAxisExtent: mainAxisExtent,
          );
        }

        return NSliverGrid(
          columns: columns,
          gap: gap,
          rowGap: rowGap,
          padding: padding,
          childAspectRatio: childAspectRatio,
          mainAxisExtent: mainAxisExtent,
          children: children!,
        );
      },
    );
  }
}

extension NestlessSliverResponsiveGridExtensions on Iterable<Widget> {
  Widget nSliverResponsiveGrid({
    required double minItemWidth,
    int? maxColumns,
    double gap = 0,
    double? rowGap,
    EdgeInsetsGeometry? padding,
    double childAspectRatio = 1,
    double? mainAxisExtent,
  }) {
    return NSliverResponsiveGrid(
      minItemWidth: minItemWidth,
      maxColumns: maxColumns,
      gap: gap,
      rowGap: rowGap,
      padding: padding,
      childAspectRatio: childAspectRatio,
      mainAxisExtent: mainAxisExtent,
      children: toList(growable: false),
    );
  }
}
