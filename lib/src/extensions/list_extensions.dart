import 'package:flutter/widgets.dart';

Widget nListBuilder({
  required int itemCount,
  required IndexedWidgetBuilder itemBuilder,
  Widget empty = const SizedBox.shrink(),
  EdgeInsetsGeometry? padding,
  ScrollController? controller,
  ScrollPhysics? physics,
  bool shrinkWrap = false,
  bool reverse = false,
  Axis scrollDirection = Axis.vertical,
}) {
  assert(itemCount >= 0, 'itemCount must not be negative');

  if (itemCount == 0) {
    return empty;
  }

  return ListView.builder(
    controller: controller,
    physics: physics,
    padding: padding,
    shrinkWrap: shrinkWrap,
    reverse: reverse,
    scrollDirection: scrollDirection,
    itemCount: itemCount,
    itemBuilder: itemBuilder,
  );
}

Widget nSeparatedBuilder({
  required int itemCount,
  required IndexedWidgetBuilder itemBuilder,
  required IndexedWidgetBuilder separatorBuilder,
  Widget empty = const SizedBox.shrink(),
  EdgeInsetsGeometry? padding,
  ScrollController? controller,
  ScrollPhysics? physics,
  bool shrinkWrap = false,
  bool reverse = false,
  Axis scrollDirection = Axis.vertical,
}) {
  assert(itemCount >= 0, 'itemCount must not be negative');

  if (itemCount == 0) {
    return empty;
  }

  return ListView.separated(
    controller: controller,
    physics: physics,
    padding: padding,
    shrinkWrap: shrinkWrap,
    reverse: reverse,
    scrollDirection: scrollDirection,
    itemCount: itemCount,
    itemBuilder: itemBuilder,
    separatorBuilder: separatorBuilder,
  );
}

extension NestlessListExtensions<T> on Iterable<T> {
  Widget nList({
    required Widget Function(T item) item,
    Widget empty = const SizedBox.shrink(),
    EdgeInsetsGeometry? padding,
    ScrollController? controller,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    bool reverse = false,
    Axis scrollDirection = Axis.vertical,
  }) {
    final items = toList(growable: false);

    return nListBuilder(
      itemCount: items.length,
      empty: empty,
      padding: padding,
      controller: controller,
      physics: physics,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
      scrollDirection: scrollDirection,
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
    Axis scrollDirection = Axis.vertical,
  }) {
    final items = toList(growable: false);

    return nSeparatedBuilder(
      itemCount: items.length,
      empty: empty,
      padding: padding,
      controller: controller,
      physics: physics,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
      scrollDirection: scrollDirection,
      itemBuilder: (context, index) {
        return item(items[index]);
      },
      separatorBuilder: (context, index) {
        return separator;
      },
    );
  }
}
