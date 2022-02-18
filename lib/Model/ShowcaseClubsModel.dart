// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'package:project_app/Model/EventVModel.dart';

import 'ClubVModel.dart';

class ShowcaseClubModel {
  List<ClubVModel> _clubs = [];
  String _title;
  String _description;

  ShowcaseClubModel(data) {
    this._title = data['title'];
    for (var item in data['data']) {
      this._clubs.add(new ClubVModel(item));
    }
  }
  List<ClubVModel> get clubs {
    return this._clubs;
  }

  String get title {
    return this._title;
  }

  String get description {
    return this._description;
  }

  factory ShowcaseClubModel.fromJson(Map<String, dynamic> parsedJson) {
    return ShowcaseClubModel(parsedJson);
  }
}
