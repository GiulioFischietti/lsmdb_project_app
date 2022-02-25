// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'package:project_app/Model/OrganizerEvent.dart';

import 'artistEventModel.dart';

class ClubModel {
  String id;
  String slug;
  String image;
  String description;
  String name;
  String updated_at;
  String street;
  String address;
  String city;
  String province;
  String province_acronym;
  double latitude;
  double longitude;
  String phone;
  String email;
  String facebook_link;
  bool verified;
  double rating;
  bool followed;
  int follower;
  int rating_count;

  ClubModel(data) {
    this.id = data['_id'];
    this.description = data['description'];
    this.slug = data['slug'];
    this.name = data['name'];
    this.image = data['image'];
    this.phone = data['phone'];
    this.email = data['email'];
    this.address = data['address'];
    this.province = data['province'];
    this.province_acronym = data['province_acronym'];
    this.street = data['street'];
    this.facebook_link = data['facebook_link'];
    this.verified = data['verified'];
    this.longitude = data['location']['coordinates'][0];
    this.latitude = data['location']['coordinates'][1];
    this.rating =
        double.parse(data['rating'] != null ? data['rating'].toString() : "0");
    this.followed = data['followed'] ?? false;
    this.follower = data['follower'];
    this.rating_count = data['rating_count'];
  }

  factory ClubModel.fromJson(Map<String, dynamic> parsedJson) {
    return ClubModel(parsedJson);
  }
}
