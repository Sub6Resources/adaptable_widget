library adaptable_widget;

import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AdaptableWidget extends StatelessWidget {
  AdaptableWidget({
    this.android,
    this.ios,
    this.fuchsia,
    this.windows,
    this.linux,
    this.macos,
    this.web,
  });

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

class AdaptableApp extends StatelessWidget {
  AdaptableApp({
    this.title,
    this.home,
    this.materialTheme,
    this.cupertinoTheme,
    this.routes,
    this.initialRoute,
  });

  final String title;
  final Widget home;
  final ThemeData materialTheme;
  final CupertinoThemeData cupertinoTheme;
  final Map<String, WidgetBuilder> routes;
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return AdaptableWidget(
      android: MaterialApp(
        title: title,
        theme: materialTheme,
        home: home,
        routes: routes,
        initialRoute: initialRoute,
      ),
      ios: CupertinoApp(
        title: title,
        theme: cupertinoTheme,
        home: home,
        routes: routes,
        initialRoute: initialRoute,
      ),
    );
  }
}

class AdaptableScaffold extends StatelessWidget {
  AdaptableScaffold({
    @required this.child,
    this.appBar,
    this.cupertinoNavigationBar,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  });

  final Widget child;
  final PreferredSizeWidget appBar;
  final ObstructingPreferredSizeWidget cupertinoNavigationBar;
  final Color backgroundColor;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return AdaptableWidget(
      android: Scaffold(
        body: child,
        appBar: appBar,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      ),
      ios: CupertinoPageScaffold(
        child: child,
        navigationBar: cupertinoNavigationBar,
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

class AdaptableTextField extends StatelessWidget {
  AdaptableTextField({
    this.autocorrect = false,
    this.autofocus = false,
    this.controller,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection,
    this.dragStartBehavior = DragStartBehavior.start,
    this.onTap,
    this.buildCounter,
    this.scrollPhysics,
  });

  final TextEditingController controller;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subhead` text style from the current [Theme].
  final TextStyle style;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int maxLines;

  /// {@macro flutter.widgets.editableText.minLines}
  final int minLines;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  final int maxLength;

  /// If true, prevents the field from allowing more than [maxLength]
  /// characters.
  ///
  /// If [maxLength] is set, [maxLengthEnforced] indicates whether or not to
  /// enforce the limit, or merely provide a character counter and warning when
  /// [maxLength] is exceeded.
  final bool maxLengthEnforced;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters], which are called before [onChanged]
  ///    runs and can validate and change ("format") the input value.
  ///  * [onEditingComplete], [onSubmitted], [onSelectionChanged]:
  ///    which are more specialized input change notifications.
  final ValueChanged<String> onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback onEditingComplete;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final ValueChanged<String> onSubmitted;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter> inputFormatters;

  /// If false the text field is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [Decoration.enabled] property.
  final bool enabled;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius cursorRadius;

  /// The color to use when painting the cursor.
  ///
  /// Defaults to the theme's `cursorColor` when null.
  final Color cursorColor;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to the brightness of [ThemeData.primaryColorBrightness].
  final Brightness keyboardAppearance;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  final GestureTapCallback onTap;

  final InputCounterWidgetBuilder buildCounter;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics scrollPhysics;

  @override
  Widget build(BuildContext context) {
    return AdaptableWidget(
      android: TextField(
        controller: controller,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        autofocus: autofocus,
        obscureText: obscureText,
        autocorrect: autocorrect,
        maxLines: maxLines,
        minLines: minLines,
        expands: expands,
        maxLength: maxLength,
        maxLengthEnforced: maxLengthEnforced,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        inputFormatters: inputFormatters,
        enabled: enabled,
        cursorWidth: cursorWidth,
        cursorColor: cursorColor,
        cursorRadius: cursorRadius,
        keyboardAppearance: keyboardAppearance,
        scrollPadding: scrollPadding,
        dragStartBehavior: dragStartBehavior,
        scrollPhysics: scrollPhysics,
        buildCounter: buildCounter,
        onTap: onTap,
      ),
      ios: CupertinoTextField(
        controller: controller,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        autofocus: autofocus,
        obscureText: obscureText,
        autocorrect: autocorrect,
        maxLines: maxLines,
        minLines: minLines,
        expands: expands,
        maxLength: maxLength,
        maxLengthEnforced: maxLengthEnforced,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        inputFormatters: inputFormatters,
        enabled: enabled,
        cursorWidth: cursorWidth,
        cursorColor: cursorColor,
        cursorRadius: cursorRadius,
        keyboardAppearance: keyboardAppearance,
        scrollPadding: scrollPadding,
        dragStartBehavior: dragStartBehavior,
        scrollPhysics: scrollPhysics,
      ),
    );
  }
}

enum CupertinoTextTheme {
  actionTextStyle,
  navActionTextStyle,
  navTitleTextStyle,
  navLargeTitleTextStyle,
  tabLabelTextStyle,
  textStyle,
}

enum MaterialTextTheme {
  display1,
  display2,
  display3,
  display4,
  title,
  subtitle,
  overline,
  body1,
  body2,
  button,
  caption,
  headline,
  subhead,
}

TextStyle adaptableTextStyle(BuildContext context, {MaterialTextTheme material, CupertinoTextTheme cupertino}) {
  if(Platform.isIOS || Platform.isMacOS) {
    CupertinoTextThemeData textThemeData = CupertinoTheme.of(context).textTheme;
    switch(cupertino) {
      case CupertinoTextTheme.actionTextStyle:
        return textThemeData.actionTextStyle;
      case CupertinoTextTheme.navActionTextStyle:
        return textThemeData.navActionTextStyle;
      case CupertinoTextTheme.navTitleTextStyle:
        return textThemeData.navTitleTextStyle;
      case CupertinoTextTheme.navLargeTitleTextStyle:
        return textThemeData.navLargeTitleTextStyle;
      case CupertinoTextTheme.tabLabelTextStyle:
        return textThemeData.tabLabelTextStyle;
      case CupertinoTextTheme.textStyle:
        return textThemeData.textStyle;
      default:
        return textThemeData.textStyle;
    }
  } else {
    TextTheme textTheme = Theme.of(context).textTheme;
    switch(material) {
      case MaterialTextTheme.display1:
        return textTheme.display1;
      case MaterialTextTheme.display2:
        return textTheme.display2;
      case MaterialTextTheme.display3:
        return textTheme.display3;
      case MaterialTextTheme.display4:
        return textTheme.display4;
      case MaterialTextTheme.title:
        return textTheme.title;
      case MaterialTextTheme.subtitle:
        return textTheme.subtitle;
      case MaterialTextTheme.overline:
        return textTheme.overline;
      case MaterialTextTheme.body1:
        return textTheme.body1;
      case MaterialTextTheme.body2:
        return textTheme.body2;
      case MaterialTextTheme.button:
        return textTheme.button;
      case MaterialTextTheme.caption:
        return textTheme.caption;
      case MaterialTextTheme.headline:
        return textTheme.headline;
      case MaterialTextTheme.subhead:
        return textTheme.subhead;
      default:
        return textTheme.body1;
    }
  }
}
