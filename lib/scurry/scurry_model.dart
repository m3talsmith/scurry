class ScurryModel {
  String? id;
  late String name;

  List<ScurryPic> pics = [];

  late int health;
  late int age;
  late ScurryStage stage;

  List<ScurryInteraction> interactions = [];
}

class ScurryPic {
  String? id;
  String? scurryId;
  late String path;
}

enum ScurryStage { baby, toddler, teenager, youngAdult, adult, midlife, senior }

enum ScurryInteractionKind { born, fed, pet, aged, complimented, poked }

class ScurryInteraction {
  String? id;
  String? scurryId;
  late ScurryInteractionKind interaction;
  late int interactedAt;
}
