import 'dart:convert';

import 'package:objectid/objectid.dart';

import 'package:eventi_in_zona/models/entity_minimal.dart';
import 'package:eventi_in_zona/models/user_minimal.dart';

class Review {
  late ObjectId id;
  late String description;
  late int rate;
  late DateTime createdAt;
  List<String> images = [];
  late DateTime updatedAt;
  late EntityMinimal entity;
  late UserMinimal user;

  Review(data) {
    try {
      id = ObjectId.fromHexString(data['_id']);
      description = data['description'];
      rate = data['rate'];
      createdAt = DateTime.parse(data['createdAt']);
      images = ((data['images'] ?? []) as List)
          .map((item) => item as String)
          .toList();
      updatedAt = DateTime.parse(data['updatedAt'] ?? data['createdAt']);
      entity = EntityMinimal(data['entity']);
      user = UserMinimal(data['user']);
    } catch (e) {
      id = ObjectId();
      description = "";
      rate = 0;
      createdAt = DateTime.now();
      updatedAt = DateTime.now();
      // user = UserMinimal({})
    }
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'description': description});
    result.addAll({'rate': rate});
    result.addAll({'entity': entity.toJson()});
    result.addAll({'user': user.toJson()});

    return result;
  }

  Map<String, dynamic> toEmbeddedJson() {
    final result = <String, dynamic>{};

    result.addAll({'_id': id.hexString});
    result.addAll({'description': description});
    result.addAll({'rate': rate});
    result.addAll({'user': user.toJson()});

    return result;
  }
}
