// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart'
    show
        BorderRadius,
        BoxDecoration,
        BuildContext,
        Card,
        Center,
        Colors,
        Column,
        Container,
        Dismissible,
        EdgeInsets,
        Expanded,
        Icon,
        IconButton,
        Icons,
        Image,
        Key,
        ListTile,
        ListView,
        MainAxisAlignment,
        Padding,
        Row,
        State,
        StatefulWidget,
        Text,
        TextStyle,
        Widget;

///
class CartProductDetails extends StatefulWidget {
  ///
  const CartProductDetails({
    Key? key,
    this.cartProductName,
    this.cartProductImage,
    this.cartProductPrice,
    this.cartProductSize,
    this.cartProductColor,
    this.cartProductQty,
  }) : super(key: key);

  ///
  final cartProductName;

  ///
  final cartProductImage;

  ///
  final cartProductPrice;

  ///
  final cartProductSize;

  ///
  final cartProductColor;

  ///
  final cartProductQty;

  @override
  _CartProductDetailsState createState() => _CartProductDetailsState();
}

class _CartProductDetailsState extends State<CartProductDetails> {
  final List<Map<String, dynamic>> _productsAddedInTheCart = [
    {
      'name': 'Blazer',
      'image': 'images/recentImages/blazer1.jpeg',
      'price': 900,
      'size': 'M',
      'color': 'Blue',
      'qty': 1,
    },
    {
      'name': 'Dress',
      'image': 'images/recentImages/dress2.jpeg',
      'price': 200,
      'size': 'L',
      'color': 'Red',
      'qty': 5,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _productsAddedInTheCart.length,
      itemBuilder: (BuildContext context, int i) {
        return Padding(
          padding: const EdgeInsets.all(8),

          // --------------- Deletes the items in the cart by swiping ----------
          child: Dismissible(
            key: Key(_productsAddedInTheCart[i]['name']),
            onDismissed: (direction) {
              setState(() {
                _productsAddedInTheCart.removeAt(i);
              });
              // ------------------- Trying to Implement Undo operation ------------------
              // Scaffold.of(context).showSnackBar(
              //   SnackBar(
              //     content: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: <Widget>[
              //         Expanded(
              //             child: Text(
              //                 "${_productsAddedInTheCart[i]["name"]} dismissed")),
              //         Expanded(child: Text("Undo")),
              //       ],
              //     ),
              //   ),
              // );
            },
            background: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              child: const Center(
                child: ListTile(
                  leading: Text(
                    'Archive',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  ),
                ),
              ),
              // color: Colors.red,
            ),
            child: Card(
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: Image.asset(
                        _productsAddedInTheCart[i]['image'],
                      ),
                      title: Text("${_productsAddedInTheCart[i]['name']}"),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: Text(
                                  "\$ ${_productsAddedInTheCart[i]['price']}")),
                          IconButton(
                            icon: const Icon(Icons.arrow_drop_down),
                            onPressed: () => decrementInQty(i),
                          ),
                          Text("${_productsAddedInTheCart[i]['qty']}"),
                          IconButton(
                            icon: const Icon(Icons.arrow_drop_up),
                            onPressed: () => incrementInQty(i),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: Text(
                                "Qty: ${_productsAddedInTheCart[i]['qty']}")),
                        Expanded(
                            child: Text(
                                "Size: ${_productsAddedInTheCart[i]['size']}")),
                        Expanded(
                          child: Text(
                              "Color: ${_productsAddedInTheCart[i]['color']}"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void incrementInQty(int index) {
    setState(() {
      _productsAddedInTheCart[index]['qty'] =
          _productsAddedInTheCart[index]['qty'] + 1;
    });
  }

  void decrementInQty(int index) {
    setState(() {
      _productsAddedInTheCart[index]['qty'] =
          _productsAddedInTheCart[index]['qty'] - 1;
    });
  }
}
