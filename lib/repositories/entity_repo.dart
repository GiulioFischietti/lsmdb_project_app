import 'package:eventi_in_zona/models/entity.dart';
import 'package:eventi_in_zona/models/review.dart';
import 'package:eventi_in_zona/repositories/repo.dart';
import 'package:objectid/objectid.dart';

Future<dynamic> getNearClubsJson(body) async {
  return await Repo().postData("entity/search", body);
}

Future<dynamic> getTopRated(int skip) async {
  return await Repo().getData("entity/topratedentities?skip=$skip");
}

Future<dynamic> getEntityByIdJson(String id, String userId) async {
  return await Repo().getData("entity/entitybyid?_id=$id&userId=$userId");
}

Future<dynamic> addReviewEntity(Review review) async {
  return await Repo().postData("entity/addreview", review);
}

Future<dynamic> followEntity(ObjectId entityId, ObjectId userId) async {
  return await Repo().postData("entity/followentity",
      {"entityId": entityId.hexString, "userId": userId.hexString});
}

Future<dynamic> unfollowEntity(ObjectId entityId, ObjectId userId) async {
  return await Repo().postData("entity/unfollowentity",
      {"entityId": entityId.hexString, "userId": userId.hexString});
}

Future<dynamic> updateEntity(ObjectId userId, Entity entity) async {
  return await Repo().postData("entity/updateentity",
      {"userId": userId.hexString, "entity": entity.toJsonComplete()});
}

Future<dynamic> searchEntity(String keyword, String type) async {
  return await Repo()
      .postData("entity/search", {"keyword": keyword, "type": type});
}
