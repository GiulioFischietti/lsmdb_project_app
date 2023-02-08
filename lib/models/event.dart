import 'dart:convert';
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
  late bool likedByUser;
  late DateTime start;
  late DateTime end;
  late LatLonLocation location;
  late double dist;

  Event(data) {
    id = data['_id'] != null ? ObjectId.fromHexString(data['_id']) : ObjectId();
    name = data['name'] ?? "";
    description = data['description'] ?? "";
    likedByUser = data['likedByUser'] ?? false;
    genres = ((data['genres'] ?? []) as List).map((e) => e.toString()).toList();
    image = data['image'] != null
        ? ("http://192.168.1.109:3000/images/" +
            (data['image'] ?? data['name'] + ".jpg"))
        : "";
    organizers = ((data['organizers'] ?? []) as List)
        .map((e) => EntityMinimal(e))
        .toList();
    artists =
        ((data['artists'] ?? []) as List).map((e) => EntityMinimal(e)).toList();
    club = EntityMinimal(data['club'] ?? {});
    address = data['address'] ?? "";
    dist = data['dist'] != null ? data['dist']['calculated'] : 0.0;
    start =
        data['start'] != null ? DateTime.parse(data['start']) : DateTime.now();
    end = data['end'] != null
        ? DateTime.parse(data['end'])
        : DateTime.now().add(const Duration(hours: 5));
    location = LatLonLocation(data['location'] ?? {});
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result.addAll({'_id': id.hexString});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'genres': genres});
    result.addAll({'image': name + " " + start.toIso8601String() + '.jpg'});
    result.addAll({'organizers': organizers.map((e) => e.toJson()).toList()});
    result.addAll({'artists': artists.map((e) => e.toJson()).toList()});
    result.addAll({'club': club.toJson()});
    result.addAll({'address': address});
    result.addAll({'start': start.toIso8601String()});
    result.addAll({'end': end.toIso8601String()});
    result.addAll({'location': location});

    return result;
  }
}
