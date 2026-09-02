// ignore_for_file: prefer_initializing_formals

import 'package:flutter/widgets.dart';

class NSliverGrid extends StatelessWidget {
  final List<Widget>? children;
  final NullableIndexedWidgetBuilder? itemBuilder;
  final int? itemCount;
  final int columns;
  final double gap;
  final double? rowGap;
  final EdgeInsetsGeometry? padding;
  final double childAspectRatio;
  final double? mainAxisExtent;

  const NSliverGrid({
    super.key,
    required List<Widget> children,
    required this.columns,
    this.gap = 0,
    this.rowGap,
    this.padding,
    this.childAspectRatio = 1,
    this.mainAxisExtent,
  })  : children = children,
        itemBuilder = null,
        itemCount = null,
        assert(columns > 0, 'columns must be greater than 0'),
        assert(gap >= 0, 'gap must not be negative'),
        assert(rowGap == null || rowGap >= 0, 'rowGap must not be negative'),
        assert(childAspectRatio > 0, 'childAspectRatio must be greater than 0');

  const NSliverGrid.builder({
    super.key,
    required int itemCount,
    required NullableIndexedWidgetBuilder itemBuilder,
    required this.columns,
    this.gap = 0,
    this.rowGap,
    this.padding,
    this.childAspectRatio = 1,
    this.mainAxisExtent,
  })  : children = null,
        itemBuilder = itemBuilder,
        itemCount = itemCount,
        assert(itemCount >= 0, 'itemCount must not be negative'),
        assert(columns > 0, 'columns must be greater than 0'),
        assert(gap >= 0, 'gap must not be negative'),
        assert(rowGap == null || rowGap >= 0, 'rowGap must not be negative'),
        assert(childAspectRatio > 0, 'childAspectRatio must be greater than 0');

  @override
  Widget build(BuildContext context) {
    final sliver = SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: gap,
        mainAxisSpacing: rowGap ?? gap,
        childAspectRatio: childAspectRatio,
        mainAxisExtent: mainAxisExtent,
      ),
      delegate: itemBuilder != null
          ? SliverChildBuilderDelegate(
              itemBuilder!,
              childCount: itemCount,
            )
          : SliverChildListDelegate(children!),
    );

    if (padding == null) {
      return sliver;
    }

    return SliverPadding(
      padding: padding!,
      sliver: sliver,
    );
  }
}

extension NestlessSliverGridExtensions on Iterable<Widget> {
  Widget nSliverGrid({
    required int columns,
    double gap = 0,
    double? rowGap,
    EdgeInsetsGeometry? padding,
    double childAspectRatio = 1,
    double? mainAxisExtent,
  }) {
    return NSliverGrid(
      columns: columns,
      gap: gap,
      rowGap: rowGap,
      padding: padding,
      childAspectRatio: childAspectRatio,
      mainAxisExtent: mainAxisExtent,
      children: toList(growable: false),
    );
  }
}
