import 'package:flutter/widgets.dart';

import '../extensions/widget_list_extensions.dart';

class NSliverColumn extends StatelessWidget {
  final List<Widget>? children;
  final NullableIndexedWidgetBuilder? itemBuilder;
  final int? itemCount;
  final double gap;
  final EdgeInsetsGeometry? padding;

  const NSliverColumn({
    super.key,
    required List<Widget> children,
    this.gap = 0,
    this.padding,
  })  : // ignore: prefer_initializing_formals
        children = children,
        itemBuilder = null,
        itemCount = null,
        assert(gap >= 0, 'gap must not be negative');

  const NSliverColumn.builder({
    super.key,
    required int itemCount,
    required NullableIndexedWidgetBuilder itemBuilder,
    this.gap = 0,
    this.padding,
  })  : children = null,
        // ignore: prefer_initializing_formals
        itemBuilder = itemBuilder,
        itemCount = itemCount,
        assert(itemCount >= 0, 'itemCount must not be negative'),
        assert(gap >= 0, 'gap must not be negative');

  @override
  Widget build(BuildContext context) {
    final sliver = SliverList(
      delegate: _buildDelegate(),
    );

    if (padding == null) {
      return sliver;
    }

    return SliverPadding(
      padding: padding!,
      sliver: sliver,
    );
  }

  SliverChildDelegate _buildDelegate() {
    if (itemBuilder != null) {
      final count = itemCount!;

      if (gap <= 0) {
        return SliverChildBuilderDelegate(
          itemBuilder!,
          childCount: count,
        );
      }

      final childCount = count == 0 ? 0 : count * 2 - 1;

      return SliverChildBuilderDelegate(
        (context, index) {
          if (index.isOdd) {
            return SizedBox(height: gap);
          }

          return itemBuilder!(context, index ~/ 2);
        },
        childCount: childCount,
      );
    }

    return SliverChildListDelegate(
      children!.nWithGap(
        gap,
        axis: NGapAxis.vertical,
      ),
    );
  }
}

extension NestlessSliverColumnExtensions on Iterable<Widget> {
  Widget nSliverColumn({
    double gap = 0,
    EdgeInsetsGeometry? padding,
  }) {
    return NSliverColumn(
      gap: gap,
      padding: padding,
      children: toList(growable: false),
    );
  }
}
