import 'package:eventi_in_zona/models/artist.dart';
import 'package:eventi_in_zona/models/club.dart';
import 'package:eventi_in_zona/models/entity.dart';
import 'package:eventi_in_zona/models/event.dart';
import 'package:eventi_in_zona/models/organizer.dart';
import 'package:eventi_in_zona/repositories/entity_repo.dart';
import 'package:eventi_in_zona/repositories/event_repo.dart';
import 'package:flutter/cupertino.dart';

class EntityProvider extends ChangeNotifier {
  late Club club;
  late Artist artist;
  late Organizer organizer;
  bool loading = false;

  void getEntityById(String id) async {
    loading = true;
    notifyListeners();
    var json = await getEntityByIdJson(id);
    switch (json['data']['type']) {
      case "club":
        club = Club(json['data']);
        break;
      case "artist":
        artist = Artist(json['data']);
        break;
      case "organizer":
        organizer = Organizer(json['data']);
        break;
      default:
    }

    loading = false;
    notifyListeners();
  }
}
