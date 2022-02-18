// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names

class ArtistEventModel {
  int _id;
  String _name;
  String _image;
  String _type;

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

  ArtistEventModel(data) {
    this._id = data['id'];
    this._name = data['name'];
    this._image = data['image'];
    this._type = data['type'];
  }
}
