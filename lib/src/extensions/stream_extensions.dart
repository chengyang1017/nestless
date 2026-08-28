import 'package:flutter/widgets.dart';

extension NestlessStreamExtensions<T> on Stream<T> {
  Widget nStream({
    required Widget Function(T data) data,
    Widget loading = const SizedBox.shrink(),
    Widget Function(Object error, StackTrace? stackTrace)? error,
    T? initialData,
  }) {
    return StreamBuilder<T>(
      stream: this,
      initialData: initialData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final snapshotError = snapshot.error!;

          return error?.call(
                snapshotError,
                snapshot.stackTrace,
              ) ??
              ErrorWidget(snapshotError);
        }

        if (snapshot.hasData) {
          return data(snapshot.requireData);
        }

        return loading;
      },
    );
  }
}
