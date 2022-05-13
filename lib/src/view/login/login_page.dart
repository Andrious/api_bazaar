import 'package:api_bazaar/src/controller.dart';

import 'package:api_bazaar/src/view.dart';

//import 'package:flutter/services.dart' show TextInputType;

///
class Login extends StatefulWidget {
  ///
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends StateMVC<Login> with SingleTickerProviderStateMixin {
  _LoginState() : super(LoginPage()) {
    con = controller as LoginPage;
    isLoggedin = con.loggedIn;
  }
  late LoginPage con;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _resetKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late Animation animation, delayAnimation, muchDelayedAnimation;
  late AnimationController animationController;

  bool loading = false;
  bool hidePass = true;
  bool isLoggedin = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    animation = Tween(begin: -1.0, end: 0).animate(
      CurvedAnimation(curve: Curves.fastOutSlowIn, parent: animationController),
    );
    delayAnimation = Tween(begin: -1.0, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1, curve: Curves.fastOutSlowIn),
      ),
    );
    muchDelayedAnimation = Tween(begin: -1.0, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.7, 1, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (!isLoggedin) {
      animationController.forward();
    }
    return Stack(children: [
      const APIImages(),
      if (!isLoggedin)
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child) {
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    stops: [0.5, 0.8],
                    colors: [
                      Colors.cyanAccent,
                      Colors.tealAccent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Transform(
                        transform: Matrix4.translationValues(
                            animation.value * width, 0, 0),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          alignment: Alignment.center,
                          child: const Text(
                            'API Bazaar',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Transform(
                        transform: Matrix4.translationValues(
                            animation.value * width, 0, 0),
                        child: const Center(
                          child: Text(
                            'Welcome Back. Enjoy your shopping.',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Transform(
                            transform: Matrix4.translationValues(
                                animation.value * width, 0, 0),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                              child: Text(
                                'Login',
                                style: _regStyle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute<void>(
                              //     builder: (context) => const SignUp()));
                            },
                            child: Transform(
                              transform: Matrix4.translationValues(
                                  animation.value * width, 0, 0),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                                alignment: Alignment.center,
                                child: Text(
                                  'Register',
                                  style: _regStyle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Transform(
                        transform: Matrix4.translationValues(
                            delayAnimation.value * width, 0, 0),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.alternate_email,
                                        color: Colors.blueGrey),
                                    hintText: 'Email',
                                    labelStyle: TextStyle(
                                        // color: Colors.white,
                                        ),
                                    labelText: 'Email'),
                                // validator: (val) {
                                //   if (val.isEmpty) {
                                //     return "Please Provide Email";
                                //   }
                                //   return null;
                                // },
                                onSaved: (val) {
                                  _emailController.text = val!;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                // obscureText:hidepass we toggle when user clicks the icon
                                obscureText: hidePass,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.blueGrey,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: hidePass
                                          ? const Icon(Icons.visibility_off,
                                              color: Colors.blueGrey)
                                          : const Icon(Icons.visibility,
                                              color: Colors.blueGrey),
                                      onPressed: () {
                                        setState(() {
                                          hidePass = !hidePass;
                                        });
                                      },
                                    ),
                                    hintText: 'Password',
                                    labelText: 'Password'),
                                validator: (val) {
                                  if (val!.isNotEmpty && val.length < 6) {
                                    return 'Password must contain at least 6 characters';
                                    // } else if (val.isEmpty) {
                                    //   return "Password field can't be empty";
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  _passwordController.text = val!;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //  ================== Login Btn =======================
                              Transform(
                                transform: Matrix4.translationValues(
                                    muchDelayedAnimation.value * width, 0, 0),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  minWidth: MediaQuery.of(context).size.width,
                                  onPressed: () {
                                    isLoggedin = true;
                                    setState(() {});
                                  },
                                  color: const Color(0xFFB33771),
                                  child: const ListTile(
                                    title: Center(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Transform(
                                transform: Matrix4.translationValues(
                                    muchDelayedAnimation.value * width, 0, 0),
                                child: InkWell(
                                  onTap: () async {
                                    _showFormDialog();
                                  },
                                  child: const Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xFFB33771),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: loading, // ?? true,
                        child: const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
    ]);
  }

  TextStyle get _regStyle => const TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 18,
        letterSpacing: 0.8,
        color: Color(0xFFB33771),
      );

  void _showFormDialog() {
    final alert = AlertDialog(
      content: ListTile(
        title: Text(
            'Password Reset Link Will Be Sent To Your EmailID: ${_emailController.text}'),
        subtitle: Form(
          child: TextFormField(
            key: _resetKey,
            autovalidateMode: AutovalidateMode.always,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.alternate_email, color: Colors.blueGrey),
              hintText: 'Enter Your Email',
              labelText: 'Email',
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return 'Please Provide Email';
              }
              return null;
            },
            onSaved: (val) {
              _emailController.text = val!;
            },
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            // if (_resetKey.currentState.validate()) {
            //   _resetKey.currentState.save();
            //   _resetKey.currentState.reset();
            //   await firebaseAuth.sendPasswordResetEmail(
            //       email: _emailController.text);
            //   Navigator.of(context).pop();
            // }
            Navigator.of(context).pop();
          },
          child: const Text('Send'),
        ),
      ],
    );
    showDialog<void>(context: context, builder: (_) => alert);
  }

  void _showLoadingIndicator() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: const <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                width: 20,
              ),
              Text('Loading!')
            ],
          ),
        );
      },
    );
  }
}
