// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/model.dart'
    show deDE, esAR, frFR, heIL, ruRU, zhCN;

import 'package:api_bazaar/src/view.dart';

///
//ignore: non_constant_identifier_names
final AppTrs = AppTranslations();

/// Supplies the App's translations
class AppTranslations extends L10n {
  ///
  factory AppTranslations() => _this ??= AppTranslations._();
  AppTranslations._();
  static AppTranslations? _this;

  /// The text's original Locale
  @override
  Locale get textLocale => const Locale('en', 'US');

  /// The app's translations
  @override
  Map<Locale, Map<String, String>> get l10nMap => {
        const Locale('zh', 'CN'): zhCN,
        const Locale('fr', 'FR'): frFR,
        const Locale('de', 'DE'): deDE,
        const Locale('he', 'IL'): heIL,
        const Locale('ru', 'RU'): ruRU,
        const Locale('es', 'AR'): esAR,
      };
}
