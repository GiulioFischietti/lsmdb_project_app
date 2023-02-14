import 'package:eventi_in_zona/models/app_user.dart';
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

Future<dynamic> getSuggestedFriendsBasedOnLikes(
    ObjectId userId, int skip) async {
  return await Repo().postData("user/suggestedfriendsbasedonlikes",
      {"userId": userId.hexString, "skip": skip});
}

Future<dynamic> dislikeEvent(
    ObjectId userId, ObjectId eventId, DateTime start) async {
  return await Repo().postData("user/dislikeevent", {
    "userId": userId.hexString,
    "eventId": eventId.hexString,
    "start": start.toIso8601String()
  });
}

Future<dynamic> followersOfUser(ObjectId userId, int skip) async {
  return await Repo()
      .postData("user/followers", {"userId": userId.hexString, "skip": skip});
}

Future<dynamic> likedEvents(int skip, ObjectId userId) async {
  return await Repo()
      .postData("user/likedevents", {"skip": skip, "userId": userId.hexString});
}

Future<dynamic> followingsOfUser(ObjectId userId, int skip) async {
  return await Repo()
      .postData("user/followings", {"userId": userId.hexString, "skip": skip});
}

Future<dynamic> followUser(ObjectId myUserId, ObjectId userId) async {
  return await Repo().postData("user/followuser",
      {"userId": userId.hexString, "myUserId": myUserId.hexString});
}

Future<dynamic> unfollowUser(ObjectId myUserId, ObjectId userId) async {
  return await Repo().postData("user/unfollowuser",
      {"userId": userId.hexString, "myUserId": myUserId.hexString});
}

Future<dynamic> followEntity(ObjectId userId, ObjectId entityId) async {
  return await Repo().postData("user/followentity",
      {"userId": userId.hexString, "entityId": entityId.hexString});
}

Future<dynamic> unFollowEntity(ObjectId userId, ObjectId entityId) async {
  return await Repo().postData("user/unfollowentity",
      {"userId": userId.hexString, "entityId": entityId.hexString});
}

Future<dynamic> editUser(AppUser user) async {
  return await Repo().postData("user/edituser", user.toJson());
}
