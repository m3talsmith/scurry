import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static Database? connection;

  static Future<Database> open({Function(Database)? migrate}) async {
    if (connection != null) {
      migrate!(connection!);
      return connection!;
    }
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, 'scurry.db');
    log('path: $path');
    try {
      await Directory(dbpath).create(recursive: true);
    } catch (_) {}
    connection = await openDatabase(path);
    migrate!(connection!);
    return connection!;
  }
}
