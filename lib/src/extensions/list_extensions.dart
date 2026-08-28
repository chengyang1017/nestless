import 'package:flutter/widgets.dart';

extension NestlessListExtensions<T> on Iterable<T> {
  Widget nList({
    required Widget Function(T item) item,
    Widget empty = const SizedBox.shrink(),
    EdgeInsetsGeometry? padding,
    ScrollController? controller,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    bool reverse = false,
  }) {
    final items = toList(growable: false);

    if (items.isEmpty) {
      return empty;
    }

    return ListView.builder(
      controller: controller,
      physics: physics,
      padding: padding,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return item(items[index]);
      },
    );
  }

  Widget nSeparated({
    required Widget Function(T item) item,
    required Widget separator,
    Widget empty = const SizedBox.shrink(),
    EdgeInsetsGeometry? padding,
    ScrollController? controller,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    bool reverse = false,
  }) {
    final items = toList(growable: false);

    if (items.isEmpty) {
      return empty;
    }

    return ListView.separated(
      controller: controller,
      physics: physics,
      padding: padding,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return item(items[index]);
      },
      separatorBuilder: (context, index) {
        return separator;
      },
    );
  }
}
