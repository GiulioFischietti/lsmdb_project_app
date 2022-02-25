// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
class ArtistModel {
  String id;
  String slug;

  String image;
  String description;
  String name;
  String updated_at;

  double latitude;
  double longitude;
  String phone;
  String email;
  String facebook_link;
  bool verified;
  double rating;
  bool followed;
  int follower;
  int rating_count;

  ArtistModel(data) {
    this.id = data['_id'];
    this.description = data['description'];
    this.slug = data['slug'];
    this.name = data['name'];
    this.image = data['image'];
    this.phone = data['phone'];
    this.email = data['email'];
    this.facebook_link = data['facebook_link'];
    this.verified = data['verified'];
    this.rating = double.parse(data['rating'].toString());
    this.followed = data['followed'];
    this.follower = data['follower'];
    this.rating_count = data['rating_count'];
  }

  factory ArtistModel.fromJson(Map<String, dynamic> parsedJson) {
    return ArtistModel(parsedJson);
  }
}
