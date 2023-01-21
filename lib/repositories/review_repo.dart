import 'package:eventi_in_zona/models/review.dart';
import 'package:eventi_in_zona/repositories/repo.dart';
import 'package:objectid/objectid.dart';

Future<dynamic> addReview(Review review) async {
  return await Repo().postData("review/addreview", review.toJson());
}

Future<dynamic> editReview(Review review) async {
  return await Repo().postData("review/editreview",
      {"reviewId": review.id.hexString, "review": review.toJson()});
}

Future<dynamic> getReviewByIds(List<ObjectId> reviewIds) async {
  return await Repo().postData("review/getreviewsbyid",
      {"reviewIds": reviewIds.map((e) => e.hexString).toList()});
}

Future<dynamic> deleteReviewEntity(
    ObjectId entityId, ObjectId reviewId, ObjectId userId) async {
  return await Repo().postData("review/deletereview", {
    "entityId": entityId.hexString,
    "reviewId": reviewId.hexString,
    "userId": userId.hexString
  });
}
