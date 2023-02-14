import 'package:eventi_in_zona/models/event.dart';
import 'package:eventi_in_zona/repositories/repo.dart';
import 'package:objectid/objectid.dart';

Future<dynamic> searchEvents(body) async {
  return await Repo().postData("event/searchevents", body);
}

Future<dynamic> getSuggestedEvents(int skip, String userId) async {
  return await Repo()
      .getData("event/suggestedevents?userId=$userId&skip=$skip");
}

Future<dynamic> createEvent(Event event) async {
  return await Repo().postData("event/uploadevent", {"data": event.toJson()});
}

Future<dynamic> updateEvent(Event event) async {
  return await Repo().postData("event/updateevent", event.toJson());
}

Future<dynamic> deleteEvent(Event event) async {
  return await Repo().postData("event/deleteevent", event.toJson());
}

Future<dynamic> getEventByIdJson(String id, String userId) async {
  return await Repo().getData("event/eventbyid?_id=$id&userId=$userId");
}

Future<dynamic> getManagerEventByIdJson(ObjectId eventId) async {
  return await Repo()
      .getData("event/managereventbyid?eventId=${eventId.hexString}");
}

Future<dynamic> getEventsByEntity(String entityId, int skip) async {
  return await Repo()
      .getData("event/eventsbyentity?entityId=$entityId&skip=$skip");
}

Future<dynamic> likeEvent(ObjectId eventId, ObjectId userId) async {
  return await Repo().postData("event/likeevent",
      {"eventId": eventId.hexString, "userId": userId.hexString});
}

Future<dynamic> dislikeEvent(ObjectId eventId, ObjectId userId) async {
  return await Repo().postData("event/dislikeevent",
      {"eventId": eventId.hexString, "userId": userId.hexString});
}
