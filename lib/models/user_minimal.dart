import 'dart:convert';

import 'package:objectid/objectid.dart';

class UserMinimal {
  late ObjectId id;
  late String username;
  late String image;

  UserMinimal(data) {
    print(data);
    id = ObjectId.fromHexString(data['_id']);
    username = data['username'];
    image = data['image'];
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'_id': id.hexString});
    result.addAll({'username': username});
    result.addAll({'image': image});

    return result;
  }
}
