// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:api_bazaar/src/model.dart';

import 'package:api_bazaar/src/view.dart';

///
class APIs extends APIsEdit implements Comparable<APIs> {
  ///
  APIs() {
    populate();
  }

  /// Populate this class from the specified Map object.
  APIs.fromMap(Map<String, dynamic> map) {
    populate(map);
  }

  @override
  int compareTo(APIs other) => _description.value
      .toString()
      .compareTo(other._description.value.toString());
}

/// The 'edit' screen
class APIsEdit extends APIsList {
  ///
  APIsEdit() {
    model = APIsDB();
  }

  ///
  late APIsDB model;

  /// The form key for this field class
  GlobalKey<FormState> get formKey {
    if (!_inForm) {
      _inForm = true;
    }
    return _formKey;
  }

  bool _inForm = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// The onPressed() function used to 'save' this field class
  Future<bool> onPressed([BuildContext? context]) async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    _formKey.currentState!.save();
    _inForm = false;
    final added = await add();
    return added;
  }

  /// Add this API record class
  Future<bool> add() => model.addAPIs(this as APIs);

  /// Delete this API record class
  Future<bool> delete() => model.deleteAPIs(this as APIs);

  /// Undelete this API record class
  Future<int> undelete() => model.undeleteAPIs(this as APIs);

  /// Check to see if the record value has changed.
  bool isChanged() =>
      _description.changedFields.whereType<Description>().isNotEmpty;
}

/// The API list
class APIsList extends APIsFields {
  /// Load into a class object.
  void populate([Map<String, dynamic>? map]) {
    //
    final ma = MapClass(map);

    _id = Id(ma.p('id'));

    _label = Label(ma.p('label'));

    _description = Description(ma.p('description'));

    _url = Url(ma.p('url'));

    _key = KeyField(ma.p('key'));
  }

  /// Return to a Map variable
  Map<String, dynamic> get toMap => {
        'id': _id.value,
        'label': _label.value,
        'description': _description.value,
        'url': _url.value,
        'key': _key.value
      };
}

/// Class for API fields
class APIsFields with StateGetter {
  //
  late FormFields _id, _label, _description, _url, _key;

  /// Attach to a State object
  @override
  bool pushState([StateMVC? state]) {
    //
    _id.pushState(state);

    _label.pushState(state);

    _description.pushState(state);

    _url.pushState(state);

    _key.pushState(state);

    return super.pushState(state);
  }

  /// Detach from the State object
  @override
  bool popState() {
    _id.popState();
    _label.popState();
    _description.popState();
    _url.popState();
    _key.popState();
    return super.popState();
  }

  /// The id value for the API record
  Id get id => _id as Id;
  set id(Id id) => _id = id;

  /// The label assigned to the url
  Label get label => _label as Label;
  set label(Label label) => _label = label;

  /// The description of the API url
  Description get description => _description as Description;
  set description(Description name) => _description = name;

  /// The API url
  Url get url => _url as Url;
  set url(Url name) => _url = name;

  /// The Key field
  KeyField get keyField => _key as KeyField;
  set keyField(KeyField key) => _key = key;
}
