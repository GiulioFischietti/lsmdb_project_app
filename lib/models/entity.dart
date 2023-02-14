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
  late double relevance;
  List<String> socialMedias = [];
  List<String> websites = [];
  List<String> phones = [];
  List<Review> reviews = [];
  List<ObjectId> reviewIds = [];
  late int nFollowers;
  late int nReviews;
  List<EventMinimal> upcomingEvents = [];

  Map<String, dynamic> toJson() => {
        '_id': id.hexString,
        'name': name,
        'type': type,
        'image': image.replaceAll("http://192.168.1.109:3000/images/", "")
      };

  Map<String, dynamic> toJsonComplete() => {
        '_id': id.hexString,
        'name': name,
        'type': type,
        'image': image.replaceAll("http://192.168.1.109:3000/images/", ""),
        'email': email,
        'socialMedias': socialMedias,
        'websites': websites,
        'description': description,
        'phones': phones
      };

  Entity(data) {
    id = data['_id'] != null ? ObjectId.fromHexString(data['_id']) : ObjectId();
    name = data['name'] ?? "";
    type = data['type'] ?? "";
    followedByUser = data['followedByUser'] ?? false;
    reviewedByUser = data['reviewedByUser'] ?? false;
    description = data['description'] ?? "";
    email = data['email'] ?? "";
    avgRate = double.parse((data['avgRate'] ?? 0).toStringAsFixed(2));
    nFollowers = data['nFollowers'] ?? 0;
    relevance = double.parse((data['relevance'] ?? 0).toStringAsFixed(2));
    phones = ((data['phones'] ?? []) as List).map((e) => e.toString()).toList();

    websites =
        ((data['websites'] ?? []) as List).map((e) => e.toString()).toList();
    socialMedias = ((data['socialMedias'] ?? []) as List)
        .map((e) => e.toString())
        .toList();

    reviewIds = ((data['reviewIds'] ?? []) as List)
        .map((e) => ObjectId.fromHexString(e))
        .toList();
    nReviews = data['nReviews'] ?? 0;
    image = "http://192.168.1.109:3000/images/" +
        (((data['image'] ?? "") as String).replaceAll(".png", ".jpg") ??
            data['name'] + ".jpg");
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
