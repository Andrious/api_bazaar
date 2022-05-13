// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/view/home/appbar/cart_product_details.dart'
    show CartProductDetails;
import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Color,
        Colors,
        Container,
        Divider,
        EdgeInsets,
        Key,
        ListView,
        MaterialButton,
        Padding,
        Scaffold,
        State,
        StatefulWidget,
        Text,
        Widget;

///
class Cart extends StatefulWidget {
  ///
  const Cart({Key? key}) : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFB33771),
        title: const Text('Cart'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(r'Cart Subtotal (1 item): $ 1100'),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 20),
            child: MaterialButton(
              textColor: Colors.white,
              padding: const EdgeInsets.all(15),
              onPressed: () {},
              color: const Color(0xFFB33771),
              child: const Text('Proceed to Buy'),
            ),
          ),
          const Divider(
            height: 5,
            color: Colors.grey,
          ),
          Container(height: 400, child: CartProductDetails()),
        ],
      ),
    );
  }
}
