import 'dart:core';

import "package:objectid/objectid.dart";

import 'entity_minimal.dart';
import 'lat_lon_location.dart';

class Event {
  late ObjectId id;
  late String name;
  late String description;
  late List<String> genres = [];
  late String image;
  late List<EntityMinimal> organizers = [];
  late List<EntityMinimal> artists = [];
  late EntityMinimal club;
  late String address;
  late DateTime start;
  late DateTime end;
  late LatLonLocation location;

  Event(data) {
    id = ObjectId.fromHexString(data['_id']);
    name = data['name'];
    description = data['description'];
    genres = (data['genres'] as List).map((e) => e.toString()).toList();
    image = "http://192.168.151.160:3000/images/" +
        (data['image'] ?? data['name'] + ".jpg");
    organizers =
        (data['organizers'] as List).map((e) => EntityMinimal(e)).toList();
    artists = (data['artists'] as List).map((e) => EntityMinimal(e)).toList();
    club = EntityMinimal(data['club']);
    address = data['address'];
    start = DateTime.parse(data['start']);
    end = DateTime.parse(data['end'] ?? data['expiresAt']);
    location = LatLonLocation(data['location']);
  }
}
