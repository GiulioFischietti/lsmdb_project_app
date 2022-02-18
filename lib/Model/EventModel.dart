// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'package:project_app/Model/OrganizerEvent.dart';

import 'artistEventModel.dart';

class EventModel {
  int id;
  String slug;
  DateTime start;
  DateTime end;
  bool place;

  bool live;
  bool live_status;

  String image;
  String description;
  String name;
  String updated_at;
  String genres;
  bool saved;
  String views;

  String street;
  String city;
  String province;
  String province_acronym;
  double latitude;
  double longitude;

  OrganizerEventModel organizer;
  List<OrganizerEventModel> other_organizers = [];
  List<ArtistEventModel> artists = [];

  EventModel(data) {
    this.id = data['id'];
    this.slug = data['slug'];
    this.name = data['name'];
    this.image = data['image'];
    this.street = data['street'];
    this.saved = data['saved'];
    this.province = data['province'];
    this.province_acronym = data['province_acronym'];
    this.start = DateTime.parse(data['start']);
    this.end = DateTime.parse(data['end']);
    this.genres = data['genres'];
    this.place = data['place'];
    this.live = data['live'];
    this.description = data['description'];
    this.city = data['city'];
    this.latitude = data['latitude'];
    this.longitude = data['longitude'];
    this.organizer = OrganizerEventModel(data['organizer']);

    for (var x in data['other_organizers']) {
      this.other_organizers.add(OrganizerEventModel(x));
    }
    for (var x in data['artists']) {
      print(x['name']);
      this.artists.add(ArtistEventModel(x));
    }
  }
  factory EventModel.fromJson(Map<String, dynamic> parsedJson) {
    return EventModel(parsedJson);
  }
}
