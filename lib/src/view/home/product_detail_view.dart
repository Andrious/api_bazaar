import 'package:api_bazaar/src/controller.dart' as c;

import 'package:api_bazaar/src/view.dart';

///
class ProductDetails extends StatefulWidget {
  ///
  const ProductDetails({
    Key? key,
    required this.child,
  }) : super(key: key);

  ///
  final ImageAPIStatefulWidget child;

  @override
  ProductDetailsState createState() => ProductDetailsState();
}

///
class ProductDetailsState extends StateMVC<ProductDetails> {
  ///
  ProductDetailsState() : super(c.ProductDetails()) {
    con = controller as c.ProductDetails;
  }

  ///
  late c.ProductDetails con;

  ///
  late ImageAPIStatefulWidget imageWidget;

  @override
  Widget build(BuildContext context) {
    imageWidget = widget.child;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFB33771),
        title: const Text('e-Bazaar'),
        actions: <Widget>[
          con.shopping,
        ],
      ),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  imageWidget.file,
                  style: const TextStyle(
                      color: Color(0xFFB33771),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: con.iconButton,
              ),
            ],
          ),
          Container(
            height: 300,
            child: imageWidget.image,
          ),
          // --------------- Size , Color ,Quantity Buttons------------------
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      const Text('Size'),
                      IconButton(
                        onPressed: () {
                          _showDialog('Size', 'Choose Size');
                        },
                        icon: const Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      const Text('Color'),
                      IconButton(
                        onPressed: () {
                          _showDialog('Color', 'Choose Color');
                        },
                        icon: const Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      const Text('Qty'),
                      IconButton(
                        onPressed: () {
                          _showDialog('Quantity', 'Choose Quantity');
                        },
                        icon: const Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // // ------------------- Price Details ------------------
          //
          // Padding(
          //   padding: const EdgeInsets.only(top: 20, left: 20),
          //   child: Row(
          //     children: <Widget>[
          //       const Text('M.R.P. :  '),
          //       Text(
          //         ' \$ ${widget.productDetailsoldPrice}',
          //         style: const TextStyle(
          //             fontWeight: FontWeight.w500,
          //             decoration: TextDecoration.lineThrough),
          //       ),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 20, left: 20),
          //   child: Row(
          //     children: <Widget>[
          //       const Text('Price :  '),
          //       Text(
          //         ' \$ ${widget.productDetailsPrice}',
          //         style: const TextStyle(
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 20, left: 20),
          //   child: Row(
          //     children: <Widget>[
          //       const Text('You Save :  '),
          //       Text(
          //         ' \$ ${widget.productDetailsoldPrice - widget.productDetailsPrice} Inclusive all taxes',
          //         style: const TextStyle(
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          //  ---------------------- Buy Now and Add to Cart Buttons ------------

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: MaterialButton(
              textColor: Colors.white,
              padding: const EdgeInsets.all(15),
              onPressed: () {},
              color: const Color(0xFFB33771),
              child: const Text('Buy Now'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
            child: MaterialButton(
              textColor: Colors.white,
              padding: const EdgeInsets.all(15),
              onPressed: () {
                showDialog<void>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text('Product added to the Cart'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    });
              },
              color: const Color(0xFFB33771),
              child: const Text('Add to Cart'),
            ),
          ),

          // // -------- About this Item ------------
          // Padding(
          //   padding: const EdgeInsets.only(left: 5, top: 20, bottom: 20),
          //   child: ListTile(
          //     title: const Text(
          //       'About this Item',
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //     subtitle: Padding(
          //       padding: const EdgeInsets.only(top: 5),
          //       child: Text('${widget.productDetailsDesc}'),
          //     ),
          //   ),
          // ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Text(
              'Similar Products',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Container(
            height: 400,
            padding: const EdgeInsets.only(bottom: 20),
            child: const SimilarProducts(),
          ),
        ],
      ),
    );
  }

  void _showDialog(String s, String c) {
    final _alert = AlertDialog(
      title: Text(s),
      content: Text(c),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
    showDialog<void>(context: context, builder: (context) => _alert);
  }
}
