// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'package:project_app/Model/OrganizerEvent.dart';

class EventVModel {
  int _id;
  int _slug;
  String _name;
  String _image;
  DateTime _start;
  DateTime _end;
  String _musicalGenre;
  String _place;
  bool _live;
  OrganizerEventModel _organizer;

  String get name {
    return this._name;
  }

  String get place {
    return this._place;
  }

  int get id {
    return this._id;
  }

  int get slug {
    return this._slug;
  }

  String get image {
    return this._image;
  }

  DateTime get start {
    return this._start;
  }

  DateTime get end {
    return this._end;
  }

  String get musicalGenre {
    return this._musicalGenre;
  }

  bool get live {
    return this._live;
  }

  OrganizerEventModel get organizer {
    return this._organizer;
  }

  EventVModel(data) {
    this._id = data['id'];
    this._slug = data['slug'];
    this._name = data['name'];
    this._image = data['image'];
    this._start = DateTime.parse(data['start']);
    this._end = DateTime.parse(data['end']);
    this._musicalGenre = data['musicalGenre'];
    this._place = data['place'];
    this._live = data['live'];
    this._organizer = OrganizerEventModel(data['organizer']);
  }
}
