import 'package:eventi_in_zona/models/event_minimal.dart';
import 'package:eventi_in_zona/models/lat_lon_location.dart';
import 'package:eventi_in_zona/models/review.dart';
import 'package:objectid/objectid.dart';

class Entity {
  late ObjectId id;
  String name = "";
  String description = "";
  String type = "";
  String image = "";
  String email = "";
  List<String> socialMedias = [];
  List<String> websites = [];
  List<String> phones = [];
  List<Review> reviews = [];
  List<EventMinimal> upcomingEvents = [];

  Entity(data) {
    id = ObjectId.fromHexString(data['_id']);
    name = data['name'] ?? "";
    description = data['description'] ?? "";
    email = data['email'] ?? "";
    phones = ((data['phones'] ?? []) as List).map((e) => e.toString()).toList();

    websites =
        ((data['websites'] ?? []) as List).map((e) => e.toString()).toList();
    socialMedias = ((data['socialMedias'] ?? []) as List)
        .map((e) => e.toString())
        .toList();
    reviews = ((data['reviews'] ?? []) as List).map((e) => Review(e)).toList();
    image = "http://192.168.151.160:3000/images/" +
        (data['image'] ?? data['name'] + ".jpg");
    upcomingEvents = ((data['upcomingEvents'] ?? []) as List)
        .map((e) => EventMinimal(e))
        .toList();
  }

  Entity.fromJson(Map<String, dynamic> data) {
    id = data['id'] ?? 0;
    name = data['name'] ?? "";
    description = data['description'] ?? "";
    image = "http://192.168.151.160:3000/images/" +
        (data['image'] ?? data['name'] + ".jpg");
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
