// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'package:project_app/Model/EventVModel.dart';
import 'package:project_app/Model/OrganizerVModel.dart';

import 'artistVModel.dart';
import 'OrganizerVModel.dart';

class ShowcaseArtistsModel {
  List<ArtistVModel> _artists = [];
  String _title;
  String _description;

  ShowcaseArtistsModel(data) {
    this._title = data['title'];
    for (var item in data['data']) {
      this._artists.add(new ArtistVModel(item));
    }
  }
  List<ArtistVModel> get artists {
    return this._artists;
  }

  String get title {
    return this._title;
  }

  String get description {
    return this._description;
  }

  factory ShowcaseArtistsModel.fromJson(Map<String, dynamic> parsedJson) {
    return ShowcaseArtistsModel(parsedJson);
  }
}
