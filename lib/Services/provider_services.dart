import 'package:flutter/material.dart';

import 'auth.dart';

class ProviderService extends InheritedWidget {
  final AuthServices auth;

  ProviderService({Key key, Widget child, this.auth})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static ProviderService of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<ProviderService>());
}
