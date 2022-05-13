// import 'package:bazaar/src/controller.dart' as c;
//
// import 'package:bazaar/src/home/view/homepage.dart' show HomePage;
//
// import 'package:bazaar/src/login/view/login_page.dart' show Login;
//
// import 'package:bazaar/src/view.dart' show HomePage, Login, StateMVC;
//
// import 'package:flutter/material.dart'
//     show
//         AlertDialog,
//         Alignment,
//         AnimatedBuilder,
//         Animation,
//         AnimationController,
//         AutovalidateMode,
//         BorderRadius,
//         BoxDecoration,
//         BuildContext,
//         Center,
//         CircularProgressIndicator,
//         Color,
//         Colors,
//         Column,
//         Container,
//         CurvedAnimation,
//         Curves,
//         EdgeInsets,
//         FontWeight,
//         Form,
//         FormState,
//         GlobalKey,
//         Icon,
//         IconButton,
//         Icons,
//         Image,
//         InkWell,
//         InputDecoration,
//         Interval,
//         Key,
//         LinearGradient,
//         ListTile,
//         ListView,
//         MaterialButton,
//         MaterialPageRoute,
//         Matrix4,
//         MediaQuery,
//         Navigator,
//         RoundedRectangleBorder,
//         Row,
//         Scaffold,
//         SingleTickerProviderStateMixin,
//         SizedBox,
//         StatefulWidget,
//         Text,
//         TextButton,
//         TextEditingController,
//         TextFormField,
//         TextInputType,
//         TextStyle,
//         Transform,
//         Tween,
//         Visibility,
//         Widget,
//         showDialog;
//
// ///
// class SignUp extends StatefulWidget {
//   ///
//   const SignUp({Key? key}) : super(key: key);
//   @override
//   _SignUpState createState() => _SignUpState();
// }
//
// class _SignUpState extends StateMVC<SignUp>
//     with SingleTickerProviderStateMixin {
//   _SignUpState() : super(c.SignUpPage()) {
//     con = controller as c.SignUpPage;
//   }
//
//   late c.SignUpPage con;
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   late Animation animation, delayAnimation, muchDelayedAnimation;
//   late AnimationController animationController;
//   bool hidePass = true;
//   bool isLoading = false;
//   bool isLoggedIn = false;
//
//   @override
//   void initState() {
//     super.initState();
//     final ad = c.BazaarApp().ads;
//     if (ad != null) {
//       ad.closeBannerAd();
//     }
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2000),
//     );
//     animation = Tween(begin: -1, end: 0.0).animate(
//       CurvedAnimation(curve: Curves.fastOutSlowIn, parent: animationController),
//     );
//     delayAnimation = Tween(begin: -1, end: 0.0).animate(
//       CurvedAnimation(
//         parent: animationController,
//         curve: const Interval(0.5, 1, curve: Curves.fastOutSlowIn),
//       ),
//     );
//     muchDelayedAnimation = Tween(begin: -1, end: 0.0).animate(
//       CurvedAnimation(
//         parent: animationController,
//         curve: const Interval(0.7, 1, curve: Curves.fastOutSlowIn),
//       ),
//     );
//
//     isSignedIn();
//   }
//
//   void isSignedIn() {
//     setState(() {
//       isLoading = true;
//     });
//
//     if (isLoggedIn) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute<void>(builder: (context) => HomePage()));
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     animationController.forward();
//     final width = MediaQuery.of(context).size.width;
//
//     return AnimatedBuilder(
//       animation: animationController,
//       builder: (BuildContext context, Widget? child) {
//         return Scaffold(
//           body: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.bottomRight,
//                 end: Alignment.topLeft,
//                 stops: [0.5, 0.8],
//                 colors: [
//                   Colors.cyanAccent,
//                   Colors.tealAccent,
//                 ],
//               ),
//             ),
//             padding: const EdgeInsets.all(15),
//             child: Center(
//               child: ListView(
//                 children: <Widget>[
//                   InkWell(
//                     child: Container(
//                       alignment: Alignment.topLeft,
//                       child: IconButton(
//                         icon: const Icon(Icons.arrow_back),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute<void>(
//                           builder: (context) => const Login()));
//                     },
//                     child: Transform(
//                       transform: Matrix4.translationValues(
//                           animation.value * width, 0, 0),
//                       child: Container(
//                         alignment: Alignment.center,
//                         padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
//                         child: Text(
//                           'SignUp',
//                           style: _loginRegStyles(),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Transform(
//                     transform: Matrix4.translationValues(
//                         delayAnimation.value * width, 0, 0),
//                     child: Form(
//                       key: _formKey,
//                       autovalidateMode: AutovalidateMode.always,
//                       child: Column(
//                         children: <Widget>[
//                           TextFormField(
//                             controller: _nameController,
//                             decoration: const InputDecoration(
//                               prefixIcon: Icon(Icons.supervised_user_circle,
//                                   color: Colors.blueGrey),
//                               hintText: 'Username',
//                               labelText: 'Username',
//                             ),
//                             validator: (val) {
//                               if (val!.isEmpty) {
//                                 return 'Please Provide Username';
//                               }
//                               return null;
//                             },
//                             onSaved: (val) {
//                               _nameController.text = val!;
//                             },
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           TextFormField(
//                             controller: _emailController,
//                             keyboardType: TextInputType.emailAddress,
//                             decoration: const InputDecoration(
//                                 prefixIcon: Icon(Icons.alternate_email,
//                                     color: Colors.blueGrey),
//                                 hintText: 'Email',
//                                 labelStyle: TextStyle(
//                                     // color: Colors.white,
//                                     ),
//                                 labelText: 'Email'),
//                             validator: (val) {
//                               if (val!.isEmpty) {
//                                 return 'Please Provide Email';
//                               }
//                               return null;
//                             },
//                             onSaved: (val) {
//                               _emailController.text = val!;
//                             },
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//
//                           TextFormField(
//                             controller: _passwordController,
//                             obscureText: hidePass,
//                             decoration: InputDecoration(
//                                 suffixIcon: IconButton(
//                                   icon: hidePass
//                                       ? const Icon(Icons.visibility_off,
//                                           color: Colors.blueGrey)
//                                       : const Icon(Icons.visibility,
//                                           color: Colors.blueGrey),
//                                   onPressed: () {
//                                     setState(() {
//                                       hidePass = !hidePass;
//                                     });
//                                   },
//                                 ),
//                                 prefixIcon: const Icon(
//                                   Icons.lock,
//                                   color: Colors.blueGrey,
//                                 ),
//                                 hintText: 'Password',
//                                 labelText: 'Password'),
//                             validator: (val) {
//                               if (val!.length < 6) {
//                                 return 'Passsword must contain atleast 6 characters';
//                               }
//                               return null;
//                             },
//                             onSaved: (val) {
//                               _passwordController.text = val!;
//                             },
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           TextFormField(
//                             controller: _confirmPasswordController,
//                             obscureText: hidePass,
//                             decoration: InputDecoration(
//                                 suffixIcon: IconButton(
//                                   icon: hidePass
//                                       ? const Icon(Icons.visibility_off,
//                                           color: Colors.blueGrey)
//                                       : const Icon(Icons.visibility,
//                                           color: Colors.blueGrey),
//                                   onPressed: () {
//                                     setState(() {
//                                       hidePass = !hidePass;
//                                     });
//                                   },
//                                 ),
//                                 prefixIcon: const Icon(
//                                   Icons.lock,
//                                   color: Colors.blueGrey,
//                                 ),
//                                 hintText: 'Confirm Password',
//                                 labelText: 'Confirm Password'),
//                             validator: (val) {
//                               if (val!.length < 6) {
//                                 return 'Password must contain at least 6 characters';
//                               } else if (val.isEmpty) {
//                                 return "Password field can't be empty";
//                               } else if (_passwordController.text != val) {
//                                 return "Password and Confirm Password didn't match";
//                               }
//                               return null;
//                             },
//                             onSaved: (val) {
//                               _passwordController.text = val!;
//                             },
//                           ),
//
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           //  ================== Login Btn =======================
//                           Transform(
//                             transform: Matrix4.translationValues(
//                                 muchDelayedAnimation.value * width, 0, 0),
//                             child: MaterialButton(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               minWidth: MediaQuery.of(context).size.width,
//                               onPressed: () async {
//                                 await signUpUser(context);
//                                 Navigator.of(context).pop();
//                               },
//                               color: const Color(0xFFB33771),
//                               child: ListTile(
//                                 title: Center(
//                                   child: Text(
//                                     'Signup For Free',
//                                     style: _btnStyle(),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           const Text('OR'),
//                           const SizedBox(
//                             height: 5,
//                           ),
//
//                           //  ================== Signin with Google Btn =======================
//
//                           Transform(
//                             transform: Matrix4.translationValues(
//                                 muchDelayedAnimation.value * width, 0, 0),
//                             child: MaterialButton(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(25)),
//                               minWidth: MediaQuery.of(context).size.width,
//                               onPressed: () async {
//                                 _showDialogue();
//                                 final signIn = await con.googleSignIn();
//                                 Navigator.pop(context);
//                                 if (signIn) {
//                                   await Navigator.of(context).pushReplacement(
//                                       MaterialPageRoute<void>(
//                                           builder: (context) =>
//                                               const HomePage()));
//                                 } else {
//                                   if (con.inError) {
//                                     await con.msgError(context);
//                                   } else {
//                                     Navigator.pop(context);
//                                   }
//                                 }
//                               },
//                               color: Colors.redAccent,
//                               child: ListTile(
//                                 leading: Image.asset(
//                                   'images/google.png',
//                                   height: 30,
//                                 ),
//                                 title: Text(
//                                   'SignIn With Google',
//                                   style: _btnStyle(),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Visibility(
//                     visible: isLoading ?? true,
//                     child: const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   TextStyle _btnStyle() {
//     return const TextStyle(
//       color: Colors.white,
//       fontWeight: FontWeight.bold,
//     );
//   }
//
//   TextStyle _loginRegStyles() {
//     return const TextStyle(
//       fontWeight: FontWeight.w800,
//       fontSize: 18,
//       letterSpacing: 0.8,
//       color: Color(0xFFB33771),
//     );
//   }
//
//   Future<bool> signUpUser(BuildContext context) async {
// //      formState.reset();
// //      _loadingDialog();
//     final c.FormState formState = _formKey.currentState!;
//     bool signUp = formState.validate();
//     if (signUp) {
//       formState.save();
//       signUp = await con.signUpUser(_nameController.text, _emailController.text,
//           _passwordController.text);
//       if (signUp) {
//         await Navigator.of(context).push(
//             MaterialPageRoute<void>(builder: (context) => const HomePage()));
//       } else {
//         if (con.inError) {
//           await con.msgError(context);
//         }
//       }
//     }
//     return signUp;
//   }
//
//   dynamic _loadingDialog() => _showDialogue(
//           content: Row(
//         children: const [CircularProgressIndicator(), Text('Loading!')],
//       ));
//
//   void _showDialogue({
//     String? text,
//     Widget? content,
//     List<Widget>? buttons,
//   }) {
//     if (text != null && content == null) {
//       content = Text(text.trim());
//     } else {
//       content ??= Row(
//         children: const [
//           CircularProgressIndicator(),
//           SizedBox(
//             width: 20,
//           ),
//         ],
//       );
//     }
//
//     buttons ??= [
//       TextButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         child: const Text('OK'),
//       )
//     ];
//
//     showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return AlertDialog(
//           content: content,
//           actions: buttons,
//         );
//       },
//     );
//   }
// }
