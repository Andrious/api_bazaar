// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/model.dart';

import 'package:api_bazaar/src/view.dart';

///
class RandomAnimal extends ImageAPIStatefulWidget {
  ///
  RandomAnimal({
    Key? key,
    required this.api,
    Widget Function(ImageAPIStatefulWidget imageWidget)? builder,
    bool? showError,
  }) : super(
          key: key,
          uri: api.url.uri,
          keyField: api.keyField.value,
          builder: builder,
          showError: showError ?? true,
        );

  /// Take in an API object.
  final APIs api;

  @override
  //ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _RandomState();
}

class _RandomState extends ImageAPIStateMVC<RandomAnimal> {}
