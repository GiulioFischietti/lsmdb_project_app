import 'dart:convert';

import 'package:objectid/objectid.dart';

class RegisteredUser {
  late ObjectId id;
  late String name;
  late String image;
  late String username;
  late DateTime createdAt;
  late DateTime updatedAt;

  RegisteredUser(data) {
    id = data['_id'] != null ? ObjectId.fromHexString(data['_id']) : ObjectId();
    name = data['name'] ?? "";
    username = data['username'] ?? "";
    image = "http://192.168.1.109:3000/user_images/" + data['image'] ??
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png";
    createdAt = data['createdAt'] != null
        ? DateTime.parse(data['createdAt'])
        : DateTime.now();
    updatedAt = data['updatedAt'] != null
        ? DateTime.parse(data['updatedAt'])
        : DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result.addAll({"_id": id.hexString});
    result.addAll({'name': name});
    result.addAll({'image': image});
    result.addAll({'username': username});
    return result;
  }
}
