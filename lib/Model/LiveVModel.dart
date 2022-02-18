// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'OrganizerEvent.dart';

class LiveVModel {
  String name;
  int id;
  int slug;
  String image;
  bool live_status;
  List<dynamic> genres;
  OrganizerEventModel streamer;

  LiveVModel(data) {
    this.name = data['name'];
    this.id = data['id'];
    this.image = data['image'];
    this.slug = data['slug'];
    this.live_status = data['live_status'];
    this.genres = data['genres'];
    this.streamer = OrganizerEventModel(data['streamer']);
  }

  factory LiveVModel.fromJson(Map<String, dynamic> parsedJson) {
    return LiveVModel(parsedJson);
  }
}
