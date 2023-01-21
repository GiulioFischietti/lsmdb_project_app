import 'package:eventi_in_zona/repositories/repo.dart';
import 'package:objectid/objectid.dart';

Future<dynamic> getNearEventsJson(body) async {
  return await Repo().postData("event/searchevents", body);
}

Future<dynamic> getEventByIdJson(String id, String userId) async {
  return await Repo().getData("event/eventbyid?_id=$id&userId=$userId");
}

Future<dynamic> likeEvent(ObjectId eventId, ObjectId userId) async {
  return await Repo().postData("event/likeevent",
      {"eventId": eventId.hexString, "userId": userId.hexString});
}

Future<dynamic> dislikeEvent(ObjectId eventId, ObjectId userId) async {
  return await Repo().postData("event/dislikeevent",
      {"eventId": eventId.hexString, "userId": userId.hexString});
}
