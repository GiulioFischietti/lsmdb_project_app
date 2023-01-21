import 'dart:convert';

import 'package:objectid/objectid.dart';

class User {
  late ObjectId id;
  late String name;
  late String image;
  late String username;
  late String bio;
  late int orderCount;
  late double totalSpent;
  late DateTime createdAt;
  late DateTime updatedAt;

  User(data) {
    id = ObjectId.fromHexString(data['_id']);
    name = data['name'] ?? "";
    orderCount = data['order_count'] ?? 0;
    totalSpent = double.parse((data['order_total'] ?? 0).toString());
    username = data['username'] ?? "";
    bio = data['bio'] ?? "";
    // likesEvents = (data['likesEvents'] as List<dynamic>)
    //     .map((e) => ObjectId.fromHexString(e['_id']))
    //     .toList();
    // followingEntities = (data['followingEntities'] as List<dynamic>)
    //     .map((e) => ObjectId.fromHexString(e))
    //     .toList();
    // reviewedEntities = ((data['reviewedEntities'] ?? []) as List<dynamic>)
    //     .map((e) => ObjectId.fromHexString(e))
    //     .toList();
    image = data['image'] ??
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png";
    createdAt = DateTime.parse(data['createdAt']);
    updatedAt = DateTime.parse(data['updatedAt']);
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result.addAll({"_id": id.hexString});
    result.addAll({'name': name});
    result.addAll({'image': image});
    result.addAll({'username': username});

    // result.addAll({'likesEvents': likesEvents.map((x) => x).toList()});
    // result.addAll(
    //     {'followingEntities': followingEntities.map((x) => x).toList()});

    return result;
  }
}
