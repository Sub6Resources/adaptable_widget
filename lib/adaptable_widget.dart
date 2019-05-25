library adaptable_widget;

import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdaptableWidget extends StatelessWidget {
  AdaptableWidget(
      {this.android,
      this.ios,
      this.fuchsia,
      this.windows,
      this.linux,
      this.macos,
      this.web});

  final Widget android;
  final Widget ios;
  final Widget fuchsia;
  final Widget windows;
  final Widget linux;
  final Widget macos;
  final Widget web;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return ios ?? android;
    } else if (Platform.isAndroid) {
      return android;
    } else if (Platform.isFuchsia) {
      return fuchsia ?? android;
    } else if (Platform.isWindows) {
      return windows ?? android;
    } else if (Platform.isLinux) {
      return linux ?? android;
    } else if (Platform.isMacOS) {
      return macos ?? ios ?? android;
    } else {
      return android;
    }
  }
}

class AdaptableScaffold extends StatelessWidget {
  AdaptableScaffold({
    @required this.body,
    this.appBar,
    this.navigationBarCupertino,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  });

  final Widget body;
  final PreferredSizeWidget appBar;
  final ObstructingPreferredSizeWidget navigationBarCupertino;
  final Color backgroundColor;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return AdaptableWidget(
      android: Scaffold(
        body: body,
        appBar: appBar,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      ),
      ios: CupertinoPageScaffold(
        child: body,
        navigationBar: navigationBarCupertino,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      ),
    );
  }
}

class AdaptableButton extends StatelessWidget {
  AdaptableButton({
    @required this.child,
    @required this.onPressed,
  });

  final Widget child;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AdaptableWidget(
      android: MaterialButton(
        child: child,
        onPressed: onPressed,
      ),
      ios: CupertinoButton(
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
