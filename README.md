# adaptable_widget

A collection of widgets that adapt to match the preferred style of the current platform

## Why?

Flutter is a great development platform, but often different platforms require different UI components to match the style the user is most familiar with (i.e. Material on Android and Cupertino on iOS). This platform aims to make detecting and switching between those platforms as simple as throwing it in another widget that does all the work.

## Getting Started

The simplest use case is just the `AdaptableWidget`:

```dart
Widget build() {
  return AdaptableWidget(
    android: AndroidWidget(...),
    ios: CupertinoWidget(...),
    fuschia: FuschiaWidget(...),
    windows: WindowsWidget(...), //Currently not supported
    macos: MacOSWidget(...), //Currently not supported
    web: WebWidget(...), //Support coming soon
  );
}
```

## Other Widgets

These other widgets wrap the `AdaptableWidget` to provide common-use-case adaptations with less boilerplate.

------------------------------------------------

### `AdaptableApp`

This is an easy way to switch between `MaterialApp` and `CupertinoApp` so that the material and cupertino widgets have the proper ancestors.

#### Example

```dart
Widget build() {
  return AdaptableApp(
    title: "My App",
    materialTheme: ThemeData(...),
    cupertinoTheme: CupertinoThemeData(...),
    home: MyHomePage(...),
  );
}
```

### `AdaptableScaffold`

The aim of `AdaptableScaffold` is to switch between `Scaffold` or `CupertinoScaffoldPage` without having to write the child UI code twice.

#### Example

```dart
Widget build() {
  return AdaptableScaffold(
    child: MyHomePage(), //Required
    appBar: AppBar(...),
    cupertinoNavigationBar: cupertinoNavigationBar(...),
    backgroundColor: Colors.white,
    resizeToAvoidBottomInset: true,
  );
}
```
### `AdaptableButton`

Buttons are one Widget that often have a certain look and feel on different platforms. This `AdaptableButton` class provides simply a `child` and an `onPressed` callback.

#### Example

```dart
Widget build() {
  return AdaptableButton(
    child: Text("Tap Me!"),
    onPressed: doSomething,
  );
}
```

### `AdaptableTextField`

Switches between `TextField` and `CupertinoTextField` based on the platform.