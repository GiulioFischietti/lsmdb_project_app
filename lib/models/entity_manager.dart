import 'dart:convert';

import 'package:eventi_in_zona/models/club.dart';
import 'package:eventi_in_zona/models/entity.dart';
import 'package:eventi_in_zona/models/user.dart';
import 'package:objectid/objectid.dart';

class EntityManager extends User {
  late Club managedEntity;
  EntityManager(data) : super(data) {
    managedEntity = Club(data['managedEntity'] ?? {});
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result.addAll(super.toJson());
    return result;
  }
}