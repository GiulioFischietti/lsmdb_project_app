import 'package:eventi_in_zona/models/event.dart';
import 'package:eventi_in_zona/repositories/event_repo.dart';
import 'package:flutter/cupertino.dart';

class EventProvider extends ChangeNotifier {
  late Event event;
  bool loading = false;

  void getEventById(String id) async {
    loading = true;
    notifyListeners();
    var json = await getEventByIdJson(id);
    event = Event(json['data']);
    loading = false;
    notifyListeners();
  }
}
