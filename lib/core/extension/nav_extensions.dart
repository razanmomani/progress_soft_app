import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> push(
    Widget screen,
  ) {
    return Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Future<dynamic> pushAndRemoveAll(Widget screen) {
    return Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  Future<dynamic> pushReplacement(
    Widget screen,
  ) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Future<dynamic> pushTopToBottomAnimation(
    Widget screen,
  ) {
    return Navigator.of(this).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  Future<dynamic> pushReplacementTopToBottomAnimation(
    Widget screen,
  ) {
    return Navigator.of(this).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        },
        transitionDuration: const Duration(microseconds: 120),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  Future<dynamic> pushBottomToTop(
    Widget screen,
  ) {
    return Navigator.of(this).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 120),
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  Future<dynamic> pushReplacementBottomToTop(
    Widget screen,
  ) {
    return Navigator.of(this).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 120),
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  void pop() => Navigator.of(this).pop();
}
