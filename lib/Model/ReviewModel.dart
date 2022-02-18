// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'ReviewAnswer.dart';

class ReviewModel {
  int id;
  String slug;
  String username;
  String name;
  String type;
  String link;
  double rating;
  String description;
  ReviewAnswerModel response;
  String image;
  DateTime created_at;

  ReviewModel(data) {
    this.id = data['id'] ?? 0;
    this.created_at = DateTime.parse(data['created_at']) ?? DateTime.now();
    this.slug = data['slug']?.toString() ?? "";
    this.username = data['username'] ?? "";
    this.name = data['username'] ?? "";
    this.type = data['type'] ?? "";
    this.link = data['link'] ?? "";
    this.rating = double.parse(data['rating']?.toString()) ?? 0;
    this.description = data['description'] ?? "";
    if (data['response'] != null) {
      this.response = ReviewAnswerModel.fromJson(data['response']);
    }
    this.image = data['image'] ?? "";
  }

  factory ReviewModel.fromJson(Map<String, dynamic> parsedJson) {
    return ReviewModel(parsedJson);
  }
}
