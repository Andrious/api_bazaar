//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//
//abstract class BaseAuth {
//  Future<FirebaseUser> googleSignIn();
//}
//
//class Auth implements BaseAuth {
//  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//
//  @override
//  Future<FirebaseUser> googleSignIn() async {
//    FirebaseUser user;
//    try {
//      final GoogleSignIn googleSignIn = GoogleSignIn();
//      final GoogleSignInAccount googleSignInAccount =
//          await googleSignIn.signIn();
//      final GoogleSignInAuthentication googleSignInAuthentication =
//          await googleSignInAccount.authentication;
//
//      final AuthCredential credential = GoogleAuthProvider.getCredential(
//          idToken: googleSignInAuthentication.idToken,
//          accessToken: googleSignInAuthentication.accessToken);
//
//      user = await firebaseAuth.signInWithCredential(credential);
//    } catch (ex) {
//      this.ex = ex;
//      user = null;
//    }
//    return user;
//  }
//  Exception ex;
//}
