// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'dart:async' show Future;

//import 'package:ads/ads.dart' show Ads;

//import 'package:auth/auth.dart' show Auth;

import 'package:api_bazaar/src/controller.dart';

import 'package:api_bazaar/src/view.dart';

import 'package:flutter/services.dart' show PlatformException;

///
class BazaarApp extends AppController {
  ///
  factory BazaarApp() => _this ??= BazaarApp._();
  BazaarApp._() {
//    auth = Auth();
  }

  static BazaarApp? _this;

  ///
//  late Auth auth;

  @override
  Future<bool> initAsync() async {
    return true;
  }

  ///
//  late Ads ads;

  ///
  bool? loggedIn;

  // @override
  // void initState() {
  //   super.initState();
  //   ads = Ads(
  //     trackingId: UniversalPlatform.isAndroid
  //         ? 'ca-app-pub-3940256099942544~3347511713'
  //         : 'ca-app-pub-3940256099942544~1458002511',
  //     bannerUnitId: UniversalPlatform.isAndroid
  //         ? 'ca-app-pub-3940256099942544/6300978111'
  //         : 'ca-app-pub-3940256099942544/2934735716',
  //     screenUnitId: UniversalPlatform.isAndroid
  //         ? 'ca-app-pub-3940256099942544/1033173712'
  //         : 'ca-app-pub-3940256099942544/4411468910',
  //     videoUnitId: UniversalPlatform.isAndroid
  //         ? 'ca-app-pub-3940256099942544/5224354917'
  //         : 'ca-app-pub-3940256099942544/1712485313',
  //     keywords: ['bazaar', 'clothing'],
  //     testing: false,
  //   );
  // }

//   @override
//   void dispose() {
// //    auth.dispose();
// //    ads.dispose();
//     super.dispose();
//   }

  ///
  Future<void> msgError(Exception ex, {required BuildContext context}) {
    String msg, title;
    if (ex is PlatformException) {
      final PlatformException px = ex;
      if (px.code.contains('NOT_FOUND')) {
        title = 'Sign Up Required';
        msg =
            "Looks like you need to register first.\nYou're not found in the system.";
      } else {
        title = px.code;
        msg = px.message ?? '';
      }
    } else {
      title = 'Error';
      msg = ex.toString();
    }
    return MsgBox(context: context, title: title, msg: msg).show();
  }

  /// Working with the ColorPicker to change the app's color theme
  void onColorPicker([ColorSwatch<int?>? value]) {
    //
    App.setThemeData(value);
    App.refresh();
  }

  @override
  void onConnectivityChanged(ConnectivityResult result) {}
}
