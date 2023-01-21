import 'dart:core';

import 'package:eventi_in_zona/repositories/repo.dart';
import "package:objectid/objectid.dart";

import 'entity_minimal.dart';

class EventMinimal {
  late ObjectId id;
  late String name;
  late List<String> genres = [];
  late String image;
  late EntityMinimal club;
  late String address;
  late DateTime start;
  late DateTime end;
  late double dist;

  EventMinimal(data) {
    id = ObjectId.fromHexString(data['_id']);
    name = data['name'];
    dist = data['dist'] != null ? data['dist']['calculated'] : 0.0;
    genres = (data['genres'] as List).map((e) => e.toString()).toList();
    image = "http://192.168.1.109:3000/images/" +
        (data['image'] ?? data['name'] + ".jpg");
    address = data['address'] ?? "";

    start = DateTime.parse(data['start']);
    if (data['end'] != null) {
      end = DateTime.parse(data['end']);
    }
  }
}
