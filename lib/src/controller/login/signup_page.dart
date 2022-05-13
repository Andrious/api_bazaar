// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

// import 'package:auth/auth.dart';
//
// import 'package:bazaar/src/controller.dart' show BazaarApp, ControllerMVC;
// //import 'package:firebase_auth/firebase_auth.dart';
// //import 'package:shopping_cart/src/login/model/firebaseDB/google_signin.dart';
//
// import 'package:bazaar/src/login/model/firebaseDB/user_management.dart';
//
// import 'package:flutter/cupertino.dart' show BuildContext;
//
// ///
// class SignUpPage extends ControllerMVC {
//   ///
//   factory SignUpPage() => _this ??= SignUpPage._();
//   SignUpPage._();
//   static SignUpPage? _this;
//
//   late Auth _auth;
//
//   ///
//   late BazaarApp con;
//
//   @override
//   void initState() {
//     super.initState();
//     con = BazaarApp();
//     _auth = con.auth;
//     con.ads.closeBannerAd();
//   }
//
// //  Auth auth = Auth();
// //  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   ///
//   UserManagement userManagement = UserManagement();
//
// //  Future<bool> signUpUser(
// //      String userName, String email, String password) async {
// //    FirebaseUser user = await firebaseAuth.currentUser();
// //    bool signUp = user == null;
// //    if (signUp) {
// //      firebaseAuth
// //          .createUserWithEmailAndPassword(email: email, password: password)
// //          .then((user) {
// //        // user.sendEmailVerification();
// //        // here user.uid triggers an id inside the user which should match id of the user document
// //        userManagement.createUser(user.uid.toString(), {
// //          'userId': user.uid,
// //          'username': userName.toString(),
// //          'email': email,
// //        }).CatchError((ex) {
// //          print("signUpUser(): ${ex.toString()}");
// //        });
// //      });
// //    }
// //    return signUp;
// //  }
//
//   ///
//   Future<bool> signUpUser(
//       String userName, String email, String password) async {
//     var user = _auth.currentUser();
//     bool signUp = user == null;
//     if (signUp) {
//       signUp = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       if (signUp) {
//         user = _auth.currentUser();
//         userManagement.createUser(user!.uid.toString(), {
//           'userId': user.uid,
//           'username': userName.toString(),
//           'email': email,
//         });
// //        .CatchError((ex) {
// //          print("signUpUser(): ${ex.toString()}");
// //        });
//       }
//     }
//     return signUp;
//   }
//
// //  Future<bool> googleSignIn() async {
// //    FirebaseUser user = await auth.googleSignIn();
// //    bool signIn = user != null;
// //    if (signIn) {
// //      // user.sendEmailVerification();
// //      userManagement.createUser(user.uid, {
// //        "userId": user.uid,
// //        "username": user.displayName,
// //        "photoUrl": user.photoUrl,
// //        "email": user.email,
// //      });
// //    }
// //    return signIn;
// //  }
//
//   ///
//   Future<bool> googleSignIn() async {
//     final bool signIn = await _auth.signInGoogle();
//     if (signIn) {
//       final user = _auth.currentUser();
//       userManagement.createUser(user!.uid, {
//         'userId': user.uid,
//         'username': user.displayName,
//         'email': user.email,
//       });
//     }
//     return signIn;
//   }
//
//   @override
//   bool get inError => _auth.message.isNotEmpty;
//
//   @override
//   Exception? getError([dynamic error]) => _auth.getError();
//
//   ///
//   Future<void> msgError(BuildContext context) =>
//       con.msgError(getError()!, context: context);
// }
