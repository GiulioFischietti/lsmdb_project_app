// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'package:project_app/Model/OrganizerEvent.dart';

class EventVModel {
  int id;
  int slug;
  String name;
  String image;
  DateTime start;
  DateTime end;
  String musicalGenre = "";
  String place;
  bool live;
  OrganizerEventModel organizer;

  EventVModel(data) {
    this.id = data['id'];
    this.slug = data['slug'];
    this.name = data['name'];
    this.image = data['image'];
    this.start = DateTime.parse(data['start']);
    this.end = DateTime.parse(data['end']);
    int i = 0;
    for (String genre in data['genres']) {
      this.musicalGenre += (i != 0 ? (", " + genre) : (genre));
      i++;
    }

    this.place = data['address'];
    // this.live = data['live'];
    this.organizer = OrganizerEventModel(data['club']);
  }
}
