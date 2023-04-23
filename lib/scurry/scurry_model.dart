import 'dart:math';

import 'package:scurry/db_provider.dart';
import 'package:uuid/uuid.dart';

class ScurryModel {
  String? id;
  late String name;

  List<ScurryPic> pics = [];

  late int health;
  late int age;
  late ScurryStage stage;

  List<ScurryInteraction> interactions = [];

  static const String table = 'scurries';

  ScurryModel({required this.name, this.pics=const [], this.interactions=const []}) {
    id = const Uuid().v4();
    if (interactions.isEmpty) {
      interactions.add(ScurryInteraction(interaction: ScurryInteractionKind.born));
    }
    var rand = Random(DateTime.now().millisecondsSinceEpoch);
    health = rand.nextInt(10) + 12;
    age = rand.nextInt(20) + 10;
    stage = ScurryStage.baby;
    pics.every((pic) => pic.scurryId == id);
    interactions.every((action) => action.scurryId == id);
  }

  ScurryModel.fromMap(Map<String, Object?> values) {
    id = values['id'] as String;
    name = values['name'] as String;
    health = values['health'] as int;
    age = values['age'] as int;
    stage = values['stage'] as ScurryStage;
  }

  Map<String, Object?> intoMap() {
    return {
      'id': id,
      'name': name,
      'health': health,
      'age': age,
      'stage': stage as String
    };
  }

  static List<String> get keys => ScurryModel(name: '').intoMap().keys.toList();

  static Future<ScurryModel?> find(String id) async {
    var  db = await DbProvider.open();
    var results = await db.query(table,
      columns: keys,
      where: 'id=?',
      whereArgs: [id],
      limit: 1
    );
    if (results.isNotEmpty) {
      return ScurryModel.fromMap(results.first);
    }
    return null;
  }

  static Future<List<ScurryModel>> findAll() async {
    var db = await DbProvider.open();
    var results = await db.query(table, columns: keys);
    return results.map((e) => ScurryModel.fromMap(e)).toList();
  }

  Future<void> save() async {
    var db = await DbProvider.open();
    var rec = await ScurryModel.find(id!);
    if (rec == null) {
      await db.insert(ScurryModel.table, intoMap());
      return;
    }
    await db.update(ScurryModel.table, intoMap(), where: 'id=?', whereArgs: [id]);
  }

}

class ScurryPic {
  String? id;
  String? scurryId;
  late String path;

  ScurryPic({required this.path});
  ScurryPic.fromMap(Map<String, Object?> values) {
    id = values['id'] as String;
    scurryId = values['scurryId'] as String;
    path = values['path'] as String;
  }

  Map<String, Object?> intoMap() {
    return {
      'id': id,
      'scurryId': scurryId,
      'path': path
    };
  }
}

enum ScurryStage { baby, toddler, teenager, youngAdult, adult, midlife, senior }

enum ScurryInteractionKind { born, fed, pet, aged, complimented, poked }

class ScurryInteraction {
  String? id;
  String? scurryId;
  late ScurryInteractionKind interaction;
  late int interactedAt;

  ScurryInteraction({this.interaction=ScurryInteractionKind.born}) {
    interactedAt = DateTime.now().millisecondsSinceEpoch;
  }
}
