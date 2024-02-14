import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void navigateToScreen(Widget widget, {bool isReplace = false}) {
    if (isReplace) {
      Navigator.of(this).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => widget), (route) => false);
    }
    Navigator.of(this).push(MaterialPageRoute(builder: (_) => widget));
  }
}
