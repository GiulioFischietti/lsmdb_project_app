// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'package:project_app/Model/EventVModel.dart';

class ShowcaseEventsModel {
  List<EventVModel> _events = [];
  String _title;
  String _description;

  ShowcaseEventsModel(data) {
    this._title = data['title'];
    for (var item in data['data']) {
      this._events.add(new EventVModel(item));
    }
  }
  List<EventVModel> get events {
    return this._events;
  }

  String get title {
    return this._title;
  }

  String get description {
    return this._description;
  }

  factory ShowcaseEventsModel.fromJson(Map<String, dynamic> parsedJson) {
    return ShowcaseEventsModel(parsedJson);
  }
}
