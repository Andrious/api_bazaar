import 'package:api_bazaar/src/view.dart' hide Contact;

import 'api_model.dart' show APIs;

/// Add to the class this:
/// `extends FieldWidgets<T> with FieldChange`
mixin FormFields on FieldWidgets<APIs> {
  ///
  Set<FieldWidgets<APIs>> get changedFields => _changedFields;

  static final Set<FieldWidgets<APIs>> _changedFields = {};

  /// If the field's value changed, that field is added to a Set.
  @override
  void onSaved(dynamic v) {
    super.onSaved(v);
    if (isChanged()) {
      _changedFields.add(this);
    }
  }

  /// The change indicator.
  bool changeIn<T>() => changedFields.whereType<T>().isNotEmpty;
}

/// The 'id' field class.
class Id extends FieldWidgets<APIs> with FormFields {
  ///
  Id(dynamic value) : super(label: 'Identifier', value: value);
}

/// Test for empty String.
String? notEmpty(String? v) =>
    v != null && v.isEmpty ? 'Cannot be empty' : null;

/// The URL label
class Label extends FieldWidgets<APIs> with FormFields {
  ///
  Label([dynamic value])
      : super(
          label: 'Label'.tr,
          value: value,
          validator: notEmpty,
          keyboardType: TextInputType.name,
        );
}

/// The URL description
class Description extends FieldWidgets<APIs> with FormFields {
  ///
  Description([dynamic value])
      : super(
          label: 'Description'.tr,
          value: value,
          validator: notEmpty,
          keyboardType: TextInputType.name,
        );
}

/// The URL
class Url extends FieldWidgets<APIs> with FormFields {
  ///
  Url([dynamic value])
      : super(
          label: 'URL'.tr,
          value: value,
          validator: notEmpty,
          keyboardType: TextInputType.name,
        ) {
    _url = value;
    _uri = Uri.tryParse(value);
  }

  /// The url String
  String? get url => _url;
  String? _url;

  /// The Uri object representing the URL value.
  Uri? get uri => _uri;
  Uri? _uri;
}

/// The Key field
class KeyField extends FieldWidgets<APIs> with FormFields {
  ///
  KeyField([dynamic value])
      : super(
          label: 'Key'.tr,
          value: value,
          validator: notEmpty,
          keyboardType: TextInputType.name,
        ) {
    _key = value;
  }

  /// The key String
  String? get keyField => _key;
  String? _key;
}
