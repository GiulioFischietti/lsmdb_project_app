// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
class ReviewAnswerModel {
  String name;
  String image;
  String type;
  DateTime created_at;
  String description;

  ReviewAnswerModel(data) {
    if (data != null) {
      this.name = data['name'];
      this.image = data['image'];
      this.type = data['type'];
      this.description = data['description'];
      this.created_at = data['created_at'] != null
          ? DateTime.parse(data['created_at'])
          : DateTime.now();
    }
  }
  factory ReviewAnswerModel.fromJson(Map<String, dynamic> parsedJson) {
    return ReviewAnswerModel(parsedJson);
  }
}
