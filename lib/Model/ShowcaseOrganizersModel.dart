// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'package:project_app/Model/EventVModel.dart';
import 'package:project_app/Model/OrganizerVModel.dart';

import 'OrganizerVModel.dart';

class ShowcaseOrganizersModel {
  List<OrganizerVModel> _organizers = [];
  String _title;
  String _description;

  ShowcaseOrganizersModel(data) {
    this._title = data['title'];
    for (var item in data['data']) {
      this._organizers.add(new OrganizerVModel(item));
    }
  }
  List<OrganizerVModel> get organizers {
    return this._organizers;
  }

  String get title {
    return this._title;
  }

  String get description {
    return this._description;
  }

  factory ShowcaseOrganizersModel.fromJson(Map<String, dynamic> parsedJson) {
    return ShowcaseOrganizersModel(parsedJson);
  }
}
