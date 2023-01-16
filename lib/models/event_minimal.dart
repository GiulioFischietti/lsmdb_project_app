import 'dart:core';

import 'package:eventi_in_zona/repositories/repo.dart';
import "package:objectid/objectid.dart";

import 'entity_minimal.dart';
import 'lat_lon_location.dart';

class EventMinimal {
  late ObjectId id;
  late String name;
  late List<String> genres = [];
  late String image;
  late EntityMinimal club;
  late String address;
  late LatLonLocation location;
  late DateTime start;
  late DateTime end;

  EventMinimal(data) {
    id = ObjectId.fromHexString(data['_id']);
    name = data['name'];
    genres = (data['genres'] as List).map((e) => e.toString()).toList();
    image = "http://192.168.151.160:3000/images/" +
        (data['image'] ?? data['name'] + ".jpg");
    address = data['address'];
    location = LatLonLocation(data['location']);
    start = DateTime.parse(data['start']);
    if (data['end'] != null) {
      end = DateTime.parse(data['end']);
    }
  }
}
