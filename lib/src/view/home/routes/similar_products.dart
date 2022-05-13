// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/controller.dart';

///
class SimilarProducts extends StatefulWidget {
  ///
  const SimilarProducts({Key? key}) : super(key: key);

  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  // final _products = [
  //   {
  //     'name': 'Blazer',
  //     'image': 'images/recentImages/blazer1.jpeg',
  //     'oldPrice': 1200,
  //     'price': 900,
  //   },
  //   {
  //     'name': 'Dress',
  //     'image': 'images/recentImages/dress1.jpeg',
  //     'oldPrice': 888,
  //     'price': 200,
  //   },
  //   {
  //     'name': 'Heals1',
  //     'image': 'images/recentImages/skt1.jpeg',
  //     'oldPrice': 1020,
  //     'price': 910,
  //   },
  //   {
  //     'name': 'Heals',
  //     'image': 'images/recentImages/hills1.jpeg',
  //     'oldPrice': 1020,
  //     'price': 910,
  //   },
  // ];

  @override
  void initState() {
    super.initState();
    _products = RandomAnimals().load(count: 4) ?? [const SizedBox()];
  }

  late List<Widget> _products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _products.length,
      itemBuilder: (BuildContext context, int i) {
        return Card(
          child: Hero(
            tag: _products[i],
            child: Material(
              child: InkWell(
                child: GridTile(
                  // footer: Container(
                  //   height: 30,
                  //   color: Colors.black54,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(5),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: <Widget>[
                  //         Text(
                  //           "${_products[i]['name']}",
                  //           style: const TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.white),
                  //         ),
                  //         Text(
                  //           "\$ ${_products[i]['price']}",
                  //           style: const TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.white),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // child: Image.asset(
                  //   _products[i]['image'] as String,
                  //   fit: BoxFit.cover,
                  // ),
                  child: _products[i],
                ),
              ),
            ),
          ),
        );
      },
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }
}
