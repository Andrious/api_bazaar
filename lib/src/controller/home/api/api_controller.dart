import 'package:api_bazaar/src/controller.dart';

import 'package:api_bazaar/src/model.dart';

import 'package:api_bazaar/src/view.dart';

/// The Controller for the API database.
class APIsController extends AppController {
  ///
  factory APIsController([StateMVC? state]) =>
      _this ??= APIsController._(state);

  APIsController._([StateMVC? state])
      : model = APIsDB(),
        super(state);

  /// API database
  final APIsDB model;

  static APIsController? _this;

  @override
  Future<bool> initAsync() async {
    _sortedAlpha = Prefs.getBool(sortKEY, false);
    final init = await model.initState();
    if (init) {
      await getAPIs();
    }
    return init;
  }

  static late bool _sortedAlpha;

  /// The preference key
  static const String sortKEY = 'sort_by_alpha';

  @override
  bool onAsyncError(FlutterErrorDetails details) {
    /// Supply an 'error handler' routine if something goes wrong
    /// in the corresponding initAsync() routine.
    /// Returns true if the error was properly handled.
    return false;
  }

  // Merely for demonstration purposes. Erase if not using.
  /// The framework calls this method whenever it removes this [State] object
  /// from the tree.
  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  /// Retrieve the stored API's
  Future<List<APIs>> getAPIs() async {
    _apis = await model.getAPIs();
    if (_sortedAlpha) {
      _apis!.sort();
    }
    return _apis!;
  }

  @override
  Future<void> refresh() async {
    await getAPIs();
    super.refresh();
  }

  /// Called by menu option
  Future<List<APIs>> sort() async {
    _sortedAlpha = !_sortedAlpha;
    await Prefs.setBool(sortKEY, _sortedAlpha);
    await refresh();
    return _apis!;
  }

  /// Form key
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /// List the api entries as items.
  List<APIs>? get items => _apis;
  List<APIs>? _apis;

  /// Return an indexed item.
  APIs? itemAt(int index) => items?.elementAt(index);

  /// Delete indexed item.
  Future<bool> deleteItem(int index) async {
    final APIs? contact = items?.elementAt(index);
    var delete = contact != null;
    if (delete) {
      delete = await contact.delete();
    }
    await refresh();
    return delete;
  }
}
