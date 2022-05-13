// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/controller.dart' as c;

import 'package:api_bazaar/src/view.dart';

/// The App's popup menu
class PopMenu extends AppPopupMenu<String> {
  ///
  PopMenu({
    Key? key,
    List<String>? items,
    PopupMenuItemBuilder<String>? itemBuilder,
    String? initialValue,
    PopupMenuItemSelected<String>? onSelected,
    PopupMenuCanceled? onCanceled,
    String? tooltip,
    double? elevation,
    EdgeInsetsGeometry? padding,
    Widget? child,
    Widget? icon,
    Offset? offset,
    bool? enabled,
    ShapeBorder? shape,
    Color? color,
    bool? captureInheritedThemes,
  })  : _con = c.BazaarApp(),
        super(
          key: key ?? const Key('appMenuButton'),
          items: items,
          itemBuilder: itemBuilder,
          initialValue: initialValue,
          onSelected: onSelected,
          onCanceled: onCanceled,
          tooltip: tooltip,
          elevation: elevation,
          padding: padding,
          child: child,
          icon: icon,
          offset: offset ?? const Offset(0, 45),
          enabled: enabled,
          shape: shape ??
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: color,
          // false so to prevent the error,
          // "Looking up a deactivated widget's ancestor is unsafe."
          captureInheritedThemes: captureInheritedThemes ?? false,
        );

  final c.BazaarApp _con;

  @override
  List<PopupMenuItem<String>> get menuItems => [
        PopupMenuItem(
          key: const Key('localeMenuItem'),
          value: 'locale',
          child: Text('${L10n.s('Locale:')} ${App.locale!.toLanguageTag()}'),
        ),
        // if (App.useMaterial)
        //   PopupMenuItem(
        //     key: const Key('colorMenuItem'),
        //     value: 'color',
        //     child: L10n.t('Colour Theme'),
        //   ),
        PopupMenuItem(
          key: const Key('aboutMenuItem'),
          value: 'about',
          child: L10n.t('About'),
        ),
      ];

  // The index of the selected Locale
  int _localeIndex = 0;

  @override
  Future<void> onSelection(String value) async {
    final appContext = App.context!;
    switch (value) {
      case 'locale':
        final locales = App.supportedLocales!;

        _localeIndex = locales.indexOf(App.locale!);

        final spinner = ISOSpinner(
          initialItem: _localeIndex,
          supportedLocales: locales,
          onSelectedItemChanged: (int index) async {
            _localeIndex = index;
          },
        );

        await DialogBox(
          title: 'Current Language'.tr,
          body: [spinner],
          press01: () {},
          press02: () {
            // Retrieve the available locales.
            final locale = c.AppTrs.getLocale(_localeIndex);
            if (locale != null) {
              App.locale = locale;
//              App.refresh();
              App.buildInherited();
//              App.setState(() {});
            }
          },
        ).show();
        break;
      case 'color':
        // Set the current colour.
        ColorPicker.color = App.themeData!.primaryColor;

        await ColorPicker.showColorPicker(
            context: appContext,
            onColorChange: _onColorChange,
            onChange: _onChange,
            shrinkWrap: true);
        break;
      case 'about':
        // showAboutDialog(
        //   context: appContext,
        //   applicationName: App.vw?.title ?? '',
        //   applicationVersion:
        //       'version: ${App.version} build: ${App.buildNumber}',
        // );
        c.HomeDrawer().onTap(const About());
        break;
      default:
    }
  }

  void _onColorChange(Color value) {
    /// Implement to take in a color change.
  }

  /// Of course, the controller is to response to such user events.
  void _onChange([ColorSwatch<int?>? value]) => _con.onColorPicker(value);
}
