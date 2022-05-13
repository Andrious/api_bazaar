//import 'package:auth/auth.dart' show Auth;

import 'package:api_bazaar/src/controller.dart' show BazaarApp;

import 'package:api_bazaar/src/view.dart' hide BazaarApp;

///
class MyAccount extends StatefulWidget {
  ///
  const MyAccount({Key? key}) : super(key: key);
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
//  late Auth _auth;

  @override
  void initState() {
    final BazaarApp con = BazaarApp();
//    _auth = con.auth;
    super.initState();
  }

  String get userName {
    // if (_auth.displayName == null || _auth.displayName.isEmpty) {
    //   return _auth.email.replaceAll('@gmail.com', '');
    // }
    // return _auth.displayName;
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFB33771),
        title: const Text('MyAccount'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 20),
              child: const Text(
                'Login & Security',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: const Text(
                      'Name:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      userName,
                    ),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: const Text(
                      'Email:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(''
                        //                     _auth.email,
                        ),
                  ),
                  const Divider(
                    height: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              onPressed: () {
                // _auth.signOut().then((_) {
                //   Navigator.of(context).pop();
                //   //                 Navigator.of(context).pop();
                //
                //   Navigator.of(context).pushReplacement(
                //       MaterialPageRoute<void>(builder: (context) => Login()));
                // }).catchError((e) => print(e.toString()));
              },
              color: const Color(0xFFB33771),
              child: const ListTile(
                title: Center(
                  child: Text(
                    'LogOut',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
