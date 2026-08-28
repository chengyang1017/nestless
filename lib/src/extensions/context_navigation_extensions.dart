import 'package:flutter/material.dart';

extension NestlessContextNavigationExtensions on BuildContext {
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
}
