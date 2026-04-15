import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(
      this,
    ).pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (predicate) => false,
      arguments: arguments,
    );
  }

  Future<dynamic> maybePop([bool? data]) async {
    return Navigator.of(this).maybePop(data);
  }

  void pop([Object? result]) {
    return Navigator.of(this).pop(result);
  }

  Future<dynamic> push(Widget page) {
    return Navigator.of(
      this,
    ).push(MaterialPageRoute(builder: (context) => page));
  }

  /// Replaces current route with [page] (no extra screen on stack).
  Future<dynamic> pushReplacement(Widget page) {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<dynamic> pushAndRemoveUntil(Widget page) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (predicate) => false,
    );
  }
}
