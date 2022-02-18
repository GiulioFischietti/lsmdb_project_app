// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
class ArtistVModel {
  String name;
  int id;
  int slug;
  String image;
  double rating;
  bool live_status;

  ArtistVModel(data) {
    this.name = data['name'];
    this.id = data['id'];
    this.image = data['image'];
    this.slug = data['slug'];
    this.live_status = data['live_status'];
    this.rating = double.parse(data['rating']);
  }

  factory ArtistVModel.fromJson(Map<String, dynamic> parsedJson) {
    return ArtistVModel(parsedJson);
  }
}
