// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
class StreamerModel {
  int _id;
  String _name;
  String _image;
  String _type;
  bool following;
  int followers;

  int get id {
    return this._id;
  }

  String get name {
    return this._name;
  }

  String get image {
    return this._image;
  }

  String get type {
    return this._type;
  }

  StreamerModel(data) {
    this._id = data['id'];
    this._name = data['name'];
    this._image = data['image'];
    this._type = data['type'];
    this.followers = data['follower'];
    this.following = data['followed'];
  }
}
