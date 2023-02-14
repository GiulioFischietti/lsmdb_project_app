import 'dart:convert';

import 'package:eventi_in_zona/models/club.dart';
import 'package:eventi_in_zona/models/entity.dart';
import 'package:eventi_in_zona/models/user.dart';
import 'package:objectid/objectid.dart';

class EntityManager extends User {
  late ObjectId managedEntity;
  EntityManager(data) : super(data) {
    managedEntity = data['managedEntity'] != null
        ? ObjectId.fromHexString(data['managedEntity'])
        : ObjectId();
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result.addAll(super.toJson());
    return result;
  }
}
