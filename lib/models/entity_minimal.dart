// ignore: file_names
import 'dart:convert';

import 'package:objectid/objectid.dart';

class EntityMinimal {
  late ObjectId id;
  String type = "";
  String image = "";
  late String name;
  double avgRate = 0;
  double score = 0;

  EntityMinimal(data) {
    id = data['_id'] != null ? ObjectId.fromHexString(data['_id']) : ObjectId();
    type = data['type'] ?? "";
    image = "http://192.168.1.109:3000/images/" +
        (((data['image'] ?? "") as String).replaceAll(".png", ".jpg") ??
            data['name'] + ".jpg");
    name = data['name'] ?? "";
    avgRate = double.parse((data['avgRate'] ?? 0).toStringAsFixed(2));
    score = double.parse((data['score'] ?? 0).toStringAsFixed(2));
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'_id': id.hexString});
    result.addAll({'type': type});
    result.addAll(
        {'image': image.replaceAll("http://192.168.1.109:3000/images/", "")});
    result.addAll({'name': name});

    return result;
  }
}
