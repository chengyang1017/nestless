import 'package:flutter/material.dart';

extension NestlessContextNavigationExtensions on BuildContext {
  Future<T?> nPush<T extends Object?>(
    Widget page,
  ) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute<T>(
        builder: (_) => page,
      ),
    );
  }

  Future<T?> nReplace<T extends Object?, TO extends Object?>(
    Widget page, {
    TO? result,
  }) {
    return Navigator.of(this).pushReplacement<T, TO>(
      MaterialPageRoute<T>(
        builder: (_) => page,
      ),
      result: result,
    );
  }

  void nPop<T extends Object?>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  bool get nCanPop {
    return Navigator.of(this).canPop();
  }
}
