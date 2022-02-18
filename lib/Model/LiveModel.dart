// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'package:project_app/Model/OrganizerEvent.dart';
import 'package:project_app/View/Entities/Organizer.dart';

import 'artistEventModel.dart';
import 'StreamerModel.dart';

class LiveModel {
  int id;
  int slug;

  String live_url;
  bool live_status;

  String image;
  String description;
  String name;
  String updated_at;
  List<dynamic> genres;

  StreamerModel streamer;

  LiveModel(data) {
    this.id = data['id'];
    this.slug = data['slug'];
    this.name = data['name'];
    this.image = data['image'];
    this.streamer = StreamerModel(data['streamer']);
    this.genres = data['genres'];
    this.live_url = data['live_url'];
    this.description = data['description'];
    this.live_status = data['live_status'];
  }
  factory LiveModel.fromJson(Map<String, dynamic> parsedJson) {
    return LiveModel(parsedJson);
  }
}
