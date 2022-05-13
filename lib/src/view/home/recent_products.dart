// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/controller.dart' as c;

import 'package:api_bazaar/src/view.dart';

///
class RecentProducts extends StatefulWidget {
  ///
  const RecentProducts({Key? key}) : super(key: key);

  ///
  static void search(String word) => _RecentProductsState.search(word);

  ///
  static void clear() => _RecentProductsState.clear();

  @override
  _RecentProductsState createState() => _RecentProductsState();
}

class _RecentProductsState extends StateMVC<RecentProducts> {
  _RecentProductsState() : super(c.HomeAppBar()) {
    con = c.RandomAnimals();
    add(con);
  }
  late c.RandomAnimals con;

  static void search(String word) {
    // final String search = word.toLowerCase();
    // items = productsItems.where((m) {
    //   final String name = m['name'];
    //   return name.toLowerCase().contains(search);
    // }).toList();
  }

  static void clear() => items = null;

//  static List<Map<String, dynamic>>? items;
  static List<ImageAPIStatefulWidget>? items;

  List<ImageAPIStatefulWidget>? itemsList;

  @override
  Widget build(BuildContext context) {
    // link to an InheritedWidget
    APIImages.dependOnInheritedWidget(context);
    if (items == null) {
      itemsList = con.animals;
    } else {
      itemsList = items;
    }
    return ScrollConfiguration(
      behavior: BrowserScrollBehavior(),
      child: GridView.builder(
        itemCount: itemsList!.length,
        itemBuilder: (BuildContext context, int i) {
          return Card(
            child: Hero(
              tag: itemsList![i].url,
              child: Material(
                child: InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) =>
                          ProductDetails(child: itemsList![i]),
                    ),
                  ),
                  child: itemsList![i],
                ),
              ),
            ),
          );
        },
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
  }
}
