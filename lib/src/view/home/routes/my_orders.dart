import 'package:api_bazaar/src/view.dart';

///
class MyOrders extends StatelessWidget {
  ///
  const MyOrders({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFB33771),
        title: const Text('My Orders'),
      ),
      body: Container(
        height: 400,
        child: const CartProductDetails(),
      ),
    );
  }
}
