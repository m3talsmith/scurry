import 'dart:io';

import 'package:path/path.dart';
import 'package:scurry/provider/db/migrations.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static Database? _connection;
  static final Map<int, List<DbMigration>> _migrations = migrations;

  static registerMigration({required DbMigration migration, int? version}) {
    List<int> versions = _migrations.keys.toList()..sort();
    version ??= versions.last + 1;
    if (_migrations.containsKey(version)) {
      _migrations[version]?.add(migration);
      return;
    }
    _migrations[version] = [migration];
  }

  static migrate(Database db) async {
    int version = await db.getVersion();
    List<int> versions = _migrations.keys.toList()
      ..where((v) => v >= version).toList()
      ..sort();
    for (int v in versions) {
      for (DbMigration migration in _migrations[v]!) {
        await migration(db);
      }
    }
  }

  static Future<Database> open() async {
    if (_connection != null) {
      migrate(_connection!);
      return _connection!;
    }
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, 'scurry.db');

    // Create dbpath if it does not exist
    try {
      await Directory(dbpath).create(recursive: true);
    } catch (_) {
      // dbpath exists; ignore the exception
    }

    _connection = await openDatabase(path);
    migrate(_connection!);
    return _connection!;
  }
}

typedef DbMigration = Future<void> Function(Database);
