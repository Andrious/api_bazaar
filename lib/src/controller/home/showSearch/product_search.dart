// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/model.dart' show recentSearchProd, searchProd;

import 'package:api_bazaar/src/view.dart' show RecentProducts;

import 'package:flutter/material.dart'
    show
        AnimatedIcon,
        AnimatedIcons,
        BuildContext,
        Center,
        CircularProgressIndicator,
        Colors,
        FontWeight,
        Icon,
        IconButton,
        Icons,
        ListTile,
        ListView,
        RichText,
        SearchDelegate,
        TextSpan,
        TextStyle,
        Widget;

// SearchBar

///
class ProductSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for appbar
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(
    BuildContext context,
  ) {
    // show results for given keyword

    return const Center(
        child: CircularProgressIndicator(backgroundColor: Colors.redAccent));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // shows suggestions for keyword
    final suggestionList = query.isEmpty
        ? recentSearchProd
        : searchProd.where((s) => s.toLowerCase().startsWith(query)).toList();
    RecentProducts.clear();
    // contains,startswith,endswith and so on
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (_, int i) {
        return ListTile(
          onTap: () {
//            showResults(context);
            RecentProducts.search(suggestionList[i]);
            close(context, '');
          },
          leading: const Icon(Icons.shopping_basket),
          title: RichText(
            text: TextSpan(
              text: suggestionList[i].substring(0, query.length),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[i].substring(query.length),
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        );
      },
    );
  }
}
