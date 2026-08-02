import 'package:flutter/widgets.dart';

enum NGapAxis { horizontal, vertical }

extension NestlessWidgetListExtensions on Iterable<Widget> {
  List<Widget> nWithGap(
    double gap, {
    required NGapAxis axis,
  }) {
    final items = toList(growable: false);

    if (gap <= 0 || items.length < 2) return items;

    return [
      for (var index = 0; index < items.length; index++) ...[
        if (index > 0)
          axis == NGapAxis.vertical
              ? SizedBox(height: gap)
              : SizedBox(width: gap),
        items[index],
      ],
    ];
  }
}
