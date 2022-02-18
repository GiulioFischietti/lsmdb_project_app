// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'package:project_app/Model/EventVModel.dart';
import 'package:project_app/Model/OrganizerVModel.dart';

import 'artistVModel.dart';
import 'OrganizerVModel.dart';
import 'ReviewModel.dart';

class ShowcaseReviewsModel {
  List<ReviewModel> reviews = [];
  String title;
  String description;

  ShowcaseReviewsModel(data) {
    this.title = data['title'] ?? "";
    for (var item in data['data']) {
      this.reviews.add(new ReviewModel.fromJson(item));
    }
  }

  factory ShowcaseReviewsModel.fromJson(Map<String, dynamic> parsedJson) {
    return ShowcaseReviewsModel(parsedJson);
  }
}
