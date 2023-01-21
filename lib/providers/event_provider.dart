import 'package:eventi_in_zona/models/event.dart';
import 'package:eventi_in_zona/repositories/event_repo.dart' as eventRepo;
import 'package:flutter/cupertino.dart';
import 'package:objectid/objectid.dart';

class EventProvider extends ChangeNotifier {
  late Event event;
  bool loading = false;

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
