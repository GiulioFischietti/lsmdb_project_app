import 'package:eventi_in_zona/models/user.dart';
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

Future<dynamic> getUser(ObjectId userId) async {
  return await Repo().getData("user/userbyid?_id=${userId.hexString}");
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

Future<dynamic> editUser(User user) async {
  return await Repo().postData("user/edituser", user.toJson());
}
