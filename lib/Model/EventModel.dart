// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'package:project_app/Model/OrganizerEvent.dart';

import 'artistEventModel.dart';

class EventModel {
  String id;
  String slug;
  DateTime start;
  DateTime end;
  bool place;
  String address;

  bool live;
  bool live_status;

  String image;
  String description;
  String name;
  String updated_at;
  String genres = "";
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
    this.id = data['_id'];
    this.slug = data['slug'];
    this.name = data['name'];
    this.image = data['image'];
    this.street = data['street'];
    this.saved = data['saved'] ?? false;
    this.province = data['province'];
    this.province_acronym = data['province_acronym'];
    this.start = DateTime.parse(data['start']);
    this.end = DateTime.parse(data['end']);
    int i = 0;
    for (String genre in data['genres']) {
      this.genres += (i != 0 ? (", " + genre) : (genre));
      i++;
    }
    this.place = data['place'] == 1 ? true : false;
    this.live = data['live'];
    this.address = data['address'];
    this.description = data['description'];
    this.city = data['city'];
    this.latitude = data['location']['coordinates'][0];
    this.longitude = data['location']['coordinates'][1];

    this.organizer = OrganizerEventModel(data['organizer'] ?? data['club']);

    if (data['other_organizers'] != null) {
      for (var x in data['other_organizers']) {
        this.other_organizers.add(OrganizerEventModel(x));
      }
    }
    if (data['artists'] != null) {
      for (var x in data['artists']) {
        print(x['name']);
        this.artists.add(ArtistEventModel(x));
      }
    }
  }
  factory EventModel.fromJson(Map<String, dynamic> parsedJson) {
    return EventModel(parsedJson);
  }
}
