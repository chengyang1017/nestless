import 'package:flutter/widgets.dart';

import '../extensions/widget_list_extensions.dart';

class NSliverColumn extends StatelessWidget {
  final List<Widget> children;
  final double gap;
  final EdgeInsetsGeometry? padding;

  const NSliverColumn({
    super.key,
    required this.children,
    this.gap = 0,
    this.padding,
  }) : assert(gap >= 0, 'gap must not be negative');

  @override
  Widget build(BuildContext context) {
    final sliver = SliverList(
      delegate: SliverChildListDelegate(
        children.nWithGap(
          gap,
          axis: NGapAxis.vertical,
        ),
      ),
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
