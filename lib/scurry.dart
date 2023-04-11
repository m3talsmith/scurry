import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scurry/db_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class Scurry {
  String? id;
  String? name;
  File? pic;

  bool isNewRecord = true;

  static const String table = 'scurries';

  Scurry({this.id, this.name, this.pic});

  Future<Scurry> save() async {
    Database db = await DbProvider.open();
    Scurry.migrate(db);
    if (isNewRecord) {
      id = const Uuid().v4().toString();
    }
    Map<String, Object?> values = {'id': id, 'name': name, 'pic': pic?.path};
    if (isNewRecord) {
      await db.insert(Scurry.table, values);
      isNewRecord = false;
      return this;
    }
    await db.update(Scurry.table, values, where: 'id = $id');
    return this;
  }

  static Future<List<Scurry>> findAll() async {
    Database db = await DbProvider.open();
    Scurry.migrate(db);
    List<Map> results =
        await db.query(Scurry.table, columns: ['id', 'name', 'pic']);
    return results
        .map((e) => Scurry(id: e['id'], name: e['name'], pic: File(e['pic'])))
        .toList();
  }

  static Future<Scurry> find(String id) async {
    Database db = await DbProvider.open();
    Scurry.migrate(db);
    var results = await db.query(Scurry.table, columns: ['id', 'name', 'pic'], where: 'id=?', whereArgs: [id], limit: 1);
    if (results.isNotEmpty) {
      var scurry = results.first;
      return Scurry(id: scurry['id'] as String, name: scurry['name'] as String, pic: File(scurry['pic'] as String));
    }
    return Scurry();
  }

  static migrate(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS ${Scurry.table} (id TEXT PRIMARY KEY, name TEXT, pic TEXT)');
  }
}
