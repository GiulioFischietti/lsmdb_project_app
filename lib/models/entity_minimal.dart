// ignore: file_names
import 'dart:convert';

import 'package:objectid/objectid.dart';

class EntityMinimal {
  late ObjectId id;
  String type = "";
  String image = "";
  late String name;

  EntityMinimal(data) {
    id = ObjectId.fromHexString(data['_id']);
    type = data['type'];
    image = "http://192.168.1.4:3000/images/" +
        ((data['image'] as String).replaceAll(".png", ".jpg") ??
            data['name'] + ".jpg");
    name = data['name'];
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'_id': id.hexString});
    result.addAll({'type': type});
    result.addAll(
        {'image': image.replaceAll("http://192.168.1.4:3000/images/", "")});
    result.addAll({'name': name});

    return result;
  }
}
