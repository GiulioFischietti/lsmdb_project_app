import 'dart:convert';

import 'package:objectid/objectid.dart';

class UserMinimal {
  late ObjectId id;
  late String username;
  late String name;
  late String image;

  UserMinimal(data) {
    id = ObjectId.fromHexString(data['_id']);
    username = data['username'];
    name = data['name'] ?? "";
    image = "http://192.168.1.109:3000/user_images/" + data['image'];
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'_id': id.hexString});
    result.addAll({'username': username});
    result.addAll({'name': name});
    result.addAll({'image': image});

    return result;
  }
}
