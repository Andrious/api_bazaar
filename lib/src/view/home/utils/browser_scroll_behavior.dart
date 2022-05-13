import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart' show MaterialScrollBehavior;

/// Change the behavior of 'Scrolling' widgets if running in a browser.
class BrowserScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => !kIsWeb
      ? super.dragDevices
      : {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        };
}
