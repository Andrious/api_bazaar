import 'dart:core';

import 'package:api_bazaar/src/model.dart';

import 'package:dbutils/sqlite_db.dart' show Database, SQLiteDB, Transaction;

/// The database storing the API's.
class APIsDB extends SQLiteDB {
  /// Allows for one instance
  factory APIsDB() => _this ??= APIsDB._();
  APIsDB._() : super();
  static APIsDB? _this;

  @override
  String get name => 'APIs';

  @override
  int get version => 1;

  /// Initialize the database
  Future<bool> initState() => init();

  /// Close the database.
  void dispose() => disposed();

  @override
  Future<void> onConfigure(Database db) {
    return db.execute('PRAGMA foreign_keys=ON;');
  }

  @override
  Future<void> onCreate(Database db, int version) async {
    //
    await db.transaction((Transaction txn) async {
      await txn.execute('''
     CREATE TABLE APIs(
              id INTEGER PRIMARY KEY
              ,label TEXT
              ,description TEXT
              ,url TEXT
              ,key TEXT
              ,deleted INTEGER DEFAULT 0
              )
     ''');

      await txn.execute('''
      INSERT INTO APIs(label, description, url, key) VALUES ("Bird", "Bird Pictures", "https://shibe.online/api/birds", ""),
      ("Cat", "Cat Pictures", "https://aws.random.cat/meow", "file"),
      ("Dog", "Dog Pictures", "https://dog.ceo/api/breeds/image/random/1", "message"),
      ("Fox", "Fox Pictures", "https://randomfox.ca/floof", "image"),
      ("Cat", "Cat", "https://nekos.life/api/v2/img/meow", "url"),
      ("Duck", "Duck", "https://random-d.uk/api/v1/random?type=jpg,png", "url"),
      ("Koala", "Koala", "https://some-random-api.ml/img/koala", "link"),
      ("Lizard", "Lizard", "https://nekos.life/api/v2/img/lizard", "url"),
      ("Panda", "Panda", "https://some-random-api.ml/img/panda", "link"),
      ("Racoon", "Racoon", "https://some-random-api.ml/img/racoon", "link"),
      ("Whale", "Whale", "https://some-random-api.ml/img/whale", "link")
      ''');
    }, exclusive: true);
  }

  /// Retrieve a list of API's.
  Future<List<APIs>> getAPIs() async {
    return listAPIs(
        await _this!.rawQuery('SELECT * FROM APIs WHERE deleted = 0'));
  }

  /// Retrieve a list of API's.
  Future<List<APIs>> listAPIs(List<Map<String, dynamic>> query) async {
    //
    final apiList = <APIs>[];

    for (final api in query) {
      //
      final map = api.map((key, value) {
        return MapEntry(key, value is int ? value.toString() : value);
      });

      final _api = APIs.fromMap(map);

      apiList.add(_api);
    }

    return apiList;
  }

  /// Add an API entry.
  Future<bool> addAPIs(APIs api) async {
    //
    var add = true;

    final map = api.toMap;

    // The Contact's unique id
    dynamic id = map['id'];

    if (api.isChanged()) {
      //
      final newContact = await _this!.saveMap('APIs', map);

      id ??= newContact['id'];

      add = newContact.isNotEmpty;
    }
    return add;
  }

  void func(key, value) {}

  /// Delete of specified API
  Future<bool> deleteAPIs(APIs api) async {
    //
    final map = api.toMap;
    //
    final id = map['id'];

    if (id == null) {
      return Future.value(false);
    }

    Map<String, dynamic> rec;

    rec = _this!.newRec('APIs', map);

    rec['deleted'] = 1;

    rec = await _this!.saveMap('APIs', rec);

    return rec.isNotEmpty;
  }

  /// Undelete specified entry
  Future<int> undeleteAPIs(APIs api) async {
    //
    final map = api.toMap;

    var id = map['id'];

    if (id == null) {
      return Future.value(0);
    }

    if (id is String) {
      id = int.parse(id);
    }

    final query =
        await _this!.rawQuery('UPDATE APIs SET deleted = 0 WHERE id = $id');

    final rec = query.length;

    return rec;
  }
}
