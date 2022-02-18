// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
class ClubVModel {
  String name;
  int id;
  int slug;
  String place;
  String image;
  double rating;
  bool live_status;

  ClubVModel(data) {
    this.name = data['name'];
    this.id = data['id'];
    this.image = data['image'];
    this.slug = data['slug'];
    this.live_status = data['live_status'];
    this.place = data['place'];
    this.rating = double.parse(data['rating']);
  }

  factory ClubVModel.fromJson(Map<String, dynamic> parsedJson) {
    return ClubVModel(parsedJson);
  }
}