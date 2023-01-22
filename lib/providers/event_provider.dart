import 'package:eventi_in_zona/models/event.dart';
import 'package:eventi_in_zona/models/event_minimal.dart';
import 'package:eventi_in_zona/repositories/event_repo.dart' as eventRepo;
import 'package:eventi_in_zona/repositories/location_repo.dart';
import 'package:eventi_in_zona/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:objectid/objectid.dart';

class EventProvider extends ChangeNotifier {
  late Event event;

  List<EventMinimal> searchResults = [];
  Map<String, dynamic> locationSearch = {};
  String genreSearch = "Non specificato";
  DateTime dateSearch = DateTime.now();
  double maxDistance = 100;

  bool loading = false;

  void searchEvents(BuildContext context) async {
    loading = true;
    notifyListeners();

    Map<String, dynamic> body = {
      "lat": double.parse(locationSearch['lat']),
      "lon": double.parse(locationSearch['lon']),
      "start": dateSearch.toIso8601String().split("T")[0],
      "maxDistance": maxDistance * 1000,
    };
    if (genreSearch != "") {
      body.addAll({"genres": genreSearch});
    }
    print(body);
    var json = await eventRepo.searchEvents(body);
    searchResults = (json['data'] as List).map((e) => EventMinimal(e)).toList();
    loading = false;
    notifyListeners();
  }

  void getEventById(String id, String userId) async {
    loading = true;
    notifyListeners();
    var json = await eventRepo.getEventByIdJson(id, userId);
    event = Event(json['data']);
    loading = false;
    notifyListeners();
  }

  void likeEvent(ObjectId userId) {
    event.likedByUser = true;
    notifyListeners();
    eventRepo.likeEvent(event.id, userId);
  }

  void dislikeEvent(ObjectId userId) {
    event.likedByUser = false;
    notifyListeners();
    eventRepo.dislikeEvent(event.id, userId);
  }
}