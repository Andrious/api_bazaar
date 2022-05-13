// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/controller.dart'
    show ControllerMVC, ProductSearch;

import 'package:api_bazaar/src/view.dart' show Cart;

import 'package:flutter/material.dart'
    show
        Icon,
        IconButton,
        Icons,
        MaterialPageRoute,
        Navigator,
        Widget,
        showSearch;

///
class HomeAppBar extends ControllerMVC {
  ///
  factory HomeAppBar() => _this ??= HomeAppBar._();
  HomeAppBar._();
  static HomeAppBar? _this;

  ///
  Widget get search => IconButton(
        icon: const Icon(Icons.search),
        onPressed: () async {
          await showSearch(
              context: stateMVC!.context, delegate: ProductSearch());
          refresh();
        },
      );

  ///
  Widget get cart => IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.of(stateMVC!.context).push(
              MaterialPageRoute<void>(builder: (context) => const Cart()));
        },
      );
}
