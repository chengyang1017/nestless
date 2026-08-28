import 'package:flutter/widgets.dart';

extension NestlessFutureExtensions<T> on Future<T> {
  Widget nFuture({
    required Widget Function(T data) data,
    Widget loading = const SizedBox.shrink(),
    Widget Function(Object error, StackTrace? stackTrace)? error,
    T? initialData,
  }) {
    return FutureBuilder<T>(
      future: this,
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
