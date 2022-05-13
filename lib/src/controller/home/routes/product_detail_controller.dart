// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/controller.dart' show ControllerMVC;

import 'package:api_bazaar/src/view.dart' as v;

import 'package:flutter/material.dart'
    show Color, Icon, IconButton, Icons, MaterialPageRoute, Navigator, Widget;

///
class ProductDetails extends ControllerMVC {
  ///
  factory ProductDetails() => _this ??= ProductDetails._();
  ProductDetails._();
  static ProductDetails? _this;

  ///
  bool selected = false;

  ///
  late v.ProductDetailsState _state;

  @override
  void initState() {
    super.initState();
    _state = stateMVC as v.ProductDetailsState;
//    selected = Prefs.getBool(_state.widget.child);
  }

  @override
  void deactivate() {
//    Prefs.setBool(_state.widget.child, selected);
  }

  ///
  Widget get shopping => IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.of(_state.context).push(
              MaterialPageRoute<void>(builder: (context) => const v.Cart()));
        },
      );

  ///
  Widget get iconButton => IconButton(
        color: const Color(0xFFB33771),
        icon: Icon(selected ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          selected = !selected;
          refresh();
        },
      );
}
