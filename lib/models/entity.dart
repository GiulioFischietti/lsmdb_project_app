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
  bool followedByUser = false;
  bool reviewedByUser = false;
  late double avgRate;
  List<String> socialMedias = [];
  List<String> websites = [];
  List<String> phones = [];
  List<Review> reviews = [];
  List<ObjectId> reviewIds = [];
  late int nReviews;
  List<EventMinimal> upcomingEvents = [];

  Map<String, dynamic> toJson() => {
        '_id': id.hexString,
        'name': name,
        'type': type,
        'image': image.replaceAll("http://192.168.1.109:3000/images/", "")
      };

  Entity(data) {
    id = ObjectId.fromHexString(data['_id']);
    name = data['name'] ?? "";
    type = data['type'];
    followedByUser = data['followedByUser'];
    reviewedByUser = data['reviewedByUser'];
    description = data['description'] ?? "";
    email = data['email'] ?? "";
    avgRate = double.parse((data['avgRate'] ?? 0).toStringAsFixed(2));
    phones = ((data['phones'] ?? []) as List).map((e) => e.toString()).toList();

    websites =
        ((data['websites'] ?? []) as List).map((e) => e.toString()).toList();
    socialMedias = ((data['socialMedias'] ?? []) as List)
        .map((e) => e.toString())
        .toList();

    reviewIds = ((data['reviewIds'] ?? []) as List)
        .map((e) => ObjectId.fromHexString(e))
        .toList();
    nReviews = reviewIds.length;
    image = "http://192.168.1.109:3000/images/" +
        (data['image'] ?? data['name'] + ".jpg");
    upcomingEvents = ((data['upcomingEvents'] ?? []) as List)
        .map((e) => EventMinimal(e))
        .toList();
    reviews = ((data['reviews'] ?? []) as List).map((dynamic e) {
      // e =
      (e as Map<String, dynamic>).addAll({'entity': this.toJson()});
      return Review(e);
    }).toList();
  }
}
