// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'LiveVModel.dart';

class ShowcaseLiveModel {
  List<LiveVModel> _live = [];
  String _title;
  String _description;

  ShowcaseLiveModel(data) {
    this._title = data['title'];
    for (var item in data['data']) {
      this._live.add(new LiveVModel(item));
    }
  }
  List<LiveVModel> get live {
    return this._live;
  }

  String get title {
    return this._title;
  }

  String get description {
    return this._description;
  }

  factory ShowcaseLiveModel.fromJson(Map<String, dynamic> parsedJson) {
    return ShowcaseLiveModel(parsedJson);
  }
}
