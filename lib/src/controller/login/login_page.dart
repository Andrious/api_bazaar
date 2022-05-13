// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

//import 'package:auth/auth.dart' show Auth;

import 'package:api_bazaar/src/controller.dart' show BazaarApp, ControllerMVC;

///
class LoginPage extends ControllerMVC {
  ///
  factory LoginPage() => _this ??= LoginPage._();
  LoginPage._() {
    con = BazaarApp();
    loggedIn = false; //con.loggedIn!;
//    _auth = con.auth;
  }
  static LoginPage? _this;

  ///
  late BazaarApp con;

//  late Auth _auth;

  ///
  late bool loggedIn;

  ///
  bool isSignedIn() => false; // _auth.isLoggedIn(); //?? false;

  ///
  String email() {
    String email = ''; //_auth.email;
    if (email.isEmpty) {
      email = 'Guest User';
    }
    return email;
  }

  ///
  Future<bool> signIn(String email, String password) => Future.value(
      false); //    _auth.signInWithEmailAndPassword(email: email, password: password);

  @override
  bool get inError => false; // _auth.message.isNotEmpty;

  @override
  Exception? getError([dynamic error]) => null; //_auth.getError();

  ///
  Future<void> msgError(Exception ex) =>
      con.msgError(ex, context: stateMVC!.context);
}
