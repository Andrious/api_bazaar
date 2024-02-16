// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/controller.dart';

import 'package:api_bazaar/src/model.dart';

import 'package:api_bazaar/src/view.dart';

///
class RandomAnimals extends ControllerMVC {
  /// Optionally supply a State object
  factory RandomAnimals([StateMVC? state]) => _this ??= RandomAnimals._(state);

  RandomAnimals._([StateMVC? state]) : super(state) {
    //
    apis = APIsController();

    final apiList = apis.items;

    if (apiList != null) {
      // The 'default'
      _currentAPI = apiList[0];

      for (final api in apiList) {
        final label = api.label.value;
        if (label != null) {
          species.add(label.trim());
        }
      }
    }
  }
  static RandomAnimals? _this;

  @override
  void initState() {
    super.initState();
    reload();
  }

  /// The API's available to you.
  late APIsController apis;

  /// The list of animals currently available
  final List<String> species = []; //['bird', 'cat', 'dog', 'fox'];

  /// The chosen animal to display
  APIs? get currentAPI => _currentAPI;

  APIs? _currentAPI;

  set currentAPI(APIs? v) {
    if (v != null) {
      if (apis.items!.contains(v)) {
        _currentAPI = v;
      }
    }
  }

  /// The List of images of the chosen animal
  List<ImageAPIStatefulWidget> get animals => _animals;
  final List<ImageAPIStatefulWidget> _animals = [];

  /// The number of images
  int imageCount = 14;

  /// Load particular Widgets
  List<ImageAPIStatefulWidget>? load({
    APIs? api,
    int? count,
    Widget Function(ImageAPIStatefulWidget imageWidget)? builder,
    bool? showError,
  }) {
    //
    api ??= _currentAPI;

    // Can't continue
    if (api == null) {
      return null;
    }

    count ??= imageCount;

    final List<ImageAPIStatefulWidget> widgets = [];

    int cnt = 0;

    while (cnt < count) {
      cnt++;
      // switch (animal) {
      //   case 'bird':
      //     widgets.add(RandomBird(builder: builder));
      //     break;
      //   case 'cat':
      //     widgets.add(RandomCat(builder: builder));
      //     break;
      //   case 'dog':
      //     widgets.add(RandomDog(builder: builder));
      //     break;
      //   case 'fox':
      //     widgets.add(RandomFox(builder: builder));
      // }

      widgets
          .add(RandomAnimal(api: api, builder: builder, showError: showError));
    }
    return widgets;
  }

  /// Returns the animal represented by the Widget
  String whichAnimal(ImageAPIStatefulWidget child) {
    late String animal;
    animal = 'bird';

    // if (child is RandomBird) {
    //   animal = 'bird';
    // } else if (child is RandomCat) {
    //   animal = 'cat';
    // } else if (child is RandomDog) {
    //   animal = 'dog';
    // } else if (child is RandomFox) {
    //   animal = 'fox';
    // } else {
    //   animal = '';
    // }
    return animal;
  }

  /// Load particular Widgets to a property.
  List<Widget> reload({
    APIs? api,
    int? count,
    Widget Function(Widget child)? builder,
  }) {
    //
    if (api != null) {
      _currentAPI = api;
    }

    _animals.clear();

    final widget =
        load(api: api, count: count, builder: builder, showError: false);

    if (widget != null) {
      _animals.addAll(widget);
    }
    return _animals.isEmpty ? [const SizedBox()] : _animals;
  }

  /// Load particular Widgets
  List<Widget> loadOfEach({
    required int count,
    Widget Function(ImageAPIStatefulWidget imageWidget)? builder,
  }) {
    //
    final List<Widget> animals = [];

    final apiList = apis.items;

    if (apiList != null) {
      //
      for (final animal in apiList) {
        //
        final animalList = load(
          api: animal,
          count: count,
          builder: builder,
        );

        // An 'empty' result
        if (animalList == null) {
          animals.add(const SizedBox());
          continue;
        }

        for (final thisAnimal in animalList) {
          //
          final image = GridTile(
            footer: Container(
              height: 30,
              color: Colors.black54,
              child: Center(
                child: Builder(builder: (context) {
                  widgetInherited(context);
                  Text? label;
                  final String? value = animal.label.value;
                  if (value != null) {
                    label = Text(
                      L10n.s(value.toLowerCase()),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    );
                  }
                  return label ?? const SizedBox();
                }),
              ),
            ),
            child: thisAnimal,
          );
          // Add to the List variable
          animals.add(image);
        }
      }
    }
    return animals;
  }
}
