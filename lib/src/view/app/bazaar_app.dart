// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/controller.dart' as c;

import 'package:api_bazaar/src/view.dart';

///
class BazaarApp extends AppState {
  ///
  BazaarApp()
      : super(
          title: 'e-Bazaar',
          debugShowCheckedModeBanner: false,
          con: c.BazaarApp(),
          controllers: [
            c.APIsController(),
            c.ThemeChanger(),
          ],
          // locale: const Locale('en', 'CA'),
          // supportedLocales: const [
          //   Locale('en', 'US'),
          //   Locale('en', 'GB'),
          //   Locale('en', 'AU'),
          // ],
          // localizationsDelegates: const [
          //   GlobalCupertinoLocalizations.delegate,
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          // ],
          locale: c.AppTrs.textLocale,
          supportedLocales: c.AppTrs.supportedLocales,
          localizationsDelegates: [
            L10n.delegate!,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          home: const Login(),
        );
}
