// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.
///
///  Manages the API request for specifically 'image' public API's
///
import 'package:api_bazaar/src/controller.dart';

import 'package:api_bazaar/src/view.dart';

import 'package:path/path.dart';

/// Represents all the animals widgets.
abstract class ImageAPIStatefulWidget extends StatefulWidget {
  ///
  ImageAPIStatefulWidget({
    Key? key,
    this.uri,
    this.keyField,
    this.builder,
    this.showError,
  })  : controller = ImageAPIController(),
        super(key: key);

  ///
  final ImageAPIController controller;

  /// Implement this function
  @override
  State<StatefulWidget> createState();

  ///
  final Uri? uri;

  ///
  final String? keyField;

  /// Optional builder
  final Widget Function(ImageAPIStatefulWidget imageWidget)? builder;

  /// Show Erros or not
  final bool? showError;

  /// Current url
  String get url => controller.url ?? '';

  /// Current file
  String get file => basename(url);

  /// Current image
  Image? get image => controller.image;
}

///
class ImageAPIStateMVC<T extends ImageAPIStatefulWidget> extends StateMVC<T>
    with FutureBuilderStateMixin
    implements ImageAPIState {
  ///
  ImageAPIStateMVC() : super();

  @override
  void initState() {
    super.initState();
    add(widget.controller);
    _con = controller as ImageAPIController;
    key = widget.keyField;
    uri = widget.uri;
    builder = widget.builder;
    showError = widget.showError ?? false;
  }

  late ImageAPIController _con;

  ///
  @override
  late Uri? uri;

  ///
  @override
  late String? key;

  /// Optional builder
  late Widget Function(ImageAPIStatefulWidget imageWidget)? builder;

  /// Show Errors or not
  late bool showError;

  /// The widget displayed instead in case of error.
  Widget _errorWidget = const SizedBox();

  @override
  Future<bool> initAsync() async {
    bool init;
    try {
      init = await super.initAsync();
      if (init) {
        init = await _con.initAsync();
      }
    } catch (e) {
      // Always true
      init = true;

      if (showError) {
        //
        final errorDetails = FlutterErrorDetails(
          exception: e,
          stack: e is Error ? e.stackTrace : null,
          library: 'image_api.dart',
          context: ErrorDescription('While getting data'),
        );

        FlutterError.reportError(errorDetails);

        _errorWidget = ErrorWidget.builder(errorDetails);
      }
    }
    return init;
  }

  /// Called after the FutureBuilder
  @override
  Widget buildWidget(BuildContext context) {
    _con.widgetInherited(context);
    return GestureDetector(
      // onTap: con?.newAnimals,
      // onDoubleTap: con?.newAnimals,
      child: Card(
        child: builder != null && _con.image != null
            ? builder!(widget)
            : _con.image ?? _errorWidget,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    remove((oldWidget as ImageAPIStatefulWidget).controller.keyId);
    final con = widget.controller;
    add(con);
    _con = con;
  }

  /// Supply an 'error handler' routine if something goes wrong
  /// in the corresponding initAsync() routine.
  @override
  bool onAsyncError(FlutterErrorDetails details) => false;
}

///
abstract class ImageAPIState {
  ///
  ImageAPIState({required this.uri, required this.key});

  ///
  final Uri? uri;

  ///
  final String? key;
}
