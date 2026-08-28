import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

extension NestlessValueListenableExtensions<T> on ValueListenable<T> {
  Widget nValue({
    required Widget Function(T value) data,
  }) {
    return ValueListenableBuilder<T>(
      valueListenable: this,
      builder: (context, value, child) {
        return data(value);
      },
    );
  }
}
