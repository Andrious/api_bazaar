// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.
///
///  Stores the InheritedWidget used to update the Cat images.
///

import 'package:api_bazaar/src/view.dart';

import 'package:state_set/state_set.dart';

/// Static API
class APIImages extends StatelessWidget {
  ///
  const APIImages({Key? key}) : super(key: key);

  static final InheritedWrap _branch = InheritedWrap<_ImageInherited>(
    builder: (child) => _ImageInherited(child: child),
    child: const HomePage(),
  );

  /// Link a widget to an InheritedWidget
  static bool dependOnInheritedWidget(BuildContext? context) =>
      _branch.dependOnInheritedWidget(context);

  /// In harmony with Flutter's own API
  static void notifyClients() => _branch.notifyClients();

  /// Supply a Widget builder
  static Widget setState({
    Key? key,
    required Widget Function(BuildContext context) builder,
  }) =>
      _SetState(key: key, builder: builder);

  /// Determine if
  static bool inBuilder = false;

  @override
  Widget build(BuildContext context) => _branch;
}

/// The InheritedWidget assigned 'dependent' child widgets.
class _ImageInherited extends InheritedWidget {
  ///
  const _ImageInherited({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

///  Used like the function, setState(), to 'spontaneously' call
///  build() functions here and there in your app. Much like the Scoped
///  Model's ScopedModelDescendant() class.
///  This class object will only rebuild if the InheritedWidget notifies it
///  as it is a dependency.
class _SetState extends StatelessWidget {
  /// Supply a 'builder' passing in the App's 'data object' and latest BuildContext object.
  const _SetState({Key? key, required this.builder}) : super(key: key);

  /// This is called with every rebuild of the App's inherited widget.
  final Widget Function(BuildContext context) builder;

  /// Calls the required Function object:
  /// Function(BuildContext context)
  @override
  Widget build(BuildContext context) {
    /// Go up the widget tree and link to the App's inherited widget.
    context.dependOnInheritedWidgetOfExactType<_ImageInherited>();

    APIImages.inBuilder = true;

    final Widget widget = builder(context);

    APIImages.inBuilder = false;

    return widget;
  }
}
