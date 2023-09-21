import 'package:flutter/material.dart';

///custom page animation for smooth page navigation.
///this can be used through out the application for similar transition effects.
///It accepts a child widget.
PageRoute getCustomPageRoute(final Widget child) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => child,
    transitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (_, a, __, child) => SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(a),
        child: child),
  );
}
