// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
class OrganizerEventModel {
  String _id;
  String _name;
  String _image;
  String _type;

  String get id {
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

  OrganizerEventModel(data) {
    this._id = data['id'].toString();
    this._name = data['name'];
    this._image = data['image'];
    this._type = data['type'];
  }
}
