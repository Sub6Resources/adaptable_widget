library adaptable_widget;

import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AdaptableWidget extends StatefulWidget {
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
  _AdaptableWidgetState createState() => _AdaptableWidgetState();
}

class _AdaptableWidgetState extends State<AdaptableWidget> {
  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      print("iOS widget");
      return widget.ios ?? widget.android;
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      print("Android widget");
      return widget.android;
    } else if (Theme.of(context).platform == TargetPlatform.fuchsia) {
      return widget.fuchsia ?? widget.android;
    } else if (Platform.isWindows) {
      return widget.windows ?? widget.android;
    } else if (Platform.isLinux) {
      return widget.linux ?? widget.android;
    } else if (Platform.isMacOS) {
      return widget.macos ?? widget.ios ?? widget.android;
    } else {
      return widget.android;
    }
  }
}

class AdaptableApp extends StatelessWidget {
  AdaptableApp({
    this.title,
    this.home,
    this.materialTheme,
    this.cupertinoTheme,
    this.routes = const <String, WidgetBuilder>{},
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
    this.floatingActionButton,
  });

  final Widget child;
  final PreferredSizeWidget appBar;
  final ObstructingPreferredSizeWidget cupertinoNavigationBar;
  final Color backgroundColor;
  final bool resizeToAvoidBottomInset;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return AdaptableWidget(
      android: Scaffold(
        body: child,
        appBar: appBar,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        floatingActionButton: floatingActionButton,
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

class AdaptableText extends StatelessWidget {
  AdaptableText(
    this.text, {
    Key key,
    this.textSpan,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
  }) : super(key: key);

  final String text;

  /// The text to display as a [TextSpan].
  ///
  /// This will be null if [data] is provided instead.
  final TextSpan textSpan;

  /// If non-null, the style to use for this text.
  ///
  /// If the style's "inherit" property is true, the style will be merged with
  /// the closest enclosing [DefaultTextStyle]. Otherwise, the style will
  /// replace the closest enclosing [DefaultTextStyle].
  final TextStyle style;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale locale;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool softWrap;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  ///
  /// The value given to the constructor as textScaleFactor. If null, will
  /// use the [MediaQueryData.textScaleFactor] obtained from the ambient
  /// [MediaQuery], or 1.0 if there is no [MediaQuery] in scope.
  final double textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
  /// an explicit number for its [DefaultTextStyle.maxLines], then the
  /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
  /// widget directly to entirely override the [DefaultTextStyle].
  final int maxLines;

  /// An alternative semantics label for this text.
  ///
  /// If present, the semantics of this widget will contain this value instead
  /// of the actual text. This will overwrite any of the semantics labels applied
  /// directly to the [TextSpan]s.
  ///
  /// This is useful for replacing abbreviations or shorthands with the full
  /// text value:
  ///
  /// ```dart
  /// Text(r'$$', semanticsLabel: 'Double dollars')
  /// ```
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      key: key,
      locale: locale,
      overflow: overflow,
      semanticsLabel: semanticsLabel,
      softWrap: softWrap,
      strutStyle: strutStyle,
      style: style ?? adaptableTextStyle(context),
      textDirection: textDirection,
      textScaleFactor: textScaleFactor,
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

TextStyle adaptableTextStyle(BuildContext context,
    {MaterialTextTheme material, CupertinoTextTheme cupertino}) {
  if (Theme.of(context).platform == TargetPlatform.iOS || Platform.isMacOS) {
    print("iOS");
    CupertinoTextThemeData textThemeData = CupertinoTheme.of(context).textTheme;
    switch (cupertino) {
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
        return textThemeData.textStyle.merge(TextStyle(inherit: true));
    }
  } else {
    print("Android");
    TextTheme textTheme = Theme.of(context).textTheme;
    switch (material) {
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
