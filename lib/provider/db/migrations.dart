import 'package:scurry/provider/db/db.dart';
import 'package:sqflite/sqflite.dart';

final Map<int, List<DbMigration>> migrations = {
  1: [
    _toDbMigration('''
      CREATE TABLE IF NOT EXISTS scurries (
        id TEXT PRIMARY KEY,
        name TEXT,
        health INTEGER,
        age INTEGER,
        stage TEXT
      )
    '''),
    _toDbMigration('''
      CREATE TABLE IF NOT EXISTS scurryPics (
        id TEXT PRIMARY KEY,
        scurryId TEXT,
        path TEXT
      )
    '''),
    _toDbMigration('''
      CREATE TABLE IF NOT EXISTS scurryInteractions (
        id TEXT PRIMARY KEY,
        scurryId TEXT,
        interaction TEXT,
        interactedAt INTEGER
      )
    ''')
  ]
};

DbMigration _toDbMigration(String sql, {List<Object?>? args}) {
  return (Database db) async {
    await db.execute(sql, args);
  };
}
