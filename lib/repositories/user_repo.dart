import 'package:eventi_in_zona/repositories/repo.dart';
import 'package:objectid/objectid.dart';

Future<dynamic> likeEvent(
    ObjectId userId, ObjectId eventId, DateTime start) async {
  return await Repo().postData("user/likeevent", {
    "userId": userId.hexString,
    "eventId": eventId.hexString,
    "start": start.toIso8601String()
  });
}

Future<dynamic> dislikeEvent(
    ObjectId userId, ObjectId eventId, DateTime start) async {
  return await Repo().postData("user/dislikeevent", {
    "userId": userId.hexString,
    "eventId": eventId.hexString,
    "start": start.toIso8601String()
  });
}

Future<dynamic> followEntity(ObjectId userId, ObjectId entityId) async {
  return await Repo().postData("user/followentity",
      {"userId": userId.hexString, "entityId": entityId.hexString});
}

Future<dynamic> unFollowEntity(ObjectId userId, ObjectId entityId) async {
  return await Repo().postData("user/unfollowentity",
      {"userId": userId.hexString, "entityId": entityId.hexString});
}
