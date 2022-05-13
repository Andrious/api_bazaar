//import 'package:auth/auth.dart' show Auth;

import 'package:api_bazaar/src/view.dart';

///
class Settings extends StatefulWidget {
  ///
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
//    final BazaarApp con = BazaarApp();
//    _auth = con.auth;
  }

//  late Auth _auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFB33771),
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'If you want to reset your password click the button',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: const Color(0xFFB33771),
                minWidth: MediaQuery.of(context).size.width,
                child: ListTile(
                  title: Center(
                    child: Text(
                      'Reset Password',
                      style: _btnStyle(),
                    ),
                  ),
                ),
                onPressed: () async {
//                  await _auth.sendPasswordResetEmail(email: _auth.email);
                  passwordResetDialog();
                }),
          ],
        ),
      ),
    );
  }

  TextStyle _btnStyle() {
    return const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  void passwordResetDialog() {
    final alert = AlertDialog(
      content: Container(
        padding: const EdgeInsets.all(10),
        // child: Text(
        //     'Password Reset Link Has Been Sent To Your EmailID: ${_auth.email}'),
        child:
            const Text('Password Reset Link Has Been Sent To Your EmailID: '),
      ),
    );
    showDialog<void>(context: context, builder: (_) => alert);
  }
}
